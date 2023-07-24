module Tarefa4_2022li1g016_Spec where

import LI12223
import Tarefa4_2022li1g016
import Test.HUnit

testsT1 :: Test
testsT1 = TestLabel "Testa se um jogador perdeu atropelado" $ test ["Teste 1" ~: True ~=? jogoTerminou (Jogo (Jogador (2,1)) (Mapa 5 [(Estrada (-2), [Carro, Nenhum, Nenhum, Carro, Carro]),
                                                                                                                                      (Estrada (-1), [Nenhum, Nenhum, Carro, Carro, Carro]),
                                                                                                                                      (Estrada 1, [Carro, Nenhum, Carro, Carro, Nenhum])
                                                                                                                                     ]))]
testsT2 :: Test
testsT2 = TestLabel "Testa se um jogador perdeu afogado" $ test ["Teste 2" ~: True ~=? jogoTerminou (Jogo (Jogador (3,2)) (Mapa 5 [(Rio 2, [Tronco, Nenhum, Nenhum, Tronco, Nenhum]),
                                                                                                                                   (Rio (-1), [Nenhum, Nenhum, Tronco, Tronco, Tronco]),
                                                                                                                                   (Rio 1, [Tronco, Nenhum, Tronco, Nenhum, Nenhum])
                                                                                                                                  ]))]
testsT3 :: Test
testsT3 = TestLabel "Testa se um jogador está num Tronco" $ test ["Teste 3" ~: False ~=? jogoTerminou (Jogo (Jogador (0,0)) (Mapa 5 [(Rio 2, [Tronco, Nenhum, Nenhum, Tronco, Nenhum]),
                                                                                                                                     (Rio (-1), [Nenhum, Nenhum, Tronco, Tronco, Tronco]),
                                                                                                                                     (Rio 1, [Tronco, Nenhum, Tronco, Nenhum, Nenhum])
                                                                                                                                    ]))]
testsT4 :: Test
testsT4 = TestLabel "Testa se um jogador está dentro do mapa (vivo)" $ test ["Teste 4" ~: False ~=? jogoTerminou (Jogo (Jogador (4,2)) (Mapa 5 [(Estrada 2, [Carro, Nenhum, Nenhum, Carro, Nenhum]),
                                                                                                                                                (Estrada 1, [Nenhum, Nenhum, Carro, Carro, Carro]),
                                                                                                                                                (Estrada 3, [Carro, Nenhum, Carro, Carro, Nenhum])
                                                                                                                                               ]))]
testsT5 :: Test
testsT5 = TestLabel "Testa se um jogador está dentro do mapa (vivo)2" $ test ["Teste 5" ~: False ~=? jogoTerminou (Jogo (Jogador (0,1)) (Mapa 5 [(Relva, [Arvore, Nenhum, Nenhum, Arvore, Nenhum]),
                                                                                                                                                 (Relva, [Nenhum, Nenhum, Arvore, Arvore, Arvore]),
                                                                                                                                                 (Relva, [Arvore, Nenhum, Arvore, Arvore, Nenhum])
                                                                                                                                                ]))]
testsT6 :: Test
testsT6 = TestLabel "Testa se um jogador está fora do mapa (esquerda)" $ test ["Teste 6" ~: True ~=? jogoTerminou (Jogo (Jogador ((-2),1)) (Mapa 5 [(Relva, [Arvore, Nenhum, Nenhum, Arvore, Nenhum]),
                                                                                                                                                    (Rio (-1), [Nenhum, Tronco, Nenhum, Tronco, Tronco]),
                                                                                                                                                    (Estrada 1, [Nenhum, Nenhum, Carro, Carro, Carro])
                                                                                                                                                   ]))]                                                                                                                                       
testsT7 :: Test
testsT7 = TestLabel "Testa se um jogador está fora do mapa (direita)" $ test ["Teste 7" ~: True ~=? jogoTerminou (Jogo (Jogador (7,1)) (Mapa 5 [(Relva, [Arvore, Nenhum, Nenhum, Arvore, Nenhum]),
                                                                                                                                                (Rio 2, [Nenhum, Tronco, Nenhum, Tronco, Tronco]),
                                                                                                                                                (Estrada 1, [Nenhum, Nenhum, Carro, Carro, Carro])
                                                                                                                                               ]))] 
testsT8 :: Test
testsT8 = TestLabel "Testa se um jogador está fora do mapa (baixo)" $ test ["Teste 8" ~: True ~=? jogoTerminou (Jogo (Jogador (2,4)) (Mapa 5 [(Relva, [Arvore, Nenhum, Nenhum, Arvore, Nenhum]),
                                                                                                                                              (Rio (-1), [Nenhum, Tronco, Nenhum, Tronco, Tronco]),
                                                                                                                                              (Estrada 1, [Nenhum, Nenhum, Carro, Carro, Carro])
                                                                                                                                             ]))]
testesTarefa4 = (TestList [testsT1, testsT2, testsT3, testsT4, testsT5, testsT6, testsT7, testsT8])