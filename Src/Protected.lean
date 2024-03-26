/-
# protected
Lean では `namespace` で名前空間を構成し，`open` で名前空間を開くことができます．
-/
structure Point where
  x : Nat
  y : Nat

namespace Point

def add (p q : Point) : Point :=
  { x := p.x + q.x, y := p.y + q.y }

#check add

end Point

-- 名前空間が終わっているので `add` ではアクセスできない
#check_failure add

-- フルネームを使えばアクセスできる
#check Point.add

-- 名前空間を開く
open Point

-- 短い名前でアクセスできるようになった
#check add

/- しかし `open` したからといって，名前空間にある名前すべてに対して短い別名を作りたくないこともあります．そうしたとき `protected` を使用します．-/

namespace Point

protected def sub (p q : Point) : Point :=
  { x := p.x - q.x, y := p.y - q.y }

end Point

open Point

-- 名前空間を開いていても，短い名前でアクセスできない
#check_failure sub

-- フルネームならアクセスできる
#check Point.sub
