/-
# def
`def` は，関数や項を定義するための基本的な構文です．
-/

def foo := "hello"

/-- 階乗関数 -/
def factorial (n : Nat) : Nat :=
  match n with
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

#eval factorial 7
