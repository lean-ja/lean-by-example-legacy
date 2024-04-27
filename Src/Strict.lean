/-
# 正格評価
Lean は純粋関数型言語ですが，Haskellとは異なり**正格評価**です．

つまり，関数を評価する前に引数をすべて評価します．これは純粋関数型ではない多くの言語と同様です．

次のコード例の `selectFst` は `cond` として `true` を渡されれば，単に `fst` を返します．つまり `trace 20` は返り値には必要ないので，もし遅延評価なら評価されません. しかし実際には評価されるので，Lean は正格評価だとわかります．
-/

/-- 条件 `cond` が true なら最初の引数を，
false なら2番目の引数を返す関数 -/
def selectFst (cond : Bool) (fst snd : Nat) :=
  if cond then
    fst
  else
    snd

/-- 与えられた自然数をそのまま返す関数.
実行されると infoview に表示が出る. -/
def trace (n : Nat) : Nat :=
  dbg_trace "trace is called"
  n

/--
info: trace is called
10
-/
#guard_msgs in --#
#eval selectFst true 10 (trace 20)

/- なお `if` 式を直接評価した場合は，必要のない枝は評価されません．-/

/-- info: 10 -/
#guard_msgs in --#
#eval (if true then 10 else trace 20)
