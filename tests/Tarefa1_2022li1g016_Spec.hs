module Tarefa1_2022li1g016_Spec where

import LI12223
import Tarefa1_2022li1g016
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

testsT1 :: Test
testsT1 = TestLabel "Teste geral" $ test ["Teste 1" ~: True ~=? mapaValido mapa1]

testsT2 :: Test
testsT2 = TestLabel "Testa se carros não podem ter mais de 3 unidades" $ test ["Teste 2" ~: False ~=? mapaValido (Mapa 6 [(Estrada (-1), [Carro, Carro, Carro, Carro, Nenhum, Nenhum])])]

testsT3 :: Test
testsT3 = TestLabel "Testa se carros não podem ter mais de 3 unidades (após v unidades)" $ test ["Teste 3" ~: False ~=? mapaValido (Mapa 6 [(Estrada (-1), [Carro, Carro, Carro, Nenhum, Nenhum, Carro])])]

testsT4 :: Test
testsT4 = TestLabel "Testa se troncos não podem ter mais de 5 unidades" $ test ["Teste 4" ~: False ~=? mapaValido (Mapa 8 [(Rio 2, [Nenhum, Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco, Tronco])])]

testsT5 :: Test
testsT5 = TestLabel "Testa se troncos não podem ter mais de 5 unidades (após v unidades)" $ test ["Teste 5" ~: False ~=? mapaValido (Mapa 8 [(Rio 2, [Tronco, Tronco, Nenhum, Nenhum, Tronco, Tronco, Tronco, Tronco])])]

testsT6 :: Test
testsT6 = TestLabel "Testa se rios contiguos têm velecidades com sinal oposto" $ test ["Teste 6" ~: True ~=? mapaValido (Mapa 2 [(Rio (-1), [Nenhum, Tronco]), (Rio 3, [Tronco, Nenhum])])]

testsT7 :: Test
testsT7 = TestLabel "Testa se rios contiguos têm velecidades com sinal oposto" $ test ["Teste 7" ~: False ~=? mapaValido (Mapa 2 [(Rio 2, [Nenhum, Tronco]), (Rio 1, [Tronco, Nenhum])])]

testsT8 :: Test
testsT8 = TestLabel "Testa se estradas têm obstáculos impróprios" $ test ["Teste 8" ~: False ~=? mapaValido (Mapa 2 [(Estrada (-1), [Nenhum, Tronco])])]

testsT9 :: Test
testsT9 = TestLabel "Testa se rios têm obstáculos impróprios" $ test ["Teste 9" ~: False ~=? mapaValido (Mapa 2 [(Rio 3, [Arvore, Nenhum])])]

testsT10 :: Test
testsT10 = TestLabel "Testa se relvas têm obstáculos impróprios" $ test ["Teste 10" ~: False ~=? mapaValido (Mapa 2 [(Relva, [Carro, Nenhum])])]

testsT11 :: Test
testsT11 = TestLabel "Testa se terrenos têm, pelo menos, 1 'Nenhum'" $ test ["Teste 11" ~: False ~=? mapaValido (Mapa 2 [(Rio 2, [Nenhum, Tronco]), (Rio (-1), [Tronco, Tronco])])]

testsT12 :: Test
testsT12 = TestLabel "Testa se o comprimento da lista de obstáculos é igual à largura" $ test ["Teste 12" ~: False ~=? mapaValido (Mapa 6 [(Estrada 2, [Carro, Carro, Nenhum])])]

testsT13 :: Test
testsT13 = TestLabel "Testa se contiguamente existem, no máximo 4 rios" $ test ["Teste 13" ~: False ~=? mapaValido (Mapa 2 [(Rio (-1), [Nenhum, Tronco]), (Rio 1, [Tronco, Nenhum]), (Rio (-2), [Nenhum, Tronco]), (Rio 3, [Tronco, Nenhum]), (Rio (-2), [Tronco, Nenhum])])]

testsT14 :: Test
testsT14 = TestLabel "Testa se contiguamente existem, no máximo 5 estradas" $ test ["Teste 14" ~: False ~=? mapaValido (Mapa 2 [(Estrada 2, [Nenhum, Carro]), (Estrada 1, [Carro, Nenhum]), (Estrada (-2), [Nenhum, Carro]), (Estrada 3, [Carro, Nenhum]), (Estrada (-2), [Carro, Nenhum]), (Estrada (-1), [Carro, Nenhum])])]

testsT15 :: Test
testsT15 = TestLabel "Testa se contiguamente existem, no máximo 5 relvas" $ test ["Teste 15" ~: False ~=? mapaValido (Mapa 2 [(Relva, [Nenhum, Arvore]), (Relva, [Arvore, Nenhum]), (Relva, [Nenhum, Arvore]), (Relva, [Arvore, Nenhum]), (Relva, [Arvore, Nenhum]), (Relva, [Arvore, Nenhum])])]

testesTarefa1 = (TestList [testsT1, testsT2, testsT3, testsT4, testsT5, testsT6, testsT7, testsT8, testsT9, testsT10, testsT11, testsT12, testsT13, testsT14, testsT15])