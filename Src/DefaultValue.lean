/-
# 引数のデフォルト値

Python や PHP などの言語と同様に，Lean でも関数の引数にデフォルト値を指定することができます．

たとえば，割り算で「分母がゼロのとき」への安全装置を実装した関数 `safeDiv` を定義してみましょう．複数のやり方がありますが，ここでは「分母がゼロでないという証明」を引数に取るようにしてみます．
-/

def safeDiv (n m : Nat) (_h : m > 0) : Nat := n / m

#guard safeDiv 10 2 (by decide) = 5

/- 当たり前のことですが，こうすると割り算を行うたびに毎回引数に証明を渡す必要が生じます．これでは面倒ですね．ここで，引数の証明項にデフォルト値を設定することができます．そうすれば，毎回証明を渡さなくても済みます．-/

def safeDiv' (n m : Nat) (_h : m > 0 := by decide) : Nat := n / m

#guard safeDiv' 10 2 = 5

#check_failure safeDiv' 10 0

/- デフォルト値を上書きするには，普通に値を渡せばよいです． -/

-- `contradiction` では示せないので失敗する
#check_failure safeDiv' (12) 3 (by contradiction)
