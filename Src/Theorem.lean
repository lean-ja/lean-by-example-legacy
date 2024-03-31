/-
# theorem
`theorem` は名前付きで命題を証明するための構文です．より正確には，`theorem` は証明項を定義するための構文だといえます．
-/

theorem add_zero {n : Nat} : n + 0 = n := by simp

#check (add_zero : ∀ {n : Nat}, n + 0 = n)

/- ## def との違い
`theorem` コマンドは特定の型を持つ項を定義するという意味で，`def` と同じです．実際，`def` を使っても証明項を定義することは可能ですし，`theorem` を使っても関数などを定義することは可能です．しかし `theorem` で宣言された項は計算不能になります．-/

def add_zero' {n : Nat} : n + 0 = n := by simp

theorem frac (n : Nat) : Nat :=
  match n with
  | 0 => 1
  | n + 1 => (n + 1) * frac n

-- コメントを外してみてください
-- #eval frac 5
