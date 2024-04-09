/-
# CoeFun
`CoeFun` は，関数型を持たない項を関数型に強制することができる型クラスです．
-/

/-- 加法的な関数 -/
structure AdditiveFunction : Type where
  /-- 関数部分 -/
  func : Nat → Nat

  /-- 加法を保つ -/
  additive : ∀ x y, func (x + y) = func x + func y

/-- 恒等写像 -/
def identity : AdditiveFunction := ⟨id, by intro x y; rfl⟩

#check (identity : AdditiveFunction)

-- `identity` の型は `AdditiveFunction` であって，関数ではないのでこれはエラーになる
#check_failure (identity 1)

-- `CoeFun` を使って `AdditiveFunction` の項を関数型 `Nat → Nat` に強制する
instance : CoeFun AdditiveFunction (fun _ => Nat → Nat) where
  coe f := f.func

-- まるで関数のように使えるようになる
#check (identity 1)

/-! 上記の例ではどんな `t : AdditiveFunction` も同じ型 `Nat → Nat` に強制していますが，実際には依存関数型に強制することができます．-/
