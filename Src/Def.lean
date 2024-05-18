/-
# def
`def` は，関数や項を定義するための基本的な構文です．
-/

def foo := "hello"

/-- 1を足す -/
def addOne (n : Nat) : Nat := n + 1

/-- 階乗関数 -/
def factorial (n : Nat) : Nat :=
  match n with
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

#guard factorial 7 = 5040

/- なお関数を定義するとき，隣接する同じ型の引数に対しては `:` を使いまわすことができます．-/

def add (n m : Nat) : Nat := n + m

def threeAdd (n m l : Nat) : Nat := n + m + l

/- ## where
`where` キーワードを使うと，定義をする前に変数を使用することができます．主に，ヘルパー関数を宣言するために使用されます．
-/

/-- 整数 `m, n` が与えられたときに `m` 以上 `n` 以下の整数のリストを返す -/
def range (m n : Int) : List Int :=
  loop m (n - m + 1).toNat
where
  loop (start : Int) (length : Nat) : List Int :=
    match length with
    | 0 => []
    | l + 1 => loop start l ++ [start + l]
