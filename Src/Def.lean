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

/- ## partial
再帰関数も再帰的でない関数と同様に定義することができますが，有限回で終了することを Lean が自動的に証明できないとエラーになります．
エラーを解消するには，停止性を証明するか，定義に `partial` という修飾子を付けます．-/

partial def gcd (n m : Nat) : Nat :=
  if m = 0 then
    n
  else
    gcd m (n % m)

#guard gcd 12 18 = 6
