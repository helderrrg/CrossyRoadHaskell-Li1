module Bot where

import LI12223
import Tarefa3_2022li1g016

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Interface.IO.Game
import Data.Maybe
import Data.List


{- |
Função principal Bot.
Esta função recebe um jogo e retorna um jogo.
Tem como objetivo "jogar" o jogo sozinha e, para tal, recorre à função verificaPosicao.

@
bot :: Jogo -> Jogo
bot jogo@(Jogo (Jogador (x,y)) mapa) | verificaPosicao mapa (x,y-1) = (Jogo (animaJogador jogo (Move Cima)) mapa)
                                      | verificaPosicao mapa (x-1,y) = (Jogo (animaJogador jogo (Move Esquerda)) mapa)
                                      | verificaPosicao mapa (x+1,y) = (Jogo (animaJogador jogo (Move Direita)) mapa)
                                      | verificaPosicao mapa (x,y+1) = (Jogo (animaJogador jogo (Move Baixo)) mapa)
                                      | otherwise = jogo
@


== Exemplos de utilização:

>>> bot (Jogo (Jogador(1,1)) mapa4) = Jogo (Jogador (1,0)) (Mapa 5 [(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Arvore]),(Relva,[Arvore,Nenhum,Arvore,Arvore,Nenhum]),(Rio 2,[Tronco,Nenhum,Tronco,Nenhum,Tronco])])
>>> bot (Jogo (Jogador(1,2)) mapa4) = Jogo (Jogador (1,1)) (Mapa 5 [(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Arvore]),(Relva,[Arvore,Nenhum,Arvore,Arvore,Nenhum]),(Rio 2,[Tronco,Nenhum,Tronco,Nenhum,Tronco])])

-}
bot :: Jogo -> Jogo
bot jogo@(Jogo (Jogador (x,y)) mapa) | y > 0 && verificaPosicao mapa (x,y-1) = (Jogo (animaJogador jogo (Move Cima)) mapa)
                                     | verificaPosicao mapa (x+1,y) = (Jogo (animaJogador jogo (Move Direita)) mapa)
                                     | x > 0 && verificaPosicao mapa (x-1,y) = (Jogo (animaJogador jogo (Move Esquerda)) mapa)
                                     | verificaPosicao mapa (x,y+1) = (Jogo (animaJogador jogo (Move Baixo)) mapa)
                                     | otherwise = jogo

{- |
Função que recebe um mapa e coordenadas e indica True/False caso a personagem possa avançar ou não.
A função recorre à função auxiliar verificaPaux.

@
verificaPosicao :: Mapa -> (Int, Int) -> Bool
verificaPosicao (Mapa _ terrenos) (x,y) = verificaPaux terreno (linha !! x)
    where (terreno, linha) = (terrenos !! y)
@

== Exemplos de utilização:

>>> verificaPosicao mapa4 (0,1) = True
>>> verificaPosicao mapa4 (3,3) = False

-}
verificaPosicao :: Mapa -> (Int, Int) -> Bool
verificaPosicao (Mapa _ terrenos) (x,y) = verificaPaux terreno (linha !! x)
    where (terreno, linha) = (terrenos !! y)

{- |
Função auxiliar à função verificaPosicao.
Recebe um terreno e um obstáculo e devolve se esse é válido ou inválido.

@
verificaPaux :: Terreno -> Obstaculo -> Bool
verificaPaux (Rio _) Tronco = True
verificaPaux (Rio _) Nenhum = False
verificaPaux Relva Nenhum = True
verificaPaux Relva Arvore = False
verificaPaux (Estrada _) Nenhum = True
verificaPaux (Estrada _) Carro = False
@

== Exemplos de utilização:

>>> verificaPaux Relva Nenhum = True
>>> verificaPaux (Estrada 3) Carro = False

-}
verificaPaux :: Terreno -> Obstaculo -> Bool
verificaPaux (Rio _) Tronco = True
verificaPaux (Rio _) Nenhum = False
verificaPaux Relva Nenhum = True
verificaPaux Relva Arvore = False
verificaPaux (Estrada _) Nenhum = True
verificaPaux (Estrada _) Carro = False
