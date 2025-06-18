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

-- sum :: (Num a) => [a] -> a
-- soma os valores da lista
-- ex terminal: sum [1,2,3,4,5]  ||| retorna 15
-- como usar: soma = sum [1,2,3,4,5]
    -- retorna o valor somado

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


-- ***FUNÇÃO PARCIAL***
-- A função é parcial é quando não está definida para todos os elementos do domínio.
-- Exemplo é a função head (x:xs) = x
-- Ela usa somente a cabeça da lista, ignorando o restante
-- Não funciona especialmente com a lista vazia.

-- ***FUNÇÃO TOTAL***
-- A função é total quando está definida para todos os elementos do domínio
-- se colocar um tratamento para a lista vazia, a função se torna total:
head [] = error "Empty list, dummy!"
head (x:xs) = x


-- *** AVALIAÇÃO PARCIAL ***
-- A função add é assim:
add x y = x + y
-- basicamente, ela tem uma função que recebe x e retorna outra funcao com y somado a 1
-- Com isso, podemos usar a APLICAÇÃO PARCIAL para reutilizar código:
inc1 = add 1
-- acima, o inc1 pode ser chamado usando um inteiro qualquer e automaticamente será adicionado o valor 1 ao resultado dessa funcao

--- *** FUNÇÃO DE ORDEM SUPERIOR ***
-- são funções que recebem outras funções como parâmetro

-- Exemplos:

-- 1 - map (+1) [1,3,5,7]
-- pega cada elemento de uma lista e aplica uma função nele, nesse caso acima, soma o valor 1
-- ex terminal: meuMap (+1) [1..4] | retorna [2..5]
-- como usar: novaLista = map condicao lista
    -- retorna nova lista
meuMap f [] = []
meuMap f (x:xs) = (f x) : (meuMap f xs)

-- 2 - zipWith (\x -> \y -> (x,y)) [1, 3, 5] ['a', 'b', 'c']
-- tem uma função e duas listas e aplica a função nas duas listas
-- ex terminal: meuZipWith (+) [1..4] [1..4] | retorna [2,4,6,8]
-- ex terminal 2: meuZipWith (\a b -> (a,b)) [1..3] [1..3] | retorna [(1,1), (2,2), (3,3)]
meuZipWith _ [] _ = []
meuZipWith _ _ [] = []
meuZipWith f (x:xs) (y:ys) = (f x y) : (meuZipWith f xs ys)

-- 3 - filter (>10) [5..15]
-- recebe um predicado (uma funcao que retorna true ou false) e uma lista e retorna somente os elementos que satisfazem a funcao
-- ex terminal: meuFilter (>10) [1..20] | retorna [11..20]
-- como usar: novaLista = filter condicao lista
    -- retorna nova lista
meuFilter p [] = []
meuFilter p (x:xs) = if p x then x:(meuFilter p xs) else filter p xs

-- ***FUNÇÕES DE DOBRA***

-- Exemplo 1) Função que soma todos os elementos de uma lista de números
somaDobra [] = 0 -- aqui precisa ser o elemento neutro
somaDobra (x:xs) = x + somaDobra xs

{-
    somaDobra[1,2,3]
    somaDobra = 1 + somaDobra[2,3]
              = 1 + (2 + somaDobra [3])
              = 1 + (2 + (3 + somaDobra []))
              = 1 + (2 + (3 + 0))
-}

-- Exemplo 2) Função que multiplica os elementos de uma lista
produtoDobra [] = 1
produtoDobra (x:xs) = x * produtoDobra xs

-- Exemplo 3) Função que faz conjunção de elementos de uma lista
conjuncaoDobra [] = True
conjuncaoDobra (x:xs) = x && conjuncaoDobra xs

-- Generalizando o padrão acima: FOLDR
meuFoldr f e [] = e -- e simboliza o elemento neutro
meuFoldr f e (x:xs) = f x (meuFoldr f e xs)

-- Mesmos exemplos, usando o foldr:
-- 1) Soma
somaDobraFoldr :: [Int] -> Int -- sem isso não funciona
somaDobraFoldr = foldr (+) 0 -- Forma simplificada

-- 2) Multiplicacao
produtoDobraFoldr :: [Int] -> Int
produtoDobraFoldr xs = foldr (*) 1 xs -- Forma completa

-- 3) Conjunção
conjuncaoDobraFoldr :: [Bool] -> Bool
conjuncaoDobraFoldr = foldr (&&) True

-- Generalizando o padrão: FOLDL
meuFoldl f acc [] = acc -- e simboliza o elemento neutro
meuFoldl f acc (x:xs) = meuFoldl f (f acc x) xs

-- Exercícios de exemplo:

-- 1) Defina as funções map e filter usando foldr
meuFilterFoldr p xs = foldr (\x l -> if p x then x : l else l) [] xs -- a lista vazia é o elemento neutro

meuMapFoldr f = foldr (\x l -> (f x) : l) [] -- diferentemente do exemplo acima, aqui usei a Avaliação Parcial para simplificar

-- 2) Usando o foldl, implemente uma função (bin2int) que dada uma lista contendo apenas 0's e 1's, 
-- retorna o número inteiro correspondente na base 10. Ex: bin2int [1,1] = 3 bin2int [1,1,0] = 6
bin2int xs = foldl (\n d -> 2*n + d) 0 xs -- n é o valor acumulado e d é o digito atual

-- ***TIPOS DE DADOS***
-- Novos tipos de dados são definidos usando o construtor data
data Color = Blue | Red | Green | Pink

-- Construtores podem ter parâmetros
data Shape = Circle Float Float Float | Rectangle Float Float Float Float
    deriving Show
-- deriving Show permite que seja exibido na tela ao imprimir essa classe
-- deve respeitar a identação

-- Uso de casamento de padrão para definir funções sobre tipos
--area :: Shape -> Float
area :: Shape -> Float
area (Circle x y r) = pi * r * r -- posso substituir o x e y por _ pois não estou usando esses parametros
area (Rectangle x1 y1 x2 y2) = (x2 - x1) * (y2 - y1)

-- com o comando :t consigo ver o tipo da função
-- Ex: 
    -- :t Circle 
    -- :t area

-- Construtores e aplicação parcial
circuloMapeado = map (Circle 10 20) [4, 5, 6, 6]
-- o resultado seria [(Circle 10 20 4), (Circle 10 20 5), (Circle 10 20 6), (Circle 10 20 6)]

-- Pessoa tem: nome, sobrenome, idade, peso, telefone e time
data Person = Person String String Int Float String String

-- exemplo para retornar o primeiro nome da Pessoa
firstName (Person name last age peso fone time) = name

-- ***SINTAXE DE REGISTROS***
-- Solução para não ficar completamente ilegível como o código anterior

data Car = Car {company :: String,
                model :: String,
                year :: Int
                }
-- OBS: Como é criado uma função para cada atributo do Registro, não é possível criar outros Registros com mesmo nome de Atributo
-- Posso definir um carro de duas maneiras:
carro1 = Car "Fiat" "Uno" 2010
carro 2 = Car {company = "Volkswagen", model = "Gol", year = 2011}

-- *** TIPOS PARAMETRIZADOS ***

-- Exemplo de definição de Pilha de valores inteiros:
newtype Stack = Stack [Int] 
-- usei newType aqui pois é o recomendado por ter apenas um construtor e um campo

push :: Stack -> Int -> Stack
push (Stack xs) a = Stack (a:xs)

-- Agora, se quiser uma pilha de qualquer tipo, deve ser feito assim:
newtype Stack2 a = Stack2 [a]

-- Só é possível graças ao Maybe
-- data Maybe a = Just a | Nothing
-- é basicamente o null de outras linguagens

-- posso usar SINÔNIMOS para melhorar legibilidade
type StackInt = Stack2 Int

-- *** TIPOS RECURSIVOS ***

-- implementação de uma árvore binária
data Tree a = Empty | Node a (Tree a) (Tree a)

search :: Ord a => a -> Tree a -> Bool
-- ORD a => a 
    -- necessário para que seja possível comparar os valores nas funções abaixo
    -- ord vem de tipos ordenáveis

search _ Empty = False
search x (Node a t1 t2)
    | x == a = True
    | x < a = search x t1
    | otherwise = search x t2

insert :: Ord a => a -> Tree a -> Tree a
insert x Empty = Node x Empty Empty
insert x (Node a t1 t2)
    | x <= a = Node a (insert x t1) t2 
    | otherwise = Node a t1 (insert x t2)

-- foldr insert Empty [5,1,4,2,3]d
-- o código acima iria inserir numa árvore vazia (Empty) os valores do vetor de trás pra frente
-- ficaria o 3 como pai do 2 e 3. O 2 como pai do 1 e o 4 como pai do 5

-- *** POLIMORFISMO PARAMÉTRICO ***
-- Polimorfismo é uma propriedade que diz respeito à funções operarem sobre diferentes tipos
-- Exemplos de funções polimórficas já utilizadas:
    -- length :: [a] -> Int
    -- length [] = 0
    -- length (x:xs) = length xs + 1
-- Ou seja, as funções operam sem tomar decisões baseada nos tipos dos argumentos
-- Exemplo:
identidade :: a -> a
identidade x = x

-- No GHCI, qualquer um dos abaixo funcionaria:
-- identidade 5
    -- retornaria 5
-- identidade "Hello"
    -- retornaria "Hello"
-- identidade True
    -- retornaria True

-- *** POLIMORFISMO DE SOBRECARGA (AD-HOC) ***
-- Neste caso, a função também funciona para vários tipos, mas exige que eles cumpram certas restrições (Typeclasses como Eq, Ord e Show)
-- Exemplo:

ehIgual :: Eq a => a -> a -> Bool
ehIgual x y = x == y
-- Aqui o a pode ser qualquer tipo que implemente a typeclasse Eq (Ou seja, suporte comparação de igualdade ==)

-- No GHCI:
-- ehIgual 5 5
    -- retorna True
-- ehIgual "a" "b"
    -- retorna False
-- ehIgual (Just 3) 3
    -- retorna Erro! Tipos diferentes

-- Agora exemplo com Ordenação
maior :: Ord a => a -> a -> a
maior x y
    | x > y      = x
    | otherwise = y

-- Funciona para qualquer tipo que possa ser comparado (Ord)

-- *** TYPECLASSES - CLASSES DE TIPO ***
-- São uma forma de definir comportamentos que um tipo poder ter
-- Funciona como um conjunto de operações que um tipo deve implementar para ser uma instância dessa typeclass
-- Exemplo já utilizados: Eq, Ord e Show
-- Exemplo:
class Descrevivel a where
    descrever :: a -> String

-- Criando instância
data Pessoa = Pessoa String Int

instance Descrevivel Pessoa where
    descrever (Pessoa nome idade) = nome ++ " tem " ++ show idade ++ " anos."

p1 = Pessoa "Alice" 30

-- NO GHCI:
-- descrever p1
    -- retorna Alice tem 30 anos.

-- Outro exemplo:
class Igual a where
    (===) :: a -> a -> Bool
    (/==) :: a -> a -> Bool

data Booleano = Falso | Verdadeiro
    deriving (Show)

-- Classes de tipo podem ser subclasses de outras
-- Exemplo de classes de tipo:
    -- Eq
        -- Comparação de igualdade ==  e /=
    -- Ord - Subclasse de Eq
        -- Ordenação> <, >, <=, >=
    -- Read
        -- Conversão de String para valor
    -- Show
        -- Conversão para String
    -- Enum
        -- Tipos que podem ser enumerados
        -- toEnum
            -- Tranforma inteiro em Enum
        -- fromEnum
            -- Transforma Enum em Inteiro

instance Igual Booleano where
    (===) Verdadeiro Verdadeiro = True
    (===) Falso Falso = True
    (===) _ _ = False
    (/==) x y = not (x === y)

-- *** INSTÂNCIAS PARAMETRIZADAS ***
-- São instâncias de typeclasses para tipos genéricos, mas que podem depender de que os parâmetros de tipo implementem certas typeclasses

-- Exemplo:

data Arvore a = Vazio | Noh a (Arvore a) (Arvore a)

instance (Eq a) => Eq (Arvore a) where
    Vazio == Vazio = True
    (Noh x t1 t2) == (Noh y t3 t4) = x == y && t1 == t3 && t2 == t4
    _ == _ = False

-- *** FUNCTORES ***
-- é uma classe de tipo que define estruturas que podem ser mapeadas
-- usa a função fmap para isso

-- class Functor f where
    -- fmap :: (a -> b) -> f a -> f b
-- Lê-se: Se f é um Functor, então você pode aplicar uma função (a -> b) aos elementos dentro de fa ,
-- obtendo um f b (ou seja, o mesmo contexto, mas com os elementos transformados)

-- O f não é um tipo concreto, mas um construtoer de tipo!

-- O função permite que aplique uma função aos valores dentro de um contexto, sem tirá-los desse contexto.

-- Exemplo com LIST
-- fmap (*2) [1,2,3]
    -- retorna [2,4,6]

-- Criação de um Functor:

data TreeFunctor a = EmptyTreeFunctor | NodeTreeFunctor a (TreeFunctor a) (TreeFunctor a)
    deriving (Show)

instance Functor TreeFunctor where
    fmap _ EmptyTreeFunctor = EmptyTreeFunctor
    fmap f (NodeTreeFunctor x l r) = NodeTreeFunctor (f x) (fmap f l) (fmap f r)

-- Dessa forma, posso executar:
t = NodeTreeFunctor 1 (NodeTreeFunctor 2 EmptyTreeFunctor EmptyTreeFunctor) (NodeTreeFunctor 3 EmptyTreeFunctor EmptyTreeFunctor)
--fmap (*2) t
-- No GHCI:
    -- fmap (*2) t 
        -- Retorna NodeTreeFunctor 2 (NodeTreeFunctor 4 EmptyTreeFunctor EmptyTreeFunctor) (NodeTreeFunctor 6 EmptyTreeFunctor EmptyTreeFunctor)


-- LEIS DOS FUNCTORES:
-- 1) Identidade
    -- fmap id == id
    -- Aplica fmap com a função identidade não muda nada
    -- essa funcao id já existe
-- 2) Composição
    -- fmap (f . g) == fmap f . fmap g
    -- Mapear uma função composta é o mesmo que mapear uma e depois a outra
    -- se escrito assim: "fmap f . fmap g"
        -- significa aplique primeiro g e depois f
    -- composição encadeia funções da direita para a esquerda
        -- (f . g) x == f (g x)


-- *** APPLICATIVE ***
-- classe de tipo que permite aplicar funções que estão dentro de contextos a valores que também estão dentro desses contextos.

-- class (Functor f) => Applicative f where
--    pure :: a -> f a
--    (<*>) :: f (a -> b) -> f a -> f b

-- pure
    -- coloca um valor dentro do contexto
    -- Exemplos:
        -- pure 5 == Just 5
        -- pure 5 == [5]

-- <*> (aplicação)
    -- aplica uma função que está dentro de um contexto (f (a -> b)) a um valor dentro de outro contexto (f a)

-- No Functor você consegue fazer isso:
    -- fmap (+1) (Just 5) 
        -- retorna Just 6
-- No Applicative você consegue fazer isso:
    -- Just (+1) <*> Just 5
        -- retorn Just 6

-- Exemplos:
    -- Com Maybe:
        -- Just (+3) <*> Just 4
            -- retorna Just 7
        -- Just (*2) <*> Nothing
            -- retorna Nothing
    -- Com Listas:
        -- [(+1), (*2)] <*> [10, 20]
            -- retorna [11,21,20,40]
            -- faz todas as combinações dessas duas listas

    -- Com múltiplos argumentos:
        -- pure (+) <*> Just 3 <*> Just 5
            -- retorna Just 8
        -- pure (+) <*> Just 3 <*> Nothing
            -- retorna Nothing
        -- a função (+) é colocada dentro do contexto com pure e aplicada sequencialmente

-- Exemplo de criação:

data PersonApp = PersonApp String Int
    deriving Show

mkPerson :: String -> Int -> PersonApp
mkPerson = PersonApp

-- No GHCI:
    -- Just mkPerson <*> Just "Alice" <*> Just 30
        -- retorna Just (Person "Alice" 30)
    -- Just mkPerson <*> Nothing <*> Just 30
        -- retorna Nothing
