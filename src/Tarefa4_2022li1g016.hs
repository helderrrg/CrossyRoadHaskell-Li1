{- |
Module      : Tarefa4_2022li1g016
Description : Determinar se o jogo terminou
Copyright   : Daniel Silva <a104086@alunos.uminho.pt>
              Hélder Gomes <a104100@alunos.uminho.pt>

Módulo para a realização da Tarefa 4 do projeto de LI1 em 2022/23.
-}
module Tarefa4_2022li1g016 where

import LI12223

{- |
Função principal que verifica se o jogo terminou.
Esta função é defenida por duas funções que estão definas abaixo.

@
jogoTerminou :: Jogo -> Bool
jogoTerminou (Jogo jogador mapa) = fimDoJogo (localizaPersonagem jogador mapa)
@

== Exemplos de utilização:

>>> jogoTerminou (Jogo (Jogador(1,0)) (Mapa 2 [(Rio (-1), [Nenhum, Tronco])])) = False
>>> jogoTerminou (Jogo (Jogador(1,1)) (Mapa 2 [(Rio (-1), [Nenhum, Tronco])])) = True

-}

jogoTerminou :: Jogo -> Bool
jogoTerminou (Jogo jogador mapa) = fimDoJogo (localizaPersonagem jogador mapa)

{- |
Esta função verifica se o jogador se encontra dentros do limites do mapa, caso esteja chama a função localizaPersonagemTerreno, senão Nothing.

@
localizaPersonagem :: Jogador -> Mapa -> Maybe (Terreno, Obstaculo)
localizaPersonagem (Jogador (x,y)) (Mapa largura (h:t))
        | x < 0 || x > (largura-1) || y > (length (h:t) -1) || y < 0 = Nothing
        | otherwise = Just (localizaPersonagemObstaculo terrObst x)
    where
        terrObst = (localizaPersonagemTerreno (Mapa largura (h:t)) y)
@

-}

localizaPersonagem :: Jogador -> Mapa -> Maybe (Terreno, Obstaculo)
localizaPersonagem (Jogador (x,y)) (Mapa largura (h:t))
        | x < 0 || x > (largura-1) || y > (length (h:t) -1) || y < 0 = Nothing
        | otherwise = Just (localizaPersonagemObstaculo terrObst x)
    where
        terrObst = (localizaPersonagemTerreno (Mapa largura (h:t)) y)

{- |
Esta função é usada para localizar em que linha (y) o jogador se encontra.

@
localizaPersonagemTerreno :: Mapa -> Int -> (Terreno, [Obstaculo])
localizaPersonagemTerreno (Mapa largura (h:t)) 0 = h 
localizaPersonagemTerreno (Mapa largura (h:t)) y = (localizaPersonagemTerreno (Mapa largura t) (y-1))
@

-}


localizaPersonagemTerreno :: Mapa -> Int -> (Terreno, [Obstaculo])
localizaPersonagemTerreno (Mapa largura (h:t)) 0 = h 
localizaPersonagemTerreno (Mapa largura (h:t)) y = (localizaPersonagemTerreno (Mapa largura t) (y-1))


{- |
Esta função localiza em que obstáculo o jogador se encontra.

@
localizaPersonagemObstaculo :: (Terreno, [Obstaculo]) -> Int -> (Terreno, Obstaculo)
localizaPersonagemObstaculo (terr, h:t) 0 = (terr,h)
localizaPersonagemObstaculo (terr, h:t) x = localizaPersonagemObstaculo (terr, t) (x-1)
@

-}

localizaPersonagemObstaculo :: (Terreno, [Obstaculo]) -> Int -> (Terreno, Obstaculo)
localizaPersonagemObstaculo (terr, h:t) 0 = (terr, h)
localizaPersonagemObstaculo (terr, h:t) x = localizaPersonagemObstaculo (terr, t) (x-1)

{- |
Esta função ou recebe um Nothing e devolve um True ou recebe um Just, junto com um obstáculo e devolve um False ou True, dependendo se o terreno é válido para a posição do jogador.

@
fimDoJogo :: Maybe (Terreno, Obstaculo) -> Bool
fimDoJogo Nothing = True
fimDoJogo (Just (Estrada _, Carro)) = True
fimDoJogo (Just (Rio _, Nenhum)) = True
fimDoJogo _ = False
@

-}

fimDoJogo :: Maybe (Terreno, Obstaculo) -> Bool
fimDoJogo Nothing = True
fimDoJogo (Just (Estrada _, Carro)) = True
fimDoJogo (Just (Rio _, Nenhum)) = True
fimDoJogo _ = False