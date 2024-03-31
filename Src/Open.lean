/-
# open
`open` は名前空間を開くためのコマンドです．

名前空間 `N` の中にある定義 `S` を使いたいとき，通常はフルネームの `N.S` を使う必要がありますが，`open N` とすることで短い別名 `S` でアクセスできるようになります．
-/
namespace Open

  def foo := "hello"

end Open

-- 名前空間の外からだと `foo` という短い名前が使えない
#check_failure foo

-- `open` することで `foo` という短い名前が使えるようになる
open Open

#check foo

/- また名前空間 `Foo` 内に `bar` という公理(`axiom` で宣言されたもの)が存在する場合，`Foo` を開くと同時に公理 `Foo.bar` もインポートされます．-/

open Classical

-- 選択原理
#print choice

section
  variable (P : Prop)

  -- 選択原理が仮定された状態になっているため，
  -- 任意の命題が決定可能になっている
  #synth Decidable P

end
