/-
# deriving
`deriving` は，型クラスのインスタンスを自動的に生成します．

以下に示すように, `deriving instance C for T` とすると型 `T` に対して型クラス `C` のインスタンスを生成します．
-/
namespace Deriving --#

inductive Color : Type where
  | red
  | green
  | blue

deriving instance Repr for Color

#eval Color.red

/- 対象の型の直後であれば，省略して `deriving C` だけ書けば十分です．また複数の型クラスに対してインスタンスを生成するには，クラス名をカンマで続けます．-/

structure People where
  name : String
  age : Nat

deriving Inhabited, Repr

#eval (default : People)

/- ## よくあるエラー
なお，`deriving` で実装を生成できるのは，決まりきったやり方で実装できて，実装方法が指定されている型クラスのみです．実装方法が指定されていなければ使うことはできません．-/

/-- 自前で定義した型クラス -/
class Callable (α : Type) where
  call : α → String

/--
error: default handlers have not been implemented yet, class: 'Deriving.Callable' types: [Deriving.People]
-/
#guard_msgs in --#
deriving instance Callable for People

end Deriving --#
