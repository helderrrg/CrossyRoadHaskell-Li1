module Bot_Spec where

import LI12223
import Bot
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

--10 testes para a frente
testsT1 :: Test
testsT1 = TestLabel "Testa se a personagem se move para a frente corretamente" $ test ["Teste 1" ~: (Jogo (Jogador (6,4)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(6,5)) mapa4)]

testsT2 :: Test
testsT2 = TestLabel "Testa se a personagem se move para a frente corretamente" $ test ["Teste 2" ~: (Jogo (Jogador (0,0)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(0,1)) mapa4)]

testsT3 :: Test
testsT3 = TestLabel "Testa se a personagem se move para a frente corretamente" $ test ["Teste 3" ~: (Jogo (Jogador (1,6)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(1,7)) mapa4)]

testsT4 :: Test
testsT4 = TestLabel "Testa se a personagem se move para a frente corretamente" $ test ["Teste 4" ~: (Jogo (Jogador (1,7)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(1,8)) mapa4)]

testsT5 :: Test
testsT5 = TestLabel "Testa se a personagem se move para a frente corretamente" $ test ["Teste 5" ~: (Jogo (Jogador (0,0)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada (-1),[Carro,Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro])]))  ~=? bot (Jogo (Jogador(0,1)) mapa3)]

testsT6 :: Test
testsT6 = TestLabel "Testa se a personagem se move para a frente corretamente" $ test ["Teste 6" ~: (Jogo (Jogador (8,1)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada (-1),[Carro,Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro])]))  ~=? bot (Jogo (Jogador(8,2)) mapa3)]

testsT7 :: Test
testsT7 = TestLabel "Testa se a personagem se move para a frente corretamente" $ test ["Teste 7" ~: (Jogo (Jogador (3,3)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada (-1),[Carro,Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro])]))  ~=? bot (Jogo (Jogador(3,4)) mapa3)]

testsT8 :: Test
testsT8 = TestLabel "Testa se a personagem se move para a frente corretamente" $ test ["Teste 8" ~: (Jogo (Jogador (0,4)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Carro,Nenhum,Carro,Carro,Nenhum]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(0,5)) mapa2)]

testsT9 :: Test
testsT9 = TestLabel "Testa se a personagem se move para a frente corretamente" $ test ["Teste 9" ~: (Jogo (Jogador (3,0)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Carro,Nenhum,Carro,Carro,Nenhum]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(3,1)) mapa2)]

testsT10 :: Test
testsT10 = TestLabel "Testa se a personagem se move para a frente corretamente" $ test ["Teste 10" ~: (Jogo (Jogador (3,0)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Nenhum,Tronco,Tronco,Tronco,Tronco]),(Rio 1,[Tronco,Nenhum,Tronco,Nenhum,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco]),(Rio 3,[Tronco,Nenhum,Tronco,Nenhum,Tronco,Tronco]),(Estrada 1,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(3,1)) mapa1)]

--10 testes para a esquerda
testsT11 :: Test
testsT11 = TestLabel "Testa se a personagem se move para a esquerda corretamente" $ test ["Teste 11" ~: (Jogo (Jogador (0,1)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(1,1)) mapa4)]

testsT12 :: Test
testsT12 = TestLabel "Testa se a personagem se move para a esquerda corretamente" $ test ["Teste 12" ~: (Jogo (Jogador (6,7)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(7,7)) mapa4)]

testsT14 :: Test
testsT14 = TestLabel "Testa se a personagem se move para a esquerda corretamente" $ test ["Teste 14" ~: (Jogo (Jogador (1,6)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(2,6)) mapa4)]

testsT15 :: Test
testsT15 = TestLabel "Testa se a personagem se move para a esquerda corretamente" $ test ["Teste 15" ~: (Jogo (Jogador (0,1)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada (-1),[Carro,Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro])]))  ~=? bot (Jogo (Jogador(1,1)) mapa3)]

testsT16 :: Test
testsT16 = TestLabel "Testa se a personagem se move para a esquerda corretamente" $ test ["Teste 16" ~: (Jogo (Jogador (1,7)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada (-1),[Carro,Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro])]))  ~=? bot (Jogo (Jogador(2,7)) mapa3)]

testsT17 :: Test
testsT17 = TestLabel "Testa se a personagem se move para a esquerda corretamente" $ test ["Teste 17" ~: (Jogo (Jogador (7,6)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada (-1),[Carro,Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro])]))  ~=? bot (Jogo (Jogador(8,6)) mapa3)]

testsT18 :: Test
testsT18 = TestLabel "Testa se a personagem se move para a esquerda corretamente" $ test ["Teste 18" ~: (Jogo (Jogador (3,5)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Carro,Nenhum,Carro,Carro,Nenhum]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(4,5)) mapa2)]

testsT19 :: Test
testsT19 = TestLabel "Testa se a personagem se move para a esquerda corretamente" $ test ["Teste 19" ~: (Jogo (Jogador (1,7)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Nenhum,Tronco,Tronco,Tronco,Tronco]),(Rio 1,[Tronco,Nenhum,Tronco,Nenhum,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco]),(Rio 3,[Tronco,Nenhum,Tronco,Nenhum,Tronco,Tronco]),(Estrada 1,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(2,7)) mapa1)]

testsT20 :: Test
testsT20 = TestLabel "Testa se a personagem se move para a esquerda corretamente" $ test ["Teste 20" ~: (Jogo (Jogador (2,5)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Nenhum,Tronco,Tronco,Tronco,Tronco]),(Rio 1,[Tronco,Nenhum,Tronco,Nenhum,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco]),(Rio 3,[Tronco,Nenhum,Tronco,Nenhum,Tronco,Tronco]),(Estrada 1,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(3,5)) mapa1)]

--10 testes para a direita
testsT21 :: Test
testsT21 = TestLabel "Testa se a personagem se move para a direita corretamente" $ test ["Teste 21" ~: (Jogo (Jogador (1,7)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(0,7)) mapa4)]

testsT22 :: Test
testsT22 = TestLabel "Testa se a personagem se move para a direita corretamente" $ test ["Teste 22" ~: (Jogo (Jogador (9,8)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(8,8)) mapa4)]

testsT23 :: Test
testsT23 = TestLabel "Testa se a personagem se move para a direita corretamente" $ test ["Teste 23" ~: (Jogo (Jogador (7,7)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(6,7)) mapa4)]

testsT24 :: Test
testsT24 = TestLabel "Testa se a personagem se move para a direita corretamente" $ test ["Teste 24" ~: (Jogo (Jogador (2,7)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada (-1),[Carro,Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro])]))  ~=? bot (Jogo (Jogador(1,7)) mapa3)]

testsT25 :: Test
testsT25 = TestLabel "Testa se a personagem se move para a direita corretamente" $ test ["Teste 25" ~: (Jogo (Jogador (3,5)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada (-1),[Carro,Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro])]))  ~=? bot (Jogo (Jogador(2,5)) mapa3)]

testsT26 :: Test
testsT26 = TestLabel "Testa se a personagem se move para a direita corretamente" $ test ["Teste 26" ~: (Jogo (Jogador (6,5)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada (-1),[Carro,Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro])]))  ~=? bot (Jogo (Jogador(5,5)) mapa3)]

testsT27 :: Test
testsT27 = TestLabel "Testa se a personagem se move para a direita corretamente" $ test ["Teste 27" ~: (Jogo (Jogador (2,7)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Carro,Nenhum,Carro,Carro,Nenhum]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(1,7)) mapa2)]

testsT28 :: Test
testsT28 = TestLabel "Testa se a personagem se move para a direita corretamente" $ test ["Teste 28" ~: (Jogo (Jogador (2,7)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Nenhum,Tronco,Tronco,Tronco,Tronco]),(Rio 1,[Tronco,Nenhum,Tronco,Nenhum,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco]),(Rio 3,[Tronco,Nenhum,Tronco,Nenhum,Tronco,Tronco]),(Estrada 1,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(1,7)) mapa1)]

--repetido (para manter a contagem direita)
testsT29 :: Test
testsT29 = TestLabel "Testa se a personagem se move para a direita corretamente" $ test ["Teste 29" ~: (Jogo (Jogador (2,7)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Nenhum,Tronco,Tronco,Tronco,Tronco]),(Rio 1,[Tronco,Nenhum,Tronco,Nenhum,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco]),(Rio 3,[Tronco,Nenhum,Tronco,Nenhum,Tronco,Tronco]),(Estrada 1,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(1,7)) mapa1)]

--repetido (para manter a contagem direita)
testsT30 :: Test
testsT30 = TestLabel "Testa se a personagem se move para a direita corretamente" $ test ["Teste 30" ~: (Jogo (Jogador (2,7)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Nenhum,Tronco,Tronco,Tronco,Tronco]),(Rio 1,[Tronco,Nenhum,Tronco,Nenhum,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco]),(Rio 3,[Tronco,Nenhum,Tronco,Nenhum,Tronco,Tronco]),(Estrada 1,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(1,7)) mapa1)]

--3 testes para trás
testsT31 :: Test
testsT31 = TestLabel "Testa se a personagem se move para trás corretamente" $ test ["Teste 31" ~: (Jogo (Jogador (4,2)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(4,1)) mapa4)]

testsT32 :: Test
testsT32 = TestLabel "Testa se a personagem se move para trás corretamente" $ test ["Teste 32" ~: (Jogo (Jogador (8,5)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Nenhum,Carro,Carro,Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum]),(Estrada 2,[Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum]),(Estrada (-1),[Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro,Carro]),(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum])]))  ~=? bot (Jogo (Jogador(8,4)) mapa4)]

testsT33 :: Test
testsT33 = TestLabel "Testa se a personagem se move para trás corretamente" $ test ["Teste 33" ~: (Jogo (Jogador (2,7)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Tronco,Tronco,Tronco,Tronco,Nenhum]),(Rio 1,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio (-2),[Tronco,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 2,[Carro,Carro,Nenhum,Carro,Carro,Nenhum]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(2,6)) mapa2)]

--2 testes em que a personagem fica encurralada (não se move)
testsT34 :: Test
testsT34 = TestLabel "Testa se a personagem não se move" $ test ["Teste 34" ~: (Jogo (Jogador (4,7)) (Mapa 10 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Nenhum,Arvore,Nenhum,Nenhum]),(Relva,[Nenhum,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore,Nenhum,Nenhum]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Nenhum,Tronco,Tronco,Tronco,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco,Nenhum,Tronco,Nenhum,Nenhum]),(Relva,[Arvore,Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum,Arvore]),(Estrada 3,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada (-1),[Carro,Nenhum,Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Nenhum,Carro]),(Estrada 1,[Nenhum,Carro,Carro,Nenhum,Carro,Carro,Carro,Nenhum,Nenhum,Carro])]))  ~=? bot (Jogo (Jogador(4,7)) mapa3)]

testsT35 :: Test
testsT35 = TestLabel "Testa se a personagem não se move" $ test ["Teste 35" ~: (Jogo (Jogador (0,4)) (Mapa 6 [(Relva,[Nenhum,Arvore,Arvore,Nenhum,Arvore,Nenhum]),(Rio (-1),[Nenhum,Nenhum,Tronco,Tronco,Tronco,Tronco]),(Rio 1,[Tronco,Nenhum,Tronco,Nenhum,Nenhum,Tronco]),(Rio (-2),[Nenhum,Nenhum,Tronco,Tronco,Nenhum,Tronco]),(Rio 3,[Tronco,Nenhum,Tronco,Nenhum,Tronco,Tronco]),(Estrada 1,[Carro,Carro,Nenhum,Nenhum,Carro,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Carro,Carro]),(Relva,[Arvore,Nenhum,Nenhum,Arvore,Nenhum,Arvore])]))  ~=? bot (Jogo (Jogador(0,4)) mapa1)]


testesBot = (TestList [testsT1, testsT2, testsT3, testsT4, testsT5, testsT6, testsT7, testsT8, testsT9, testsT10, testsT11, testsT12, testsT14, testsT15, testsT16, testsT17, testsT18, testsT19, testsT20, testsT21, testsT22, testsT23, testsT24, testsT25, testsT26, testsT27, testsT28, testsT29, testsT30, testsT31, testsT32, testsT33, testsT34, testsT35])