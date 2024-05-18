/-
# 依存型
Lean では型が値に依存することができます．これを**依存型**と呼びます．他の言語でこれができるものとしては，Idris などがあります．

これにより，たとえば関数 `f : A → B` の返り値の型が引数 `a : A` の値に依存することができ，そのような関数の型を `(a : A) → B` と書きます．これを特に**依存関数型**といいます．

## 全称命題と ∀ 記号

典型的なのは全称命題の表現です．
-/

-- 自然数から命題への関数の型
-- `n + 0 = 0` 自体が型であることに注意
#check (n : Nat) → (n + 0 = n : Prop)

/-- 自然数から `n + 0 = n : Prop` への関数.
カリーハワード同型対応により，これは `∀ n, n + 0 = n` の証明であるとみなせる. -/
def add_zero : (n : Nat) → n + 0 = n := fun _n => rfl

-- 通常の書き方をした証明．
-- 返り値の型が `Prop` の項である場合，このように `∀` 記号を使うのが自然
theorem add_zero' : ∀ (n : Nat), n + 0 = n := by
  intro n
  rfl

/- ## 型の中の条件分岐

「ある `b : Bool` の値に応じて，真なら自然数，偽なら文字列を返す」という関数も，型の中に `if` 式を組み込んで次のように表現できます．-/

def sample (b : Bool) : if b then Nat else String :=
  match b with
  | true => (3 : Nat)
  | false => "three"

/- ただし，コードの設計としては `Nat` と `String` を合成した型を自分で定義したほうがよいでしょう．-/

-- 自然数と文字列の和集合
inductive NatOrString : Type
  | natVal : Nat → NatOrString
  | strVal : String → NatOrString

-- コンストラクタを省略できるように型強制を定義する
instance : Coe Nat NatOrString := ⟨NatOrString.natVal⟩
instance : Coe String NatOrString := ⟨NatOrString.strVal⟩

def sample' (b : Bool) : NatOrString :=
  match b with
  | true => (3 : Nat)
  | false => "three"
