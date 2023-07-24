{- |
Module      : Tarefa5_2022li1g016
Description : Deslize do mapa
Copyright   : Daniel Silva <a104086@alunos.uminho.pt>
              Hélder Gomes <a104100@alunos.uminho.pt>

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2022/23.
-}

module Tarefa5_2022li1g016 where

import Tarefa2_2022li1g016
import LI12223
import Data.List
import System.Random

{- |
A função __deslizaJogo__ adiciona uma linha, pseudo-aleatória, no limite superior do mapa ao mesmo tempo que elemina a linha mais abaixo do mapa, assim mantendo o tamanho do mapa.  

@
deslizaJogo :: Jogo -> Int -> Jogo
deslizaJogo (Jogo (Jogador(x,y)) (Mapa l ((terreno, obstaculos):t))) n = (Jogo (Jogador(x,y+1)) (estendeMapa (Mapa l (init ((terreno, obstaculos):t))) n))
@

== Exemplos de utilização:

>>> deslizaJogo (Jogo (Jogador (1,1)) (Mapa 3 [(Estrada (-2), [Carro, Carro, Nenhum]), (Rio (-1), [Nenhum, Tronco, Tronco])])) 1 = Jogo (Jogador (1,2)) (Mapa 3 [(Estrada (-2),[Nenhum,Carro,Carro]),(Estrada (-2),[Carro,Carro,Nenhum])])
-}

deslizaJogo :: Jogo -> Int -> Jogo
deslizaJogo (Jogo (Jogador(x,y)) (Mapa l ((terreno, obstaculos):t))) n = (Jogo (Jogador(x,y+1)) (estendeMapa (Mapa l (init ((terreno, obstaculos):t))) n))

{-
jogoT= Jogo (Jogador (5,6)) mapaT

mapaT = (Mapa 11 [(Relva, [Nenhum, Arvore, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Arvore, Arvore]),
                 (Rio (-1), [Tronco, Nenhum, Tronco, Tronco, Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco, Nenhum]),
                 (Rio 2, [Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco, Tronco, Nenhum, Tronco, Tronco, Nenhum]),
                 (Rio (-1), [Nenhum, Nenhum, Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco, Tronco, Nenhum, Tronco]),
                 (Rio 1, [Tronco, Nenhum, Tronco, Nenhum, Tronco, Tronco, Nenhum, Tronco, Tronco, Tronco, Nenhum]),
                 (Estrada 1, [Carro, Carro, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Carro]),
                 (Relva, [Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Arvore, Arvore, Arvore]),
                 (Relva, [Arvore, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Arvore, Arvore, Arvore, Arvore, Arvore]),
                 (Relva, [Arvore, Arvore, Nenhum, Nenhum, Nenhum, Arvore, Arvore, Arvore, Arvore, Arvore, Arvore])])
-}

