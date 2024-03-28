/-
# Coe
`Coe` は，型強制(coercion)と呼ばれる仕組みをユーザが定義するための型クラスです．

ある型 `T` が期待される場所に別の型の項 `s : S` を見つけると，Lean は型エラーにする前に自動的に型変換を行うことができないか試します．ここで行われる「自動的な型変換」が型強制です．

例えば，正の自然数からなる型 `Pos` を定義したとします．包含関係から `Pos → Nat` という変換ができるはずです．この変換を関数として定義するだけでは，必要になるごとに毎回書かなければなりませんが，型強制を使うと自動化することができます．
-/
namespace Coe --#

inductive Pos where
  | one : Pos
  | succ : Pos → Pos

def one : Pos := Pos.one

-- `List.drop` の引数は `Nat` なのに，`Pos` を渡したのでエラーになっている
#check_failure [1, 2, 3].drop one

/-- `Pos` から `Nat` へ変換する -/
def Pos.toNat : Pos → Nat
  | one => 1
  | succ n => n.toNat + 1

instance : Coe Pos Nat where
  coe n := n.toNat

-- 自動的に `Pos` から `Nat` への変換が行われてエラーにならない
#check [1, 2, 3].drop one

end Coe --#
