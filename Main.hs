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

-- ***LIST COMPREHENSION***

-- l1 gera uma lista dos produtos de 1 a 10 por 2
l1 = [x * 2 | x <- [1..10]]

-- l2 gera uma lista de números entre 50 e 100 tal que o resto da divisao deles por 7 seja 3
l2 = [x | x <- [50..100], x `mod` 7 == 3]

-- l3 gera uma lista de pares de números que o x varia entre 1 e 3 e o y varia entre 4 e 5
l3 = [(x,y) | x <- [1..3], y <- [4..5]]

-- fun é uma função que gera uma lista de listas, a partir de uma lista de listas, na qual os elementos são pares
-- os colchetes mais internos representam o filtro dos elementos pares. O mais externo é representando cada lista da lista em questão
fun xxs = [[x | x <- xs, even x] | xs <- xxs]

-- OUTROS EXEMPLOS:
-- 1- Determinar lados, que não exceda 10, dos triângulos retângulos cujo perímetro é 24
-- a^2 = b^2 + c^2, a + b + c = 24, a <= 10, b <= 10, c <= 10

ladosTrianguloRetangulo = [(a,b,c) | c <- [1..10], b <- [c..10], a <- [b..10], a + b + c == 24, a*a == b*b + c*c]
-- coloco o c e a dentro das restrições de outras letras para não retornar duas triplas com valores iguais (em outra ordem)

-- 2- Usando List Comprehension, defina a função square l h que retorna o quadrado dos números pares da lista limitada por l e h
square l h = [x*x | x <- [l..h], even x]


-- ***AVALIAÇÃO PREGUIÇOSA E LISTA INFINITA **

primes = sieve [2..] -- se eu executo isso gera uma lista infinita de números primos
sieve (x:xs) = x : sieve [y | y <- xs, y `mod` x /= 0]

-- N é o número que quero descobrir se é primo. Primes é a a lista de números primos (infinita)
findPrime n (x:xs)
    | n == x = True
    | n < x = False
    | otherwise = findPrime n xs

isPrime n = findPrime n primes

-- gera uma lista em que o valor do elemento atual é a multiplicacao do anterior pelo index do atual + 1
-- faz uma associação da lista infinita [2..] com um elemento da lista f de forma recursiva.
-- Dessa forma, o elemento da lista infinita é sempre um a mais que o elemento de f, pois a lista infinita inicia em 2 e o f em 1
f = [1] ++ [x*y | (x,y) <- zip [2..] f]