-- para executar: ghci exercicio01\e1.hs

------------------------------------------------------------------------------

-- Exercício 1 

-- a)
dobro :: Integer -> Integer -- retorna o dobro de um numero
dobro = \x -> 2 * x

-- No GHCI:
    -- dobro 2
        -- retorna 4

-- b)
dobro1 :: Num a => a -> a -- retorna o dobro de um numero
dobro1 x = 2 * x

-- No GHCI:
    -- dobro1 (dobro1 2)
        -- retorna 8

-- c)
pri :: (a, b) -> a -- retorna o primeiro elemento de uma tupla
pri (x, y) = x

-- No GHCI:
    -- pri (1, True)
        -- retorna 1

-- d)
seg :: (a, b) -> b -- retorna o segundo elemento de uma tupla
seg (x, y) = y

-- No GHCI
    -- seg (1, True)
        -- retorna True

------------------------------------------------------------------------------

-- Exercício 2

-- abaixo invertendo a ordem propositalmente
--fat1 n = n * fat1 (n-1)
--fat1 0 = 1

-- No GCHI
    -- fat1 3
        -- retorna Exception: stack overflow

------------------------------------------------------------------------------

-- Exercício 3 

-- a) resolução com expressão if-then-else
fib1 :: (Eq t, Num t, Num a) => t -> a
fib1 n = if n == 1 || n == 2 then 1 else fib1 (n-1) + fib1 (n-2)
-- b) resolução com casamento de padrão
fib2 :: (Eq t, Num t, Num a) => t -> a
fib2 1 = 1
fib2 2 = 1
fib2 n = fib2 (n-1) + fib2 (n-2)

-- c) resolução usando guardas
fib3 :: (Eq t, Num t, Num a) => t -> a
fib3 n
    | n == 1 || n == 2 = 1
    | otherwise = fib3 (n-1) + fib2 (n-2)

------------------------------------------------------------------------------

-- Exercício 4

-- a)
-- função que retorna a cauda de uma lista (mtail)
mtail :: [a] -> [a]
mtail (x:xs) = xs

-- No GHCI:
    -- mtail [1,2,3] = [2,3]

-- b)
-- função que reverte uma lista (mreverse)
mreverse :: [a] -> [a]
mreverse [] = []
mreverse (x:xs) = (mreverse xs) ++ [x]

-- c)
-- função que remove os n primeiros elementos de uma lista (mdrop)
mdrop :: (Eq t, Num t) => t -> [a] -> [a]
mdrop 0 xs = xs
mdrop n [] = []
mdrop n (x:xs) = mdrop (n-1) xs

-- d)
-- função que dada duas listas, retorna uma lista formada por um elemento da primeira e outro da segunda (mzip)
mzip :: [a] -> [b] -> [(a, b)]
mzip [] _ = []
mzip _ [] = []
mzip (x:xs) (y:ys) = [(x,y)] ++ mzip xs ys 
-- solução mais elegante: (x,y):(mzip xs ys)

-- e)
-- função que intercala duas listas (merge)
merge :: [a] -> [a] -> [a]
merge [] [] = []
merge [] (x:xs) = x:xs
merge (x:xs) [] = x:xs
merge (x:xs) (y:ys) = [x] ++ [y] ++ merge xs ys

-- f)
-- função que dado um elemento x e uma lista l, insere x entre os elementos de l (intersp)
intersp _ [] = []
intersp _ [x] = [x]
intersp x (l:ls) = [l] ++ [x] ++ intersp x ls

-- lembre-se que as listas são homogeneas, ou seja, só aceitam um mesmo tipo de dado

-- No GHCI:
    -- intersp ',' "1234"
        -- retorna "1,2,3,4"
    -- intersp 0 [1,2,3,4]
        -- retorna [1,0,2,0,3,0,4,0]

-- g)
-- função que dada uma lista, produz um par de listas em que ambas possuem metade dos elementos da lista original.
-- se a lista possuir tamanho ímpar, então uma das listas terá um elemento a mais que a outra (mixHalf)
mixHalf [] = ([],[])
mixHalf [x] = ([x],[])
mixHalf (x:y:xs) = 
    let (xs1, xs2) = mixHalf xs
    in (x:xs1, y:xs2)

------------------------------------------------------------------------------