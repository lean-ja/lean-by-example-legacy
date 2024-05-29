/-
# Functional but in-place

## 参照透過性
Lean は **純粋関数型言語** です．これはすべての関数が純粋で **参照透過性(referential transparency)** を持つことを意味します．ここで関数 `f` が参照透過であるとは，次を意味します．

* 引数として同じ値を与えると毎回同じ値を返し，
* 式の値の評価以外の **副作用(side effect)** を生まない

特に変数 `a` の値を参照する関数を考えると，関数の値が変わらないことから，変数 `a` の値は変更できないということがわかります．実際に Lean ではすべての変数は一度値を束縛すると値を変更できません．参照透過性を守るために，Lean は必要に応じて変数の値のコピーを行います．
-/

-- foo という変数を定義する
def foo := "hello"

-- 再定義しようとするとエラーになる
/-- error: 'foo' has already been declared -/
#guard_msgs in def foo := "hello world"

-- 関数の内部で同名の `foo` という変数を定義することはできる
#eval show IO Unit from do
  let foo := foo ++ " world"
  IO.println foo

-- しかしグローバル変数としての `foo` の値は "hello" のまま変わっていない
#guard foo = "hello"

/-
## 値の破壊的変更
しかし，Lean で変数の値の破壊的変更ができないわけではありません．できないどころか，容易に変数の値の破壊的変更を行うことができます．ここで破壊的変更とは，変数の値をコピーすることなく，in-place に値が変更されることを指します．次の例では，配列の値の変更が in-place に行われていることを確かめることができます．-/

-- Lean のオブジェクトのメモリ上でのアドレスを取得する関数
-- 参照透過性を壊すため，unsafe である
#eval ptrAddrUnsafe #[1, 2, 3]

/-- フィボナッチ数列を計算する -/
unsafe def fibonacci (n : Nat) : Array Nat := Id.run do
  -- 可変な配列 `fib` を宣言している
  let mut fib : Array Nat := Array.mkEmpty n
  fib := fib.push 0
  fib := fib.push 1
  for i in [2:n] do
    -- ここで配列 `fib` のメモリアドレスを表示させている
    dbg_trace ptrAddrUnsafe fib
    fib := fib.push (fib[i-1]! + fib[i-2]!)
  return fib

-- 値がコピーされていれば異なるメモリアドレスが表示されるはずだが...?
#eval fibonacci 15

/-
## Functional but in-place
なぜこのような現象が起こるのでしょうか？答えは，Lean が値の不要なコピーを行わないためです．具体的には，Lean は参照カウントがちょうど 1 であるような値を更新する際に，コピーして新しい値を生成する代わりに破壊的変更を行います．参照カウントが 1 の値はグローバル変数ではありませんし，その値を束縛している変数がその値を参照しているだけであるため，その値を変更しても参照透過性は保たれます．これを指して，Lean 言語のパラダイムのことを **Functional but in-place** と呼びます．[^fbip]

変数の参照カウントを調べるための関数も用意されており，次の例のようなコードで検証を行うことができます．
-/

-- `α` は型で，`α` の要素の大小比較ができる
variable {α : Type} [Ord α]

-- コンパイラによる最適化が行われないようにし，
-- `dbgTraceIfShared` の直観的でない挙動を防ぐために `noinline` 属性を付与
@[noinline]
def Array.checkedSwap (a : Array α) (i j : Fin a.size) : Array α :=
  -- `dbgTraceIfShared` 関数は，引数の参照カウントが 1 より大きいときにメッセージを表示する
  -- これは，破壊的変更ができない場合に警告を出すと言ってもよい
  dbgTraceIfShared "array shared!" a |>.swap i j

/-- 挿入ソートのヘルパ関数.
要素 `arr[i]` を `arr[i-1]` と比較して，
`arr[i-1] ≤ arr[i]` となるように要素を入れ替える -/
def insertSorted (arr : Array α) (i : Fin arr.size) : Array α :=
  match i with
  | ⟨0, _⟩ => arr
  | ⟨i' + 1, _⟩ =>
    have : i' < arr.size := by
      simp [Nat.lt_of_succ_lt, *]
    match Ord.compare arr[i'] arr[i] with
    | .lt | .eq => arr
    | .gt =>
      -- 再帰呼び出しのたびに "called swap" を表示させる
      dbg_trace "called swap"

      -- 上で定義した `checkedSwap` を呼んで配列の値の swap を行う
      insertSorted
        (arr.checkedSwap ⟨i', by assumption⟩ i)
        ⟨i', by simp [Array.checkedSwap, dbgTraceIfShared, *]⟩

/-- 挿入ソートのヘルパ関数 -/
partial def insertionSortLoop (arr : Array α) (i : Nat) : Array α :=
  if h : i < arr.size then
    insertionSortLoop (insertSorted arr ⟨i, h⟩) (i + 1)
  else
    arr

/-- 挿入ソート -/
def insertionSort (arr : Array α) : Array α :=
  insertionSortLoop arr 0

def sample_array := #[1, 3, 2, 8, 10, 1, 1, 15, 2]

-- `swap` は何度も実行されているが，最初の一回だけ `shared RC ...` メッセージが表示される
-- 最初の一回はグローバル変数 `sample_array` が引数として与えられているので，破壊的変更は許されない
-- 後の呼び出しでは参照カウントが 1 になっていて，破壊的変更が許される状況
/--
info: called swap
shared RC array shared!
called swap
called swap
called swap
called swap
called swap
called swap
called swap
called swap
called swap
called swap
called swap
called swap
#[1, 1, 1, 2, 2, 3, 8, 10, 15]
-/
#guard_msgs in #eval insertionSort sample_array

/-!
[^fbip]: Moura, L.d., Ullrich, S. (2021). The Lean 4 Theorem Prover and Programming Language. In: Platzer, A., Sutcliffe, G. (eds) Automated Deduction – CADE 28. CADE 2021. Lecture Notes in Computer Science(), vol 12699. Springer, Cham. <https://doi.org/10.1007/978-3-030-79876-5_37>
-/
