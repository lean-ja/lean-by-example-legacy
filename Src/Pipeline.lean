/-
# パイプライン演算子

関数型言語らしく，Lean にもパイプライン演算子があります．

## `|>` 演算子
関数 `f : α → β` と `x : α` に対して `x |> f` は `f x` と同じです．
-/

def pipe₁ := [1, 2, 3, 4, 5]
  |> List.map (· + 10)
  |> List.filter (· % 2 == 0)

#guard pipe₁ = [12, 14]

/- `|>.` を使用すればフィールド記法が利用できます．-/

def pipe₂ := [1, 2, 3, 4, 5]
  |>.map (· + 10)
  |>.filter (· % 2 == 0)

#guard pipe₂ = [12, 14]

/- ## `<|` 演算子
関数 `f : α → β` と `x : α` に対して `f <| x` は `f x` と同じです．関数適用と変わらないようですが，パイプラインを使うと括弧が要らなくなるという利点があります．
-/

#check ([[]] : List <| List Nat)

#check ([[[]]] : List <| List <| List Nat)

/- `<|` は `$` で書くこともできます．同じ意味になりますが，`<|` を使うべきであるとされています．[^pipeline]-/

#check ([[]] : List $ List Nat)

#check ([[[]]] : List $ List $ List Nat)

/- [^pipeline]: [Lean Manual](https://lean-lang.org/lean4/doc/lean3changes.html#style-changes) を参照. -/
