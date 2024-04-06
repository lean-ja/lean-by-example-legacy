/- # example
`example` は名前を付けずに命題の証明をすることができるコマンドです．

より正確には，`example : T := t` は `t` が型 `T` を持っていることを確かめます．特に `T` の型が `Prop` であるときには，最初に述べた通り `t` は `T` の証明だとみなすことができます．
-/
example : 1 + 1 = 2 := rfl

example {n : Nat} : n + 0 = n := by rfl

example : List Nat := [1, 2, 3]

example : Array Nat := #[1, 2, 3]

example : Bool := true
