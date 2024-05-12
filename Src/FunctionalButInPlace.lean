/-
# Functional but in-place
Lean は純粋関数型言語ですが，変数の値の破壊的変更ができないわけではありません．

具体的には，Lean は参照カウントがちょうど 1 であるような値を更新する際に，コピーして新しい値を生成する代わりに破壊的変更を行います．これを指して，Lean 言語のパラダイムのことを Functional but in-place と呼びます．[^fbip]

たとえば，配列を更新する関数 `Array.set` や `Array.swap` は，引数の参照カウントが 1 である場合には破壊的変更を行い，1 より大きい場合にはコピーを行うように設計されています．
-/

-- `α` は型で，`α` の要素の大小比較ができる
variable {α : Type} [Ord α]

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
      dbg_trace "called swap"
      insertSorted
        ((dbgTraceIfShared "array to swap" arr).swap ⟨i', by assumption⟩ i)
        ⟨i', by simp [dbgTraceIfShared, *]⟩

/-- 挿入ソートのヘルパ関数 -/
partial def insertionSortLoop (arr : Array α) (i : Nat) : Array α :=
  if h : i < arr.size then
    insertionSortLoop (insertSorted arr ⟨i, h⟩) (i + 1)
  else
    arr

/-- 挿入ソート -/
def insertionSort (arr : Array α) : Array α :=
  insertionSortLoop arr 0

/- 上記の例の中に `dbgTraceIfShared` という関数と，`dbg_trace` という関数があります．
* `dbg_trace` は実行されるとデバッグ用のメッセージを表示します．
* `dbgTraceIfShared msg x` は，`x` の参照カウントが 1 より大きい場合に `msg` を表示します．つまり，`dbgTraceIfShared` がメッセージを表示するのは，変数に破壊的変更を加えることができないときです．

ちょうど挿入ソートの実行中には「与えられた配列を変更する」処理が呼ばれるので，上記の例では `swap` が行われるたびに `dbg_trace` と `dbgTraceIfShared` が呼ばれるようにしました．

実際に実行してみると，以下のような出力が得られます．
-/

def sample_array := #[1, 3, 2, 8, 10, 1, 1, 15, 2]

/--
info: called swap
shared RC array to swap
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

/- `shared RC array to swap` が `dbgTraceIfShared` の出力ですが，ちょうど一度だけ表示されます．これは

* 最初に与えられた引数の `sample_array` はグローバル変数であるため値を変更することができず，したがって一度は `dbgTraceIfShared` が呼ばれる．
* それ以降は，`insertSorted` の中のローカル変数として回されるだけなので，破壊的変更を行うことができる．したがって `dbgTraceIfShared` は呼ばれない．

という機序によるものです．
-/

/-!
[^fbip]: Moura, L.d., Ullrich, S. (2021). The Lean 4 Theorem Prover and Programming Language. In: Platzer, A., Sutcliffe, G. (eds) Automated Deduction – CADE 28. CADE 2021. Lecture Notes in Computer Science(), vol 12699. Springer, Cham. <https://doi.org/10.1007/978-3-030-79876-5_37>
-/
