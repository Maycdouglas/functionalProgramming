-- para executar: ghci exercicio02\e2.hs

------------------------------------------------------------------------------

-- Exercício 1 

-- funcao map com foldr
mapFoldr condicao = foldr (\x listaAcumuladora -> (condicao x) : listaAcumuladora) []

-- funcao filter com foldr
filterFoldr condicao = foldr (\x listaFiltrada -> if condicao x then x : listaFiltrada else listaFiltrada ) []

------------------------------------------------------------------------------

-- Exercício 2

-- bin2int com foldl
-- dada uma lista contendo apenas 0's e 1's, retorna o número inteiro correspondente na base 10.
bin2int xs = foldl (\acumulador digitoAtual -> 2*acumulador + digitoAtual) 0 xs

------------------------------------------------------------------------------

-- Exercício 3
-- List Comprehension equivalente com funções map e filter
-- [f x | x <- xs, p x]
-- map f (filter p xs)

------------------------------------------------------------------------------

-- Exercício 4
-- criar meuLength usando map e sum

meuLength lista = sum (map (const 1) lista)
-- o const 1 faz com que todos os valores da lista se tornem 1

------------------------------------------------------------------------------

-- Exercício 5

-- O que a função abaixo faz?
-- f xs = map (+1) $ map (+1) xs
-- o $ é para não utilizar o parenteses, ou seja, o codigo abaixo é equivalente:
-- f xs = map (+1) (map (+1) xs)
-- Resposta: é uma função que soma 2 a cada elemento da lista xs

-- dada duas funções, g e h, podemos obter uma propriedade da função myst assim definida?
-- myst g h xs = map g $ map h xs

-- aplica map em xs com a função h
-- depois aplica map no resultado anterior com a função g
-- a propriedade é:
    -- myst g h = map (g . h)

-- exemplo de uso:
g = (*2)
h = (+1)

myst g h xs = map (g . h) xs
-- que poderia ser simplificado para 
    -- myst g h = map ( g . h)

-- No GHCI:
    -- myst g h [1,2,3]
        -- retorna [4, 6, 8]

------------------------------------------------------------------------------

-- Exercício 6

-- usando o fold, converte um numero decimal (representado por lista de digitos) em um inteiro

-- foldl funcao acumulador lista

dec2int :: [Int] -> Int
dec2int listaDigitos = foldl (\acumulador digitoAtual -> 10*acumulador + digitoAtual) 0 listaDigitos

-- exemplo: dec2int [2,3,4,5] = 2345

------------------------------------------------------------------------------

-- Exercício 7

-- usando foldr, criar:

-- a) dado dois elementos x e y e uma lista xs, substitui toda ocorrencia de x por y em xs
-- listaNova = replace x y lista
replace :: Eq a => a -> a -> [a] -> [a]
replace x y (z:zs) = foldr (\z listaNova -> if z == x then y : listaNova else z : listaNova) [] (z:zs) 

-- exemplo: replace 1 2 [1,3,1,4,2]
    -- retorna [2,3,2,4,2]

-- b) computa a frequencia de cada elemento em uma lista
count :: Eq a => [a] -> [(Int,a)]
count (x:xs) = foldr insertCount [] (x:xs)
    where 
        insertCount z [] = [(1,z)]
        insertCount z ((n,y):ys)
            | z == y = (n+1, y) : ys
            | otherwise = (n, y) : insertCount z ys

-- exemplo: count [1,2,1,4,4,3]
    -- retorna [(1,3),(2,4),(2,1),(1,2)]

------------------------------------------------------------------------------