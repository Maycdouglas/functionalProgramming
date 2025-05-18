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
prim (x,y) = x

-- 4) Calcular o valor da n-ésima posição na sequência de fibonacci
-- p: 1 2 3 4 5 6 ...
-- v: 1 1 2 3 5 8 ...
fib n = if n == 1 || n == 2 then 1 else fib (n-1) + fib (n-2)

-- 5) Calcular o fatorial e um número natural
-- Solução com if-then
-- fat n = if n == 0 then 1 else n * fat (n-1)

-- Solução com Case
-- fat 0 = 1
-- fat n = n * fat (n - 1)

-- Solução com Guardas
fat n
    | n == 0 = 1
    | otherwise = n * fat (n - 1)

-- Linguagem Haskell é fortemente tipada!
--     - Int          | - Char
--     - Float        | - Bool
--     - Listas       | - Tuplas
--     - Funções


