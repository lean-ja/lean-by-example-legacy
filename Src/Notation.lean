/-
# notation
`notation` は，新しい記法を導入するためのコマンドです．
-/

/-- 各 `k` に対して，二項関係 `a ≃ b mod k` を返す -/
def modulo (k a b : Int) : Prop :=
  k ∣ (a - b)

notation a " ≃ " b " mod " k => modulo k a b

#check (3 ≃ 7 mod 4)

/- 次のような例も作ることができます．-/

notation "[" x " ... " y "]" => List.range y |> List.drop x

example : [1 ... 10] = [1, 2, 3, 4, 5, 6, 7, 8, 9] := by rfl
