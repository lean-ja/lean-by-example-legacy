/-
# abbrev
`abbrev` は，別名を宣言する構文です．

たとえば，`Nat` 型に別の名前を与えたかったとしましょう．Lean では型も他の項と同様に宣言できるので，次のように書いて問題がないように見えます．
-/
namespace Abbrev0 --#

def NaturalNumber : Type := Nat

/- しかし，ここで定義した `Nat` の別名を項に対して使用するとエラーになります．これは，Lean が `NaturalNumber` を定義に簡約(reduce)するよりも先に，`42 : NaturalNumber` という表記が定義されているか `OfNat` のインスタンスを探そうとするためです．-/

/--
error: failed to synthesize instance
  OfNat NaturalNumber 42
-/
#guard_msgs in --#
#check (42 : NaturalNumber)

end Abbrev0 --#
/- ここでエラーを修正する方法の一つが，`def` の代わりに `abbrev` を使用することです．-/
namespace Abbrev1 --#

abbrev NaturalNumber : Type := Nat

#check (42 : NaturalNumber)

end Abbrev1 --#
/- ## 舞台裏
`abbrev` は `@[reducible]` 属性のついた `def` と同じであるため，定義に `reducible` という属性を与えても機能します． -/
namespace Abbrev2 --#

@[reducible]
def NaturalNumber : Type := Nat

#check (42 : NaturalNumber)

end Abbrev2 --#
