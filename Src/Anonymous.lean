/- # 匿名コンストラクタ
匿名コンストラクタは，帰納型(構造体も含まれます) `T` に対して `T` 型の項を分解（デコンストラクト）する方法のひとつです．

これは以下に示すように，`⟨x1, x2, ...⟩ | ⟨y1, y2, ...⟩ | ..` という構文により使うことができます．
-/
set_option linter.unusedVariables false --#

inductive Sample where
  | fst (foo bar : Nat) : Sample
  | snd (foo bar : Int) : Sample

theorem sample_triv (s : Sample) : True := by
  obtain ⟨f1, b1⟩ | ⟨f2, b2⟩ := s

  case fst =>
    trivial

  case snd =>
    trivial

/- 匿名コンストラクタを使用しない場合，次のようにコンストラクタ名を指定する必要があります．-/

theorem sample_triv' (s : Sample) : True := by
  cases s with

  | fst f b =>
    trivial
  | snd f b =>
    trivial
