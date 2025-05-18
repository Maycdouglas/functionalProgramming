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

-- idx = \x -> x -- Forma Completa
idx x = x -- Forma Simplificada

{-- *** Exemplos *** --}
--      name = expr

-- 1) Calcular o dobro de um número
-- dobro = \x -> 2 * x -- Forma Completa
dobro x = 2 * x -- Forma Simplificada

-- 2) Somar dois inteiros
-- soma = \x -> \y -> x + y - Forma Completa
soma x y = x + y -- Forma Simplificada

-- 3) Retornar o primeiro elemento de uma tupla

-- 4)


-- Linguagem Haskell é fortemente tipada!
--     - Int          | - Char
--     - Float        | - Bool
--     - Listas       | - Tuplas
--     - Funções


