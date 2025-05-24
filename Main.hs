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

-- ***LISTAS***
-- São tipos de dados HOMOGÊNEOS

-- Construção de lista com operador cons, :
-- 5:[1,2,3,4,5]                  'A': " small cat"

-- Definição de lista usando intervalos
-- [1..20]                         ['a'..'z']                    [2,4..20]
-- [10,9..1]                       [3,6..2*12]                   [3,6,..]

-- Funções já definidas

-- Concat - (++) :: [a] -> [a] -> [a]
-- ex terminal: (++) [1..3] [4..7]
meuconcat [] ys = ys -- Se a lista é vazia
meuconcat (x:xs) ys = x:(meuconcat xs ys)
-- Em (x:xs), o x é a cabeça e o xs é a cauda da lista (primeiro elemento e o restante da lista)


-- Index - (!!) :: [a] -> Int -> a
-- ex terminal: [1..10] !! 4 - retorna 5
meuindex (x:xs) 0 = x -- se a lista não é vazia e quero saber o primeiro elemento dela
meuindex (x:xs) n = meuindex xs (n-1)



-- length :: [a] -> Int
-- ex terminal: length [1..5] - retorna 5
meuLength [] = 0 -- se a lista é vazia
meuLength (x:xs) = 1 + meuLength xs


-- head :: [a] -> a
-- ex terminal: head [1..5]
meuHead (x:xs) = x

-- tail :: [a] -> [a]
-- ex terminal: tail [1..5]
meuTail (x:xs) = xs

-- reverse :: [a] -> [a]
-- ex terminal: reverse [1..5]
meuReverse [] = []
meuReverse (x:xs) = (meuReverse xs) ++ [x]

-- take :: Int -> [a] -> [a]
-- captura dos primeiros elementos da lista
-- ex terminal: take[1..5]
meuTake 0 xs = [] -- primeiro elemento de uma lista qualquer
meuTake n [] = [] -- elemento de uma lista vazia
meuTake n (x:xs) = x:(meuTake (n-1) xs)


-- drop :: Int -> [a] -> [a]
-- ex terminal: drop[1..5]
meuDrop 0 xs = xs
meuDrop n [] = []
meuDrop n (x:xs) = meuDrop (n-1) xs

-- zip :: [a] -> [b] -> [(a,b)]
-- associa os elementos de uma lista ao elementos de outra de acordo com o indice
-- ex terminal: zip [1..5] ['a'..'g']
meuZip [] _ = [] -- o _ significa que o parametro não será referenciado. poderia usar o xs ali também ou qualquer outro nome
meuZip _ [] = []
meuZip (x:xs) (y:ys) = (x,y):(meuZip xs ys)

--

--

--

