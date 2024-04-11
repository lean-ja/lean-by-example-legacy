/-
# section
`section` は，`variable` で宣言された引数のスコープを区切ることができます．
-/

section
  variable (a : Type)

  -- 宣言したので有効
  #check a
end

-- `section` の外に出ると無効になる
#check_failure a

/- なお上記の例ではセクションの中をインデントしていますが，インデントする必要はありません．

また，セクションに名前を付けることもできます．名前を付けた場合は，閉じるときにも名前を指定する必要があります．
-/

section hoge
  variable (a : Type)

  #check a
end hoge

/-! セクションは入れ子にすることもできます．-/
