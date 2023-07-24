{- |
Module      : Tarefa2_2022li1g016
Description : Geração contínua de um mapa
Copyright   : Daniel Silva <a104086@alunos.uminho.pt>
              Hélder Gomes <a104100@alunos.uminho.pt>

Módulo para a realização da Tarefa 2 do projeto de LI1 em 2022/23.
-}

module Tarefa2_2022li1g016 where

import System.Random
import LI12223
import qualified GHC.Base as Jogo

{- |
A função recebe um Mapa válido e um inteiro (número de 0 a 100) e retorna o mesmo mapa estendido.
O número de 0 a 100 é utilizado nesta função e em várias outras para criar uma pseudo-aleatoriedade à estensão do mapa.
Esta função utiliza várias funções auxiliares defenidas abaixo. 

@
estendeMapa :: Mapa -> Int -> Mapa
estendeMapa (Mapa largura ((terr, obst):t)) n | terreno == Rio 0 = (Mapa largura ((Rio (vRio terr n), Nenhum : obstaculos):(terr, obst):t))
                                              | terreno == Estrada 0 = (Mapa largura ((Estrada vEstrada, Nenhum : obstaculos):(terr, obst):t))
                                              | terreno == Relva = (Mapa largura ((Relva, obstaculosRelva):(terr, obst):t))
    where
        terreno = estendeTerreno (Mapa largura ((terr, obst):t)) n
        obstaculos = estendeObstaculo largura (terreno, []) (mkStdGen n) 1 0 0
        osbtaculosRelva = estendeObstaculo largura (terreno, []) (mkStdGen n) 0 0 0
        vEstrada = if n > 50 then (mod n 3) +1 else -(mod n 3) -1

@

== Exemplos de utilização:

>>> estendeMapa (Mapa 3 [(Rio (-1), [Nenhum, Tronco, Tronco])]) 13 = Mapa 3 [(Estrada (-2), [Carro, Carro, Nenhum]), (Rio (-1), [Nenhum, Tronco, Tronco])]

-}

estendeMapa :: Mapa -> Int -> Mapa
estendeMapa (Mapa largura ((terr, obst):t)) n | terreno == Rio 0 = (Mapa largura ((Rio (vRio terr n), Nenhum : obstaculos):(terr, obst):t))
                                              | terreno == Estrada 0 = (Mapa largura ((Estrada vEstrada, Nenhum : obstaculos):(terr, obst):t))
                                              | terreno == Relva = (Mapa largura ((Relva, obstaculosRelva):(terr, obst):t))
    where
        terreno = estendeTerreno (Mapa largura ((terr, obst):t)) n
        obstaculos = estendeObstaculo largura (terreno, []) (mkStdGen n) 1 0 0
        obstaculosRelva = estendeObstaculo largura (terreno, []) (mkStdGen n) 0 0 0
        vEstrada = if n > 50 then (mod n 3) +1 else -(mod n 3) -1

{- |
Função auxiliar que determina a velocidade do rio, de forma pseudo-aleatória, entre (-4) e 4, exceto o 0.
Caso a linha anterior seja também um rio, a velocidade obrigatoriamente será de sinal contrário.

@
vRio :: Terreno -> Int -> Velocidade
vRio (Rio velocidade) n = if velocidade < 0 then (mod n 4) +1 else -(mod n 4) -1
vRio _ n = if n > 50 then (mod n 3) +1 else -(mod n 3) -1
@

-}

vRio :: Terreno -> Int -> Velocidade
vRio (Rio velocidade) n = if velocidade < 0 then (mod n 3) +1 else -(mod n 3) -1
vRio _ n = if n > 50 then (mod n 3) +1 else -(mod n 3) -1

{- |
Esta função recebe um Mapa e através de uma lista de possíveis terrenos, escolhe de forma pseudo-aleatória o próximo terreno.  

@
estendeTerreno :: Mapa -> Int -> Terreno
estendeTerreno mapa@(Mapa largura ((terreno, obstaculos):t)) n = terreno !! mod n (length terreno)
        where terreno = proximosTerrenosValidos mapa
@

== Exemplos de utilização:

>>> estendeTerreno (Mapa 3 [(Rio (-1), [Nenhum, Tronco, Tronco])]) 31 = Estrada 0

-}
estendeTerreno :: Mapa -> Int -> Terreno
estendeTerreno mapa@(Mapa largura ((terreno, obstaculos):t)) n = terreno !! mod n (length terreno)
        where terreno = proximosTerrenosValidos mapa

{- |
A função de forma recursiva e através de uma lista de obstáculos válida, gera uma lista de obstáculos pseudo-aleatória.
Quando o tamanho da lista de obstáculos for igual à largura, a função para.

@
estendeObstaculo :: Int -> (Terreno, [Obstaculo]) -> StdGen -> Int -> Int -> Int -> [Obstaculo]
estendeObstaculo largura (terreno, obstaculos) gen acc nCarros nTroncos
        | largura <= acc = [] 
        | acc == 0 = Nenhum : estendeObstaculo largura (terreno, obstaculos) nextGen (acc +1) 0 0
        | terreno == Relva = obstaculo : estendeObstaculo largura (terreno, obstaculos) nextGen (acc +1) 0 0
        | (obstaculo == Carro) && (nCarros < 3) = obstaculo : estendeObstaculo largura (terreno, obstaculos) nextGen (acc +1) (nCarros +1) nTroncos
        | (obstaculo == Tronco) && (nTroncos < 5) = obstaculo : estendeObstaculo largura (terreno, obstaculos) nextGen (acc +1) nCarros (nTroncos +1)
        | otherwise = Nenhum : estendeObstaculo largura (terreno, obstaculos) nextGen (acc +1) 0 0
        where obstaculo = obstValidos !! mod n (length obstValidos)
                where obstValidos = proximosObstaculosValidos largura (terreno, obstaculos)
              (n, nextGen) = next gen
@

-}

estendeObstaculo :: Int                                                                        -- ^ largura
                        -> (Terreno, [Obstaculo])                                              -- ^ tuplo de terreno com lista vazia de obstáculos
                                                  -> StdGen                                    -- ^ número pseudo-aleatório
                                                           -> Int                              -- ^ acumulador para contagem de número de obstáculos
                                                                 -> Int                        -- ^ acumulador para contagem de carros
                                                                       -> Int                  -- ^ acumulador para contagem de troncos
                                                                             -> [Obstaculo]    -- ^lista de obstáculos pseudo-aleatório
estendeObstaculo largura (terreno, obstaculos) gen acc nCarros nTroncos
        | largura <= acc = []
        | acc == 0 = Nenhum : estendeObstaculo largura (terreno, obstaculos) nextGen (acc +1) 0 0
        | terreno == Relva = obstaculo : estendeObstaculo largura (terreno, obstaculos) nextGen (acc +1) 0 0
        | (obstaculo == Carro) && (nCarros < 3) = obstaculo : estendeObstaculo largura (terreno, obstaculos) nextGen (acc +1) (nCarros +1) nTroncos
        | (obstaculo == Tronco) && (nTroncos < 5) = obstaculo : estendeObstaculo largura (terreno, obstaculos) nextGen (acc +1) nCarros (nTroncos +1)
        | otherwise = Nenhum : estendeObstaculo largura (terreno, obstaculos) nextGen (acc +1) 0 0
        where obstaculo = obstValidos !! mod n (length obstValidos)
                where obstValidos = proximosObstaculosValidos largura (terreno, obstaculos)
              (n, nextGen) = next gen

{- |
A função que recebe uma mapa e através de Patter Matching devolve uma lista com os próximos terreno válidos.  

@
proximosTerrenosValidos :: Mapa -> [Terreno]
proximosTerrenosValidos (Mapa _ []) = [Rio 0, Estrada 0, Relva]
proximosTerrenosValidos (Mapa _ ((Rio _, _):(Rio _, _):(Rio _, _):(Rio _, _):_)) = [Estrada 0, Relva]
proximosTerrenosValidos (Mapa _ ((Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _, _):_)) = [Rio 0, Relva]
proximosTerrenosValidos (Mapa _ ((Relva, _):(Relva, _):(Relva, _):(Relva, _):(Relva, _):_)) = [Estrada 0, Rio 0]
proximosTerrenosValidos (Mapa _ _) = [Rio 0, Estrada 0, Relva]
@

== Exemplos de utilização:

>>> proximosTerrenosValidos (Mapa 3 [(Rio (-1), [Nenhum, Tronco, Tronco])]) = [Rio 0,Estrada 0,Relva]

-}
proximosTerrenosValidos :: Mapa -> [Terreno]
proximosTerrenosValidos (Mapa _ []) = [Rio 0, Estrada 0, Relva]
proximosTerrenosValidos (Mapa _ ((Rio _, _):(Rio _, _):(Rio _, _):(Rio _, _):_)) = [Estrada 0, Relva]
proximosTerrenosValidos (Mapa _ ((Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _, _):_)) = [Rio 0, Relva]
proximosTerrenosValidos (Mapa _ ((Relva, _):(Relva, _):(Relva, _):(Relva, _):(Relva, _):_)) = [Estrada 0, Rio 0]
proximosTerrenosValidos (Mapa _ _) = [Rio 0, Estrada 0, Relva]

{- |
A função recebe a largura de uma mapa e um tuplo com um terreno e uma lista de obstáculos e devolve uma lista de possíveis obstáculos.
 - A função devolve: 
   .lista vazia se a lista de obstáculos estiver completa.
   .lista com Nenhum, caso o número máximo de obstáculos seja alcançado.
   .lista com Nenhum, caso a lista tenha apenas obstáculos, para além do Nenhum, e falte apenas 1 espaço.
   .lista com as duas opções, caso nenhuma das condições anteriores seja atingida.

@
proximosObstaculosValidos :: Int -> (Terreno, [Obstaculo]) -> [Obstaculo]
proximosObstaculosValidos largura (_, obstaculos) | largura == (length obstaculos) = []
proximosObstaculosValidos largura (Rio _, (Tronco: Tronco: Tronco: Tronco: Tronco: _)) = [Nenhum]
proximosObstaculosValidos largura (Estrada _, (Carro: Carro: Carro: _)) = [Nenhum]
proximosObstaculosValidos largura (terreno, obstaculos) = if ((not(elem Nenhum obstaculos)) && (largura == (length obstaculos)-1)) 
                                                          then [Nenhum] 
                                                          else proximosObstaculosValidosCont largura (terreno, obstaculos) 
proximosObstaculosValidosCont :: Int -> (Terreno, [Obstaculo]) -> [Obstaculo]
proximosObstaculosValidosCont largura (Estrada _, _) = [Nenhum, Carro]
proximosObstaculosValidosCont largura (Rio _, _) = [Nenhum, Tronco]
proximosObstaculosValidosCont largura (Relva, _) = [Nenhum, Arvore]
@

== Exemplos de utilização:

>>> proximosObstaculosValidos 3 (Rio (-1), [Nenhum]) = [Nenhum, Tronco]

-}

proximosObstaculosValidos :: Int -> (Terreno, [Obstaculo]) -> [Obstaculo]
proximosObstaculosValidos largura (_, obstaculos) | largura == (length obstaculos) = []
proximosObstaculosValidos _ (Rio _, (Tronco: Tronco: Tronco: Tronco: Tronco: _)) = [Nenhum]
proximosObstaculosValidos _ (Estrada _, (_: Carro: Carro: Carro: _)) = [Nenhum]
proximosObstaculosValidos largura (terreno, obstaculos) = if ((not(elem Nenhum obstaculos)) && (largura == (length obstaculos)-1)) 
                                                          then [Nenhum] 
                                                          else proximosObstaculosValidosCont largura (terreno, obstaculos) 
        where
           proximosObstaculosValidosCont :: Int -> (Terreno, [Obstaculo]) -> [Obstaculo]
           proximosObstaculosValidosCont _ (Estrada _, _) = [Nenhum, Carro]
           proximosObstaculosValidosCont _ (Rio _, _) = [Tronco, Nenhum]
           proximosObstaculosValidosCont _ (Relva, _) = [Arvore, Nenhum]