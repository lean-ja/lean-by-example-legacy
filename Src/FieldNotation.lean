/-
# フィールド記法
フィールド記法（ドット記法とも）とは，ある条件の下で関数適用 `f x` を `x.f` と書くことができる記法のことです．Nim 言語における [Uniform Function Call Syntax](https://ja.wikipedia.org/wiki/Uniform_Function_Call_Syntax) に似た機能です．

## 典型的な使い方

Lean で構造体を定義すると，自動的にその構造体の各フィールドにアクセスするための関数が生成されます．構造体の名前が `S` で，フィールドの名前が `x` ならアクセサは `S.x` という名前になります．
-/
namespace DotNotation --#

/-- 平面上の点 -/
structure Point where
  x : Int
  y : Int

def p : Point := { x := 10, y := 20 }

-- `Point.x` で構造体の `x` フィールドにアクセスできる．
example : Point.x p = 10 := rfl

/- このとき，構造体の項 `s : S` に対して，`S.x s` を `s.x` と略記することができます．これが典型的なフィールド記法の使い方です．-/

example : p.x = 10 := rfl

/-
## 一般のフィールド記法
構造体を例にしましたが，構造体に限ったことではありません．一般に関数 `f` があり，項 `t : T` があったとすると「`f` の `T` 型の非暗黙の引数のうち，最初のものに `x` を代入したもの」を `x.f` で表すことができます．

例えば，以下は同じことを表現したコードです．-/

example : List.map (fun x => x + 1) [1, 2, 3] = [2, 3, 4] := rfl

example : [1, 2, 3].map (fun x => x + 1) = [2, 3, 4] := rfl

/-
## よくあるエラー

以下のようなエラーが出てフィールド記法が使えないことがあります．このエラーの対処法については [`_root_`](./Root.md) を参照してください．

> invalid field 'foo', the environment does not contain 'Bar.foo'
-/

end DotNotation --#
