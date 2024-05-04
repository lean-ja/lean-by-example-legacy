/- # 無名コンストラクタ
無名コンストラクタは，構造体 `T` に対して `T` 型の項を構成する方法のひとつです．

これは以下に示すように，`⟨x1, x2, ...⟩` という構文により使うことができます．
-/
set_option linter.unusedVariables false --#

/-- 2つのフィールドを持つ構造体 -/
structure Hoge where
  foo : Nat
  bar : Nat

def hoge : Hoge := ⟨1, 2⟩

/- コンストラクタが入れ子になっていても平坦化することができます．例えば，以下の2つの定義は同じことをしています．-/

def foo : Nat × (Int × String) := ⟨1, ⟨2, "foo"⟩⟩

def foo' : Nat × Int × String := ⟨1, 2, "foo"⟩

/- 一般の帰納型に対しては使用できません．-/

inductive Sample where
  | fst (foo bar : Nat) : Sample
  | snd (foo bar : String) : Sample

-- 「コンストラクタが一つしかない型でなければ使用できない」というエラーになる
#check_failure (⟨"foo", "bar"⟩ : Sample)

-- コンストラクタを指定しても使用できない
#check_failure (Sample.snd ⟨"foo", "bar"⟩ : Sample)
