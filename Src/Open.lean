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
