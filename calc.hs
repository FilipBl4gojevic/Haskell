data ExprT = Lit Integer
            | Add ExprT ExprT
            | Mul ExprT ExprT
    deriving (Show, Eq)

eval :: ExprT -> Integer
eval (Lit a) = a
eval (Add (Lit a) (Lit b)) = a+b
eval (Mul (Lit a) (Lit b)) = a*b
