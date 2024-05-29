/-
# Fin

`Fin` は，ある数 `i : Nat` とそれがある数 `n : Nat` 未満であるという情報を組にしたものです．`Fin n` は `n` 未満の自然数全体の集合を表します．
-/

/--
info: structure Fin : Nat → Type
number of parameters: 1
constructor:
Fin.mk : {n : Nat} → (val : Nat) → val < n → Fin n
fields:
val : Nat
isLt : ↑self < n
-/
#guard_msgs in #print Fin

variable (n : Nat)

-- 自然数 `n : Nat` と，`n` より小さい自然数 `val : Nat` から，`Fin n` の項が得られる
-- つまり `Fin n` は `n` 未満の自然数全体の集合
#check (Fin.mk : (val : Nat) → val < n → Fin n)
