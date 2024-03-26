/-
# abbrev
`abbrev` は，別名を宣言する構文です．

たとえば，`Nat` 型に別の名前を与えたかったとしましょう．Lean では型も他の項と同様に宣言できるので，次のように書いて問題がないように見えます．
-/
namespace Abbrev0 --#

def NaturalNumber : Type := Nat

/- しかし，ここで定義した `Nat` の別名を項に対して使用するとエラーになります． [^fplean] -/

#check_failure (42 : NaturalNumber)

end Abbrev0 --#
/- ここでエラーを修正する方法の一つが，`def` の代わりに `abbrev` を使用することです．-/
namespace Abbrev1 --#

abbrev NaturalNumber : Type := Nat

#check (42 : NaturalNumber)

end Abbrev1 --#
/- ## reducible 属性

あるいは，定義に `reducible` という属性を与えても機能します． -/
namespace Abbrev2 --#

@[reducible]
def NaturalNumber : Type := Nat

#check (42 : NaturalNumber)

end Abbrev2 --#
/- [^fplean]: 詳細については [Functional Programming in Lean](https://lean-lang.org/functional_programming_in_lean/getting-to-know/functions-and-definitions.html#messages-you-may-meet) を参照のこと．-/
