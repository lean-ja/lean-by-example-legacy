/-
# instance
`instance` は，型クラスのインスタンスを定義するための構文です．
-/
namespace Instance --#

/-- 平面 -/
structure Point (α : Type) where
  x : α
  y : α

/-- 原点 -/
def origin : Point Int := { x := 0, y := 0 }

-- 数値のように足し算をすることはできない
#check_failure (origin + origin)

/-- 平面上の点の足し算ができるようにする -/
instance {α : Type} [Add α] : Add (Point α) where
  add p q := { x := p.x + q.x, y := p.y + q.y }

-- 足し算ができるようになった
#check (origin + origin)

end Instance --#
