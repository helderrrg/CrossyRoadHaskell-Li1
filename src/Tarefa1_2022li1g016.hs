{- |
Module      : Tarefa1_2022li1g016
Description : Validação de um mapa
Copyright   : Daniel Silva <a104086@alunos.uminho.pt>
              Hélder Gomes <a104100@alunos.uminho.pt>

Módulo para a realização da Tarefa 1 do projeto de LI1 em 2022/23.
-}
module Tarefa1_2022li1g016 where

import LI12223
import Data.List

{- |
Função que verifica se o mapa é válido.
A função recebe um elemento Mapa e retorna um elemento Bool.
Caso a função receba um mapa vazio mapaValido (Mapa _ []), ela retornará o valor False, que significa que o mapa é inválido.
O mapa só é válido, caso a função receba três funções válidas.
Estas funções são validoLarguraLinha, validoLinha e mapaValidoAux, e são definidas abaixo.

@
mapaValido :: Mapa -> Bool
mapaValido (Mapa _ []) = False
mapaValido mapa@(Mapa largura ((terreno, obstaculos):t)) = (validoLarguraLinha mapa) && (validoLinha mapa) && (mapaValidoAux mapa)
@

== Exemplos de utilização:

>>> mapaValido (Mapa 5 []) = False
>>> mapaValido (Mapa 2 [(Relva, [Arvore, Nenhum])]) = True

-}

mapaValido :: Mapa -> Bool
mapaValido (Mapa _ []) = False
mapaValido mapa@(Mapa largura ((terreno, obstaculos):t)) = (validoLarguraLinha mapa) && (validoLinha mapa) && (mapaValidoAux mapa)

{- |
Função auxiliar à função mapaValido.  
Esta função recebe um elemento Mapa e retorna um elemento Bool.
A função verifica recursivamente se cada linha do Mapa é válida, para isso utiliza várias funções auxiliares, que são defenidas abaixo.

@
mapaValidoAux :: Mapa -> Bool
mapaValidoAux (Mapa _ []) = True
mapaValidoAux relva@(Mapa largura ((Relva, obstaculos):t)) = if (validoUmNenhum (Relva, obstaculos)) && (validoRelvaContiguos relva 0) then mapaValidoAux (Mapa largura t) else False
mapaValidoAux estrada@(Mapa largura ((Estrada v, obstaculos):t)) =if (validoCarroMax obstaculos) && (validoUmNenhum (Estrada v, obstaculos)) && (validoEstradaContiguos estrada 0) then mapaValidoAux (Mapa largura t) else False
mapaValidoAux rio@(Mapa largura ((Rio v, obstaculos):t)) = if (validoRioContrario rio) && (validoTroncoMax obstaculos) && (validoUmNenhum (Rio v, obstaculos)) && (validoRioContiguos rio 0) then mapaValidoAux (Mapa largura t) else False
@

-}

mapaValidoAux :: Mapa -> Bool
mapaValidoAux (Mapa _ []) = True
mapaValidoAux relva@(Mapa largura ((Relva, obstaculos):t)) = if (validoUmNenhum (Relva, obstaculos)) && (validoRelvaContiguos relva 0) then mapaValidoAux (Mapa largura t) else False
mapaValidoAux estrada@(Mapa largura ((Estrada v, obstaculos):t)) =if (validoCarroMax obstaculos) && (validoUmNenhum (Estrada v, obstaculos)) && (validoEstradaContiguos estrada 0) then mapaValidoAux (Mapa largura t) else False
mapaValidoAux rio@(Mapa largura ((Rio v, obstaculos):t)) = if (validoRioContrario rio) && (validoTroncoMax obstaculos) && (validoUmNenhum (Rio v, obstaculos)) && (validoRioContiguos rio 0) then mapaValidoAux (Mapa largura t) else False

{- |
Função que verifica se uma linha é válida.  
A função recebe um elemento Mapa e retorna um elemento Bool.
A função testa através de pattern matching, se existe algum obstáculo incorreto dentro de cada terreno.

@
validoLinha :: Mapa -> Bool
validoLinha (Mapa largura ((Relva, obstaculos):t)) = not (elem Carro obstaculos || elem Tronco obstaculos)
validoLinha (Mapa largura ((Rio v, obstaculos):t)) = not (elem Carro obstaculos || elem Arvore obstaculos)
validoLinha (Mapa largura ((Estrada v, obstaculos):t)) = not (elem Tronco obstaculos || elem Arvore obstaculos)
@

== Exemplos de utilização:

>>> validoLinha (Mapa 3 [(Relva, [Carro, Nenhum, Tronco])]) = False
>>> validoLinha (Mapa 3 [(Relva, [Arvore,Nenhum, Arvore])]) = True

-}

validoLinha :: Mapa -> Bool
validoLinha (Mapa largura ((Relva, obstaculos):t)) = not (elem Carro obstaculos || elem Tronco obstaculos)
validoLinha (Mapa largura ((Rio v, obstaculos):t)) = not (elem Carro obstaculos || elem Arvore obstaculos)
validoLinha (Mapa largura ((Estrada v, obstaculos):t)) = not (elem Tronco obstaculos || elem Arvore obstaculos)

{- |
Função que verifica se um RioContrário é válido.  
A função recebe um elemento Mapa e retorna um elemento Bool.
Caso a função receba um rio com velocidade 0, independentemente do valor da velocidade, ela retornará o valor False, que significa que o mapa é inválido.  
O rio só é válido, caso a função receba um rio com velocidade v e obstáculos. Além disso, para que a função validoRioContrário
retorne True, o elemento dado Mapa terá que passar pela função validoRioContrarioAux (definida em baixo) e esta terá que retornar True.  

@
validoRioContrario :: Mapa -> Bool
validoRioContrario (Mapa largura ((Rio 0, _):t)) = False
validoRioContrario (Mapa largura ((Rio v, obstaculos):t)) = validoRioContrarioAux (Mapa largura ((Rio v, obstaculos):t)) 0
@

== Exemplos de utilização:

>>> validoRioContrario (Mapa 2 [(Rio 2, [Nenhum, Tronco]), (Rio 1, [Tronco, Nenhum])]) = False
>>> validoRioContrario (Mapa 2 [(Rio 2, [Nenhum, Tronco]), (Rio (-1), [Tronco, Nenhum])]) = True
-}

validoRioContrario :: Mapa -> Bool
validoRioContrario (Mapa largura ((Rio 0, _):t)) = False
validoRioContrario (Mapa largura ((Rio v, obstaculos):t)) = validoRioContrarioAux (Mapa largura ((Rio v, obstaculos):t)) 0

{- |
Função auxiliar à função validoRioContrario.
A função recebe um elemento Mapa, um Inteiro e retorna um Bool. 
Recursivamente a funçao guarda o valor anterior da velocidade e compara-o com a velocidade seguinte, caso sejam de sinal contrário, a função continua até esvaziar a lista e retornar True, caso não aconteça retorna False.
Cada vez que a função encontra um terreno que não seja Rio, torna o acumulador (a), 0, permitindo entrar na 1ª guarda, recomeçando a verificação das velocidades.

@
validoRioContrarioAux :: Mapa -> Int -> Bool
validoRioContrarioAux (Mapa largura []) _ = True
validoRioContrarioAux (Mapa largura ((Rio v, _):t)) a  | a == 0 = validoRioContrarioAux (Mapa largura t) v
                                                       | a < 0 = if v > 0 then validoRioContrarioAux (Mapa largura t) v else False
                                                       | a > 0 = if v < 0 then validoRioContrarioAux (Mapa largura t) v else False
validoRioContrarioAux (Mapa largura ((_, _):t)) a = validoRioContrarioAux (Mapa largura t) 0
@

-}
validoRioContrarioAux :: Mapa -> Int -> Bool
validoRioContrarioAux (Mapa largura []) _ = True
validoRioContrarioAux (Mapa largura ((Rio v, _):t)) a  | a == 0 = validoRioContrarioAux (Mapa largura t) v
                                                       | a < 0 = if v > 0 then validoRioContrarioAux (Mapa largura t) v else False
                                                       | a > 0 = if v < 0 then validoRioContrarioAux (Mapa largura t) v else False
validoRioContrarioAux (Mapa largura ((_, _):t)) a = validoRioContrarioAux (Mapa largura t) 0

{- |
Função que valida a dimensão máxima de um Tronco.  
A função recebe uma lista de obstáculos e pela função "group", une os elementos seguidos em listas, em seguida, a função auxiliar, caso o primeiro e ultimo elemento da lista sejam Troncos concatena-os.
Por último, a função auxilar 2, compara, recursivamente, o tamanho das listas, que contêm Troncos, caso alguma seja maior que 5, a função retorna Falso, senão True.

@
validoTroncoMax :: [Obstaculo] -> Bool
validoTroncoMax obstaculos = if (elem Tronco (head obst)) && (elem Tronco (last obst))
                             then validoTroncoMaxAux ((head obst) ++ (last obst)) (tail obst)
                             else validoTroncoMaxAux2 obst
    where obst = (group obstaculos)

validoTroncoMaxAux :: [Obstaculo] -> [[Obstaculo]] -> Bool
validoTroncoMaxAux obst resto = if (length obst) < 6 then validoTroncoMaxAux2 resto else False 

validoTroncoMaxAux2 :: [[Obstaculo]] -> Bool
validoTroncoMaxAux2 [] = True
validoTroncoMaxAux2 (h:t) = if (elem Tronco h)
                              then (length h) < 6 && (validoTroncoMaxAux2 t)
                              else validoTroncoMaxAux2 t
@

== Exemplos de utilização:

>>> validoTroncoMax (Mapa  [(Rio 7, [Tronco, Tronco, Nenhum, Tronco, Tronco, Tronco, Tronco]) = False
>>> validoTroncoMax (Mapa  [(Rio 7, [Tronco, Tronco, Nenhum, Tronco, Tronco, Nenhum, Tronco]) = True

-}

validoTroncoMax :: [Obstaculo] -> Bool
validoTroncoMax obstaculos = if (elem Tronco (head obst)) && (elem Tronco (last obst))
                             then validoTroncoMaxAux ((head obst) ++ (last obst)) (tail obst)
                             else validoTroncoMaxAux2 obst
    where 
        obst = (group obstaculos)
        validoTroncoMaxAux :: [Obstaculo] -> [[Obstaculo]] -> Bool
        validoTroncoMaxAux obst resto = if (length obst) < 6 then validoTroncoMaxAux2 resto else False 

        validoTroncoMaxAux2 :: [[Obstaculo]] -> Bool
        validoTroncoMaxAux2 [] = True
        validoTroncoMaxAux2 (h:t) = if (elem Tronco h)
                                    then (length h) < 6 && (validoTroncoMaxAux2 t)
                                    else validoTroncoMaxAux2 t

{- |
Função que valida a dimensão máxima de um Carro.  
A função recebe uma lista de obstáculos e pela função "group", une os elementos seguidos em listas, em seguida, a função auxiliar, caso o primeiro e ultimo elemento da lista sejam Carro concatena-os.
Por último, a função auxilar 2, compara, recursivamente, o tamanho das listas, que contêm Carro, caso alguma seja maior que 3, a função retorna Falso, senão True.

@
validoCarroMax :: [Obstaculo] -> Bool
validoCarroMax obstaculos = if (elem Carro (head obst)) && (elem Carro (last obst))
                            then validoCarroMaxAux ((head obst) ++ (last obst)) (tail obst)
                            else validoCarroMaxAux2 obst
    where obst = (group obstaculos)

validoCarroMaxAux :: [Obstaculo] -> [[Obstaculo]] -> Bool
validoCarroMaxAux obst resto = if (length obst) < 4 then validoCarroMaxAux2 resto else False 

validoCarroMaxAux2 :: [[Obstaculo]] -> Bool
validoCarroMaxAux2 [] = True
validoCarroMaxAux2 (h:t) = if (elem Carro h)
                             then (length h) < 4 && (validoCarroMaxAux2 t)
                             else validoCarroMaxAux2 t
@

== Exemplos de utilização:

>>> validoTroncoMax (Mapa  [(Rio 5, [Carro, Nenhum, Carro, Carro, Carro]) = False
>>> validoTroncoMax (Mapa  [(Rio 5, [Carro, Nenhum, Nenhum, Carro, Carro]) = True

-}
validoCarroMax :: [Obstaculo] -> Bool
validoCarroMax obstaculos = if (elem Carro (head obst)) && (elem Carro (last obst))
                            then validoCarroMaxAux ((head obst) ++ (last obst)) (tail obst)
                            else validoCarroMaxAux2 obst
    where 
        obst = (group obstaculos)
        validoCarroMaxAux :: [Obstaculo] -> [[Obstaculo]] -> Bool
        validoCarroMaxAux obst resto = if (length obst) < 4 then validoCarroMaxAux2 resto else False

        validoCarroMaxAux2 :: [[Obstaculo]] -> Bool
        validoCarroMaxAux2 [] = True
        validoCarroMaxAux2 (h:t) = if (elem Carro h)
                                   then (length h) < 4 && (validoCarroMaxAux2 t)
                                   else validoCarroMaxAux2 t
{- |
Função que valida um obstáculo.    
A função recebe um tuplo de terreno e lisa de obstáculos e retorna um Bool.
A função verifica se numa determinada linha, existe, pelo menos, um "Nenhum".

@
validoUmNenhum :: (Terreno, [Obstaculo]) -> Bool
validoUmNenhum (terreno, obstaculos) = elem Nenhum obstaculos
@

== Exemplos de utilização:

>>> validoLinha (Mapa 3 [(Rio 2, [Tronco, Tronco, Tronco])]) = False
>>> validoLinha (Mapa 3 [(Relva, [Arvore, Nenhum, Arvore])]) = True

-}
validoUmNenhum :: (Terreno, [Obstaculo]) -> Bool
validoUmNenhum (terreno, obstaculos) = elem Nenhum obstaculos

{- |
Função que valida a largura de uma linha.      
A função, recursivamente, compara a largura do mapa com a length da lista obstáculos, se forem sempre iguais retorna True, senão False.

@
validoLarguraLinha :: Mapa -> Bool
validoLarguraLinha (Mapa largura []) = True
validoLarguraLinha (Mapa largura ((_, obstaculos):t)) | largura == (length obstaculos) = validoLarguraLinha (Mapa largura t)
                                                      | otherwise = False
@

== Exemplos de utilização:

>>> validoLinha (Mapa 2 [(Rio 2, [Tronco, Tronco, Tronco])]) = False
>>> validoLinha (Mapa 3 [(Relva, [Arvore, Nenhum, Arvore])]) = True

-}
validoLarguraLinha :: Mapa -> Bool
validoLarguraLinha (Mapa largura []) = True
validoLarguraLinha (Mapa largura ((_, obstaculos):t)) | largura == (length obstaculos) = validoLarguraLinha (Mapa largura t)
                                                      | otherwise = False

{- |
Função que valida a contiguidade dos rios.
A função, recursivamente, identifica se a linha é um Rio, caso seja soma 1 ao acumulador, se chegar a 5, retorna False, senão True.
Cada vez que a função encontre algum terreno diferente de Rio, torna o acumulador 0, recomeçando a contagem de rios. 

@
validoRioContiguos :: Mapa -> Int -> Bool
validoRioContiguos (Mapa _ _) 5 = False
validoRioContiguos (Mapa _ []) _ = True
validoRioContiguos (Mapa largura ((Rio _, _):t)) a = validoRioContiguos (Mapa largura t) (a+1)
validoRioContiguos (Mapa largura ((_, _):t)) a = validoRioContiguos (Mapa largura t) 0
@

-}
validoRioContiguos :: Mapa -> Int -> Bool
validoRioContiguos (Mapa _ _) 5 = False
validoRioContiguos (Mapa _ []) _ = True
validoRioContiguos (Mapa largura ((Rio _, _):t)) a = validoRioContiguos (Mapa largura t) (a+1)
validoRioContiguos (Mapa largura ((_, _):t)) a = validoRioContiguos (Mapa largura t) 0

{- |
Função que valida a contiguidade das estradas.
A função, recursivamente, identifica se a linha é uma Estrada, caso seja soma 1 ao acumulador, se chegar a 5, retorna False, senão True.
Cada vez que a função encontre algum terreno diferente de Estrada, torna o acumulador 0, recomeçando a contagem de estradas. 

@
validoEstradaContiguos :: Mapa -> Int -> Bool
validoEstradaContiguos (Mapa _ _) 6 = False
validoEstradaContiguos (Mapa _ []) _ = True
validoEstradaContiguos (Mapa largura ((Estrada _, _):t)) a = validoEstradaContiguos (Mapa largura t) (a+1)
validoEstradaContiguos (Mapa largura ((_, _):t)) a = validoEstradaContiguos (Mapa largura t) 0
@

-}
validoEstradaContiguos :: Mapa -> Int -> Bool
validoEstradaContiguos (Mapa _ _) 6 = False
validoEstradaContiguos (Mapa _ []) _ = True
validoEstradaContiguos (Mapa largura ((Estrada _, _):t)) a = validoEstradaContiguos (Mapa largura t) (a+1)
validoEstradaContiguos (Mapa largura ((_, _):t)) a = validoEstradaContiguos (Mapa largura t) 0

{- |
Função que valida a contiguidade de relvas.
A função, recursivamente, identifica se a linha é uma Relva, caso seja soma 1 ao acumulador, se chegar a 6, retorna False, senão True.
Cada vez que a função encontre algum terreno diferente de Relva, torna o acumulador 0, recomeçando a contagem de relvas. 

@
validoRelvaContiguos :: Mapa -> Int -> Bool
validoRelvaContiguos (Mapa _ _) 6 = False
validoRelvaContiguos (Mapa _ []) _ = True
validoRelvaContiguos (Mapa largura ((Relva, _):t)) a = validoRelvaContiguos (Mapa largura t) (a+1)
validoRelvaContiguos (Mapa largura ((_, _):t)) a = validoRelvaContiguos (Mapa largura t) 0
@

-}

validoRelvaContiguos :: Mapa -> Int -> Bool
validoRelvaContiguos (Mapa _ _) 6 = False
validoRelvaContiguos (Mapa _ []) _ = True
validoRelvaContiguos (Mapa largura ((Relva, _):t)) a = validoRelvaContiguos (Mapa largura t) (a+1)
validoRelvaContiguos (Mapa largura ((_, _):t)) a = validoRelvaContiguos (Mapa largura t) 0
