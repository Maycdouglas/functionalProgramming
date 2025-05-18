{-
* Linguagem Puramente Funcional
    - Lambda abstração
    + \x.x
    + \x.\y.(x y)
-}

-- PARA RODAR:
    -- ghci Main.hs
    -- para imprimir no terminal: idx 1 
        -- imprimirá 1
idx = \x -> x

{-- *** Exemplos *** --}
--      name = expr

-- 1) Calcular o dobro de um número
dobro = \x -> 2 * x

-- 2) Somar dois inteiros
soma = \x -> \y -> x + y

