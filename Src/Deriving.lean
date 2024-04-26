/-
# deriving
`deriving` は，型クラスのインスタンスを自動的に生成します．決まり切ったやり方で自動生成できるような型クラスに対してのみ使用できます．

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

end Deriving --#
