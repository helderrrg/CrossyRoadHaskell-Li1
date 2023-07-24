module Tarefa3_2022li1g016_Spec where

import LI12223
import Tarefa3_2022li1g016
import Test.HUnit

mapa1 = (Mapa 6 [(Relva, [Nenhum, Arvore, Arvore, Nenhum, Arvore, Nenhum]),
                 (Rio (-1), [Nenhum, Nenhum, Tronco, Tronco, Tronco, Tronco]),
                 (Rio 1, [Tronco, Nenhum, Tronco, Nenhum, Nenhum, Tronco]),
                 (Rio (-2), [Nenhum, Nenhum, Tronco, Tronco, Nenhum, Tronco]),
                 (Rio 3, [Tronco, Nenhum, Tronco, Nenhum, Tronco, Tronco]),
                 (Estrada 1, [Carro, Carro, Nenhum, Nenhum, Carro, Nenhum]),
                 (Estrada 2, [Nenhum, Carro, Carro, Nenhum, Carro, Carro]),
                 (Relva, [Arvore, Nenhum, Nenhum, Arvore, Nenhum, Arvore])
                ])

mapa2 = (Mapa 6 [(Relva, [Nenhum, Arvore, Arvore, Nenhum, Arvore, Nenhum]),
                 (Rio (-1), [Nenhum, Tronco, Tronco, Tronco, Tronco, Nenhum]),
                 (Rio 1, [Tronco, Tronco, Nenhum, Tronco, Nenhum, Nenhum]),
                 (Rio (-2), [Tronco, Tronco, Nenhum, Tronco, Nenhum, Nenhum]),
                 (Rio 3, [Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco]),
                 (Estrada 1, [Nenhum, Carro, Carro, Nenhum, Nenhum, Carro]),
                 (Estrada 2, [Carro, Carro, Nenhum, Carro, Carro, Nenhum]),
                 (Relva, [Arvore, Nenhum, Nenhum, Arvore, Nenhum, Arvore])
                ])

mapa3 = (Mapa 10 [(Relva, [Nenhum, Arvore, Arvore, Nenhum, Arvore, Nenhum, Nenhum, Arvore, Nenhum, Nenhum]),
                  (Relva, [Nenhum, Nenhum, Arvore, Arvore, Nenhum, Arvore, Nenhum, Arvore, Nenhum, Nenhum]),
                  (Rio 3, [Tronco, Tronco, Tronco, Nenhum, Nenhum, Tronco, Tronco, Tronco, Nenhum, Tronco]),
                  (Rio (-2), [Nenhum, Nenhum, Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco, Nenhum, Nenhum]),
                  (Relva, [Arvore, Nenhum, Arvore, Nenhum, Arvore, Arvore, Nenhum, Arvore, Nenhum, Arvore]),
                  (Estrada 3, [Carro, Carro, Nenhum, Nenhum, Carro, Nenhum, Nenhum, Carro, Carro, Nenhum]),
                  (Estrada 2, [Nenhum, Carro, Carro, Nenhum, Carro, Carro, Carro, Nenhum, Nenhum, Carro]),
                  (Estrada (-1), [Carro, Nenhum, Nenhum, Carro, Nenhum, Carro, Carro, Nenhum, Nenhum, Carro]),
                  (Estrada 1, [Nenhum, Carro, Carro, Nenhum, Carro, Carro, Carro, Nenhum, Nenhum, Carro])
                 ])

mapa4 = (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),
                  (Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),
                  (Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),
                  (Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),
                  (Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),
                  (Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),
                  (Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),
                  (Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),
                  (Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])
                 ])

testsT1 :: Test
testsT1 = TestLabel "Testa se o jogador se movimenta junto com o rio (v > 0)   1" $ test ["Teste 1" ~: Jogo (Jogador (3,2)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Carro,Nenhum,Carro,Carro,Nenhum]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]) ~=? animaJogo (Jogo (Jogador(2,2)) mapa1) Parado]

testsT2 :: Test
testsT2 = TestLabel "Testa se o jogador se movimenta junto com o rio (v < 0) aaa2222" $ test ["Teste 2" ~: Jogo (Jogador (0,3)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Carro,Nenhum,Carro,Carro,Nenhum]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]) ~=? animaJogo (Jogo (Jogador(3,3)) mapa1) (Move Esquerda)]

testsT3 :: Test
testsT3 = TestLabel "Testa se o jogador não se movimenta junto com o rio, quando move cima" $ test ["Teste 3" ~: Jogo (Jogador (0,3)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Carro,Nenhum,Carro,Carro,Nenhum]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]) ~=? animaJogo (Jogo (Jogador(0,4)) mapa1) (Move Cima)]

testsT4 :: Test
testsT4 = TestLabel "Testa se o jogador não se movimenta junto com o rio, quando move baixo" $ test ["Teste 4" ~: (Jogo (Jogador(2,2)) mapa2)  ~=? animaJogo (Jogo (Jogador(2,1)) mapa1) (Move Baixo)]

testsT5 :: Test
testsT5 = TestLabel "Testa se o jogador não se movimenta para 'cima' de uma árvore" $ test ["Teste 5" ~: (Jogo (Jogador(0,0)) mapa2)  ~=? animaJogo (Jogo (Jogador(0,0)) mapa1) (Move Direita)]

testsT6 :: Test
testsT6 = TestLabel "Testa se o jogador se movimenta junto com o rio, quando move para 'cima' de uma árvore " $ test ["Teste 6" ~: (Jogo (Jogador(1,1)) mapa2)  ~=? animaJogo (Jogo (Jogador(2,1)) mapa1) (Move Cima)]

testsT7 :: Test
testsT7 = TestLabel "Testa se o jogador consegue mover para fora do limite do mapa (cima)" $ test ["Teste 7" ~: Jogo (Jogador (3,0)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Carro,Nenhum,Carro,Carro,Nenhum]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]) ~=? animaJogo (Jogo (Jogador(3,1)) mapa1) (Move Cima)]

testsT8 :: Test
testsT8 = TestLabel "Testa se o jogador consegue mover para fora do limite do mapa (esquerda)" $ test ["Teste 8" ~: Jogo (Jogador (0,6)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Nenhum,Carro,Carro,Nenhum,Carro]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]) ~=? animaJogo (Jogo (Jogador(1,6)) mapa1) (Move Esquerda)]

testsT9 :: Test
testsT9 = TestLabel "Testa se o jogador consegue mover para fora do limite do mapa (direita)" $ test ["Teste 9" ~: (Jogo (Jogador(5,0)) mapa2)  ~=? animaJogo (Jogo (Jogador(5,0)) mapa1) (Move Direita)]

testsT10 :: Test
testsT10 = TestLabel "Testa se o jogador consegue mover para fora do limite do mapa (baixo)" $ test ["Teste 10" ~: Jogo (Jogador (2,7)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Carro,Nenhum,Carro,Carro,Nenhum]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]) ~=? animaJogo (Jogo (Jogador(2,6)) mapa1) (Move Baixo)]

testesTarefa3 = (TestList [testsT1, testsT2, testsT3, testsT4, testsT5, testsT6, testsT7, testsT8, testsT9, testsT10])