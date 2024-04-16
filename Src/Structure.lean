/-
# structure
`structure` は構造体を定義するためのコマンドです．構造体とは，複数のデータをまとめて一つの型として扱えるようにしたものです．
-/
namespace Structure --#

structure Point : Type where
  x : Int
  y : Int

/- 構造体を定義すると，自動的に作られる関数があります．代表的なものは

* フィールドにアクセスするための関数．
* コンストラクタ.

の2つです．フィールドへのアクセサはフィールドの名前で，コンストラクタは `mk` という名前で作られます．
-/

-- アクセサ
#check (Point.x : Point → Int)
#check (Point.y : Point → Int)

-- コンストラクタ
#check (Point.mk : Int → Int → Point)

/- コンストラクタに `mk` 以外の名前を使いたい場合，`::` を使って次のようにします．-/

structure Prod (α : Type) (β : Type) where
  gen ::
  fst : α
  snd : β

-- コンストラクタ
#check Prod.gen

/- ## 項を定義する
構造体の項を定義したい場合，複数の方法があります．波括弧記法が好まれます．-/

-- コンストラクタを使う
#check (Point.mk 1 2 : Point)

-- 波括弧記法を使う
#check ({ x := 1, y := 2 } : Point)

-- 匿名コンストラクタを使う
#check (⟨1, 2⟩ : Point)

/- ## 構造体と帰納型の関係
構造体は，帰納型の特別な場合であり，コンストラクタが一つしかないケースに対応します．上記の `Point` は以下のように定義しても同じことです．ただしこの場合，アクセサ関数が自動的に作られません．-/

inductive Point' : Type where
  | mk : (x : Int) → (y : Int) → Point'

#check_failure Point'.x

end Structure --#
