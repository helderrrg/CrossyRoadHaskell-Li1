module Tarefa2_2022li1g016_Spec where

import LI12223
import Tarefa2_2022li1g016
import Test.HUnit

testsT1 :: Test
testsT1 = TestLabel "Testa se a função cria mapa válidos" $ test ["Teste 1" ~: Mapa 2 [(Estrada (-2),[Nenhum,Carro]),(Rio (-1),[Nenhum,Tronco])] ~=? estendeMapa (Mapa 2 [(Rio (-1), [Nenhum, Tronco])]) 1]

testsT2 :: Test
testsT2 = TestLabel "Testa se a função cria mapa válidos" $ test ["Teste 2" ~: Mapa 2 [(Relva,[Nenhum,Arvore]),(Rio (-1),[Nenhum,Tronco])] ~=? estendeMapa (Mapa 2 [(Rio (-1), [Nenhum, Tronco])]) 2]

testsT3 :: Test
testsT3 = TestLabel "Testa se a função cria mapa válidos" $ test ["Teste 3" ~: Mapa 2 [(Rio 1,[Nenhum,Nenhum]),(Rio (-1),[Nenhum,Tronco])] ~=? estendeMapa (Mapa 2 [(Rio (-1), [Nenhum, Tronco])]) 3]

testsT4 :: Test
testsT4 = TestLabel "Testa se a função cria mapa válidos" $ test ["Teste 4" ~: Mapa 5 [(Estrada (-2),[Nenhum,Carro,Carro,Nenhum,Carro]),(Estrada 2,[Nenhum,Carro,Carro,Nenhum,Nenhum])] ~=? estendeMapa (Mapa 5 [(Estrada 2, [Nenhum, Carro, Carro, Nenhum, Nenhum])]) 25]

testsT5 :: Test
testsT5 = TestLabel "Testa se a função cria terrenos válidos" $ test ["Teste 5" ~: [Rio 0,Estrada 0,Relva] ~=? proximosTerrenosValidos (Mapa 2 [(Relva, [Nenhum, Arvore])])]

testsT6 :: Test
testsT6 = TestLabel "Testa se a função cria terrenos válidos" $ test ["Teste 6" ~: [Estrada 0,Relva] ~=? proximosTerrenosValidos (Mapa 2 [(Rio 1, [Nenhum, Tronco]), (Rio (-1), [Tronco, Nenhum]),(Rio 2, [Nenhum, Tronco]),(Rio (-1), [Nenhum, Tronco])])]

testsT7 :: Test
testsT7 = TestLabel "Testa se a função cria mapa válidos" $ test ["Teste 7" ~:Mapa 4 [(Rio (-1),[Nenhum,Tronco,Tronco,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Carro])] ~=? estendeMapa (Mapa 4 [(Estrada 2, [Nenhum, Carro, Carro, Carro])]) 45]

testsT8 :: Test
testsT8 = TestLabel "Testa se a função cria mapa válidos" $ test ["Teste 8" ~: Mapa 4 [(Estrada (-2),[Nenhum,Carro,Nenhum,Carro]),(Estrada 2,[Nenhum,Carro,Carro,Carro])] ~=? estendeMapa (Mapa 4 [(Estrada 2, [Nenhum, Carro, Carro, Carro])]) 46]

testsT9 :: Test
testsT9 = TestLabel "Testa se a função cria mapa válidos" $ test ["Teste 9" ~: Mapa 4 [(Rio 1,[Nenhum,Tronco,Tronco,Nenhum]),(Estrada 2,[Nenhum,Carro,Carro,Carro])] ~=? estendeMapa (Mapa 4 [(Estrada 2, [Nenhum, Carro, Carro, Carro])]) 99]

testsT10 :: Test
testsT10 = TestLabel "Testa se a função cria velocidades válidas" $ test ["Teste 10" ~: (-1) ~=? vRio (Rio 2) 27]

testsT11 :: Test
testsT11 = TestLabel "Testa se a função cria velocidades válidas" $ test ["Teste 11" ~: (-2) ~=? vRio (Rio 2) 85]

testsT12 :: Test
testsT12 = TestLabel "Testa se a função cria velocidades válidas" $ test ["Teste 12" ~: 1 ~=? vRio (Rio (-2)) 27]

testsT13 :: Test
testsT13 = TestLabel "Testa se a função cria velocidades válidas" $ test ["Teste 13" ~: 2 ~=? vRio (Rio (-2)) 85]

testesTarefa2 = (TestList [testsT1, testsT2, testsT3, testsT4, testsT5, testsT6, testsT7, testsT8, testsT9, testsT10, testsT11, testsT12, testsT13])
