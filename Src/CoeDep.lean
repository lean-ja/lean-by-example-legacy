/-
# CoeDep
`CoeDep` は型強制を行うための型クラスですが，`Coe` と異なり「項に依存する型強制」を行うことができます．

たとえば空でないリストからなる型 `NonEmptyList` を定義したとします．空リストを変換する方法がないため，`List α → NonEmptyList α` という変換を定義する自然な方法はありません．しかし `CoeDep` を使えば空でないリストに限って `NonEmptyList` に変換するという型強制を定義することができます．
-/
namespace CoeDep --#

structure NonEmptyList (α : Type) : Type where
  head : α
  tail : List α
  deriving Repr

-- リストから `NonEmptyList` に変換することができない
#check_failure ([1, 2] : NonEmptyList Nat)

variable {α : Type}

instance (x : α) (xs : List α) : CoeDep (List α) (x :: xs) (NonEmptyList α) where
  coe := {
    head := x
    tail := xs
  }

-- 変換できるようになる
#check ([1, 2] : NonEmptyList Nat)

end CoeDep --#
