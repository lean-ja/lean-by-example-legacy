/- # コメント
多くのプログラミング言語にある機能ですが，Lean でもコメントアウトの構文が存在します．

## 行コメント
`--` はインラインコメントを表します．各行の `--` 以降の文字列は無視されます．

```lean
-- これはコメントです
```

## ブロックコメント
`/-` と `-/` で囲まれた部分はブロックコメントとして認識され，やはり実行されません．

```lean
/-
これはブロックコメントです
複数行を一度にコメントアウトします．
-/
```

モジュールドキュメントと異なり，`import` 文より前に書くことができるという性質があります．

## ドキュメントコメント
`/--` と `-/` で囲まれた部分はドキュメントコメントとして認識されます．これは直後に続く関数や変数に対する補足説明として認識されます．ドキュメントコメントとして与えた説明は，エディタ上でその関数や変数にカーソルを合わせることで表示されます．

```lean
/-- 挨拶です -/
def foo := "Hello World!"

/-- 1を加える関数 -/
def bar (n : Nat) : Nat := n + 1
```

## モジュールドキュメント

`/-!` と `-/` で囲まれた部分はモジュールドキュメントです．セクショニングコメントと呼ばれることもあります．これは慣習的にファイルやセクション, 名前空間の冒頭でそこで何が行われるかを説明するために使われます．[^mathlib]

```lean
namespace Fibonacci

/-! ### フィボナッチ数列に関する定義 -/

/-- フィボナッチ数列の n 番目の要素 -/
def fib (n : Nat) : Nat :=
  match n with
  | 0 => 0
  | 1 => 1
  | n + 2 => fib (n - 1) + fib (n - 2)

end Fibonacci
```

なお細かい話として，モジュールドキュメントは `import` 文より前に書くとエラーになります．

[^mathlib]: [mathlib のドキュメント規約](https://leanprover-community.github.io/contribute/doc.html#sectioning-comments)を参照してください．-/
