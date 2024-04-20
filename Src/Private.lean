/- # private
`private` は，その定義があるファイルの中でだけ参照可能になるようにする修飾子です．

不安定なAPIなど，外部に公開したくないものに対して使うのが主な用途です．

なお `private` コマンドでセクションや名前空間にスコープを制限することはできません．
-/

namespace Hoge
  section
    -- private とマークした定義
    private def addOne (n : Nat) : Nat := n + 1
  end
end Hoge

open Hoge

-- アクセスできる
#check addOne
