/-
# attribute

`attribute` は，属性(attribute)を付与するためのコマンドです．

次の例では，命題に `simp` 属性を付与しています．これは `simp` タクティクで利用される命題を増やすことを意味します．
-/
namespace Attribute --#

theorem foo {P Q : Prop} : (P → Q) ∧ P ↔ Q ∧ P := by
  constructor <;> intro h
  · obtain ⟨hPQ, hP⟩ := h
    constructor
    · apply hPQ
      assumption
    · assumption
  · obtain ⟨hP, hQ⟩ := h
    constructor
    · intro _
      assumption
    · assumption

-- `simp` では示せない
example {P Q : Prop} : (P → Q) ∧ P ↔ Q ∧ P := by
  simp
  sorry

-- `attribute` で属性を付与
attribute [simp] foo

-- `simp` で示せるようになった
example {P Q : Prop} : (P → Q) ∧ P ↔ Q ∧ P := by
  simp

/- 与えた属性を削除することもできます．削除するには `-` を属性の頭に付けます．-/

-- `simp` 属性を削除
attribute [-simp] foo

example {P Q : Prop} : (P → Q) ∧ P ↔ Q ∧ P := by
  simp
  sorry

/- `attribute` コマンドを使用すると定義の後から属性を付与することができますが，定義した直後に属性を付与する場合は `@[..]` という書き方が使えます．-/

@[simp]
theorem bar {P Q : Prop} : (P → Q) ∧ P ↔ Q ∧ P := by
  constructor <;> intro h
  · obtain ⟨hPQ, hP⟩ := h
    constructor
    · apply hPQ
      assumption
    · assumption
  · obtain ⟨hP, hQ⟩ := h
    constructor
    · intro _
      assumption
    · assumption

example {P Q : Prop} : (P → Q) ∧ P ↔ Q ∧ P := by
  simp

end Attribute --#
