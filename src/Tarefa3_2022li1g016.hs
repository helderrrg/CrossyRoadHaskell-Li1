{- |
Module      : Tarefa3_2022li1g016
Description : Movimentação do personagem e obstáculos
Copyright   : Daniel Silva <a104086@alunos.uminho.pt>
              Hélder Gomes <a104100@alunos.uminho.pt>

Módulo para a realização da Tarefa 3 do projeto de LI1 em 2022/23.
-}

module Tarefa3_2022li1g016 where

import LI12223
import Data.List

{- |
Função principal que anima o jogo.  
A função recebe um elemento Jogo e uma Jogada e retorna um Jogo.  

@
animaJogo :: Jogo -> Jogada -> Jogo
animaJogo (Jogo (Jogador(x,y)) mapa@(Mapa l ((Rio v, obstaculos):t))) jogada = (Jogo (movimentoTotal mapa (Jogador (x,y)) jogada) (movimentoObstaculos mapa)) 
@

== Exemplos de utilização:

>>> animaJogo (Jogo (Jogador(1,0)) (Mapa 2 [(Rio (-1), [Nenhum, Tronco])])) Parado = Jogo (Jogador (0,0)) (Mapa 2 [(Rio (-1),[Tronco,Nenhum])])

-}

animaJogo :: Jogo -> Jogada -> Jogo
animaJogo jogo@(Jogo jogador@(Jogador(x,y)) (Mapa l terrObst)) jogada = (Jogo (movimentoTotal jogo jogada) (Mapa l (movimentoObstaculos terrObst jogada jogador)))

{- |
Função principal que anima apenas o Jogador.  
A função recebe um elemento Jogo e uma Jogada e retorna um Jogador.  

@
animaJogador :: Jogo -> Jogada -> Jogador
animaJogador jogo@(Jogo (Jogador(x,y)) (Mapa l ((terreno, obstaculos):t))) jogada = (movimentoTotal jogo jogada)
@

-}

animaJogador :: Jogo -> Jogada -> Jogador
animaJogador jogo@(Jogo (Jogador(x,y)) (Mapa l ((terreno, obstaculos):t))) jogada = (movimentoTotal jogo jogada)

{- |
Função principal que anima apenas o Mapa.  
A função recebe um elemento Jogo e uma Jogada e retorna um Mapa.  

@
animaMapa :: Jogo -> Jogada -> Mapa
animaMapa jogo@(Jogo jogador@(Jogador(x,y)) (Mapa l terrObst)) jogada = (Mapa l (movimentoObstaculos terrObst jogada jogador))
@

-}

animaMapa :: Jogo -> Jogada -> Mapa
animaMapa jogo@(Jogo jogador@(Jogador(x,y)) (Mapa l terrObst)) jogada = (Mapa l (movimentoObstaculos terrObst jogada jogador))

{- |

A função recebe um tuplo com um terreno e uma lista de obstáculos e devolve o mesmo tipo após as devidas alterações.
Esta função de forma recursiva altera a posição dos obstáculos (da Relva e Estrada) v unidades para a direita/esquerda, dependendo do sinal de v.

@
movimentoObstaculosAux :: [(Terreno,[Obstaculo])] -> [(Terreno,[Obstaculo])]
movimentoObstaculosAux [] = []
movimentoObstaculosAux ((Rio v, obstaculos):t) = if v > 0
                                                 then ((Rio v, (take v (reverse obstaculos)) ++ take ((length obstaculos) - v) obstaculos): movimentoObstaculosAux t)
                                                 else ((Rio v, (drop (-v) obstaculos) ++ (take (-v) obstaculos)): movimentoObstaculosAux t)
movimentoObstaculosAux ((Estrada v, obstaculos):t) = if v > 0
                                                     then ((Estrada v, (take v (reverse obstaculos)) ++ take ((length obstaculos) - v) obstaculos): movimentoObstaculosAux t)
                                                     else ((Estrada v, (drop (-v) obstaculos) ++ (take (-v) obstaculos)): movimentoObstaculosAux t)
movimentoObstaculosAux ((Relva, obstaculos):t) = ((Relva, obstaculos): movimentoObstaculosAux t)
@

-}

movimentoObstaculosAux :: [(Terreno,[Obstaculo])] -> [(Terreno,[Obstaculo])]
movimentoObstaculosAux [] = []
movimentoObstaculosAux ((Rio v, obstaculos):t) = if v > 0
                                                 then ((Rio v, (take v (reverse obstaculos)) ++ take ((length obstaculos) - v) obstaculos): movimentoObstaculosAux t)
                                                 else ((Rio v, (drop (-v) obstaculos) ++ (take (-v) obstaculos)): movimentoObstaculosAux t)
movimentoObstaculosAux ((Estrada v, obstaculos):t) = if v > 0
                                                     then ((Estrada v, (take v (reverse obstaculos)) ++ take ((length obstaculos) - v) obstaculos): movimentoObstaculosAux t)
                                                     else ((Estrada v, (drop (-v) obstaculos) ++ (take (-v) obstaculos)): movimentoObstaculosAux t)
movimentoObstaculosAux ((Relva, obstaculos):t) = ((Relva, obstaculos): movimentoObstaculosAux t) 

{- |
A função recebe um Jogo e uma Jogada e devolve um Jogador.
Esta função verifica se a posição do jogador é em cima de um Tronco, caso seja move-se junto com o rio, senão nada acontece.
Caso o movimento seja para cima ou para baixo, o jogador não se move com o rio, a menos que esse movimento seja impedido por uma árvore.

@
movimentoTotal :: Jogo -> Jogada -> Jogador
movimentoTotal jogo@(Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Cima) = if ((posicaoJogador jogo) !! x == Tronco) && ((snd(terrObst !! (y-1))) !! x) == Arvore
                                                                          then movimentoTotalAux (Jogo (Jogador ((x+velocidadeRio jogo),y)) (Mapa l terrObst)) (Move Cima)
                                                                          else movimentoTotalAux jogo (Move Cima)
movimentoTotal jogo@(Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Baixo) = if ((posicaoJogador jogo) !! x == Tronco) && ((snd(terrObst !! (y+1))) !! x) == Arvore
                                                                           then movimentoTotalAux (Jogo (Jogador ((x+velocidadeRio jogo),y)) (Mapa l terrObst)) (Move Baixo)
                                                                           else movimentoTotalAux jogo (Move Baixo)
movimentoTotal jogo@(Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Esquerda) = if ((posicaoJogador jogo) !! x == Tronco)
                                                                              then (Jogador ((x -1 +velocidadeRio jogo),y))
                                                                              else movimentoTotalAux jogo (Move Esquerda)
movimentoTotal jogo@(Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Direita) = if ((posicaoJogador jogo) !! x == Tronco)
                                                                             then (Jogador ((x +1 +velocidadeRio jogo),y))
                                                                             else movimentoTotalAux jogo (Move Direita)  
movimentoTotal jogo@(Jogo (Jogador(x,y)) (Mapa l terrObst)) Parado = if ((posicaoJogador jogo) !! x == Tronco)
                                                                     then (Jogador ((x +velocidadeRio jogo),y))
                                                                     else movimentoTotalAux jogo Parado   
@

-}

movimentoTotal :: Jogo -> Jogada -> Jogador
movimentoTotal (Jogo jogador (Mapa _ [])) _ = jogador
movimentoTotal jogo@(Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Cima) = if ((posicaoJogador jogo) !! x == Tronco) && ((snd(terrObst !! (y-1))) !! x) == Arvore
                                                                          then movimentoTotalAux (Jogo (Jogador ((x+velocidadeRio jogo),y)) (Mapa l terrObst)) (Move Cima)
                                                                          else movimentoTotalAux jogo (Move Cima)
movimentoTotal jogo@(Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Baixo) = if ((posicaoJogador jogo) !! x == Tronco) && ((snd(terrObst !! (y+1))) !! x) == Arvore
                                                                           then movimentoTotalAux (Jogo (Jogador ((x+velocidadeRio jogo),y)) (Mapa l terrObst)) (Move Baixo)
                                                                           else movimentoTotalAux jogo (Move Baixo)
movimentoTotal jogo@(Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Esquerda) = if ((posicaoJogador jogo) !! x == Tronco)
                                                                              then (Jogador ((x -1 {-+velocidadeRio jogo-}),y))
                                                                              else movimentoTotalAux jogo (Move Esquerda)
movimentoTotal jogo@(Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Direita) = if ((posicaoJogador jogo) !! x == Tronco)
                                                                             then (Jogador ((x +1 {-+velocidadeRio jogo-}),y))
                                                                             else movimentoTotalAux jogo (Move Direita)  
movimentoTotal jogo@(Jogo (Jogador(x,y)) (Mapa l terrObst)) Parado = if ((posicaoJogador jogo) !! x == Tronco)
                                                                     then (Jogador ((x +velocidadeRio jogo),y))
                                                                     else movimentoTotalAux jogo Parado                                                                                                                                                   

{- |
A função recebe um jogo e uma jogada e retorna um jogador.
Esta função verifica se o movimento é possível, ou seja, se o jogador não sai dos limites do mapa ou se descolaca para "cima" de uma árvore.
Caso seja possível, o movimento acontece, senão mantém a posição inicial.

@
movimentoTotalAux :: Jogo -> Jogada -> Jogador
movimentoTotalAux (Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Cima) = if y == 0 || ((snd(terrObst !! (y-1))) !! x) == Arvore
                                                                        then Jogador (x,y)
                                                                        else Jogador (x,y-1)
movimentoTotalAux (Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Baixo) = if y == ((length terrObst)-1) || ((snd(terrObst !! (y+1))) !! x) == Arvore
                                                                        then Jogador (x,y)
                                                                        else Jogador (x,y+1)
movimentoTotalAux (Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Esquerda) = if x == 0 || ((snd(terrObst !! y)) !! (x-1)) == Arvore
                                                                        then Jogador (x,y)
                                                                        else Jogador (x-1,y)
movimentoTotalAux (Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Direita) = if x == (l-1) || ((snd(terrObst !! y)) !! (x+1)) == Arvore
                                                                        then Jogador (x,y)
                                                                        else Jogador (x+1,y)
movimentoTotalAux (Jogo (Jogador(x,y)) (Mapa l terrObst)) Parado = Jogador (x,y) 
@

-}

movimentoTotalAux :: Jogo -> Jogada -> Jogador
movimentoTotalAux (Jogo jogador (Mapa _ [])) _ = jogador
movimentoTotalAux (Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Cima) = if y == 0 || ((snd(terrObst !! (y-1))) !! x) == Arvore
                                                                        then Jogador (x,y)
                                                                        else Jogador (x,y-1)
movimentoTotalAux (Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Baixo) = if y == ((length terrObst)-1) || ((snd(terrObst !! (y+1))) !! x) == Arvore
                                                                        then Jogador (x,y)
                                                                        else Jogador (x,y+1)
movimentoTotalAux (Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Esquerda) = if x == 0 || ((snd(terrObst !! y)) !! (x-1)) == Arvore
                                                                        then Jogador (x,y)
                                                                        else Jogador (x-1,y)
movimentoTotalAux (Jogo (Jogador(x,y)) (Mapa l terrObst)) (Move Direita) = if x == (l-1) || ((snd(terrObst !! y)) !! (x+1)) == Arvore
                                                                        then Jogador (x,y)
                                                                        else Jogador (x+1,y)
movimentoTotalAux (Jogo (Jogador(x,y)) (Mapa l terrObst)) Parado = Jogador (x,y) 

{- |
A função receve um jogo e devolve a velocidade do rio que o jogador se encontra.

@
velocidadeRio :: Jogo -> Velocidade
velocidadeRio (Jogo (Jogador(x,y)) (Mapa _ terrObst)) = velocidade (fst (terrObst !! y))
        where
            velocidade (Rio v) = v
@

-}

velocidadeRio :: Jogo -> Velocidade
velocidadeRio (Jogo _ (Mapa _ [])) = 0
velocidadeRio (Jogo (Jogador(x,y)) (Mapa _ terrObst)) = velocidade (fst (terrObst !! y))
        where
            velocidade (Rio v) = v

{- |
A função recebe um jogo e devolve a lista de obstáculos da linha que o jogador se encontra.

@
posicaoJogador :: Jogo -> [Obstaculo]
posicaoJogador (Jogo (Jogador(x,y)) (Mapa _ terrObst)) = (snd (terrObst !! y))
@

-}

posicaoJogador :: Jogo -> [Obstaculo]
posicaoJogador (Jogo _ (Mapa _ [])) = [] 
posicaoJogador (Jogo (Jogador(x,y)) (Mapa _ terrObst)) = (snd (terrObst !! y))

{- |
A função recebe a lista de obstáculos de uma estrada a velocidade e a posição x de um jogador e devolve a lista de obstáculos v unidades para a direita/esquerda, caso o jogador se encontre na mesma posição que um carro, devolve essa lista.

@
moveEstrada :: [Obstaculo] -> Int -> Int -> [Obstaculo]
moveEstrada l 0 _ = l
moveEstrada l v x | v > 0 && (l !! x) /= Carro = moveEstrada (last l: init l) (v-1) x
                  | v < 0 && (l !! x) /= Carro = moveEstrada (tail l ++ [head l]) (v+1) x
                  | otherwise = l
@

-}

moveEstrada :: [Obstaculo] -> Int -> Int -> [Obstaculo]
moveEstrada l 0 _ = l
moveEstrada l v x | v > 0 && (l !! x) /= Carro = moveEstrada (last l: init l) (v-1) x
                  | v < 0 && (l !! x) /= Carro = moveEstrada (tail l ++ [head l]) (v+1) x
                  | otherwise = l

{- |
A função recebe o mapa em forma de tuplo, terreno e lista de obstáculos, uma jogada e um jogador e move, com a função moveEstrada a linha que o jogador se encontra, caso seja, uma estrada e todas as oulinhasCima com a movimentoObstaculosAux.

@
movimentoObstaculos :: [(Terreno,[Obstaculo])] -> Jogada -> Jogador -> [(Terreno,[Obstaculo])]
movimentoObstaculos terrObst mov (Jogador (x,y)) 
        | mov == (Move Direita) && (toString (fst(terrObst !! y))) == "Estrada" = movimentoObstaculosAux (linhasBaixo $ splitAt (y+1) terrObst) ++ [(Estrada v, moveEstrada (jogador $ splitAt (y+1) terrObst) v (x+1))] ++ movimentoObstaculosAux (linhasCima $ splitAt (y+1) terrObst)
        | mov == (Move Esquerda) && (toString (fst(terrObst !! y))) == "Estrada" = movimentoObstaculosAux (linhasBaixo $ splitAt (y+1) terrObst) ++ [(Estrada v, moveEstrada (jogador $ splitAt (y+1) terrObst) v (x-1))] ++ movimentoObstaculosAux (linhasCima $ splitAt (y+1) terrObst)
        | mov == (Move Cima) && (toString (fst(terrObst !! (y-1)))) == "Estrada" = movimentoObstaculosAux (linhasBaixo $ splitAt y terrObst) ++ [(Estrada velCima, moveEstrada (jogador $ splitAt y terrObst) velCima x)] ++ movimentoObstaculosAux (linhasCima $ splitAt y terrObst)
        | mov == (Move Baixo) && (toString (fst(terrObst !! (y+1)))) == "Estrada" = movimentoObstaculosAux (linhasBaixo $ splitAt (y+2) terrObst) ++ [(Estrada velBaixo, moveEstrada (jogador $ splitAt (y+2) terrObst) velBaixo x)] ++ movimentoObstaculosAux (linhasCima $ splitAt (y+2) terrObst)
        | mov == Parado && (toString (fst(terrObst !! y))) == "Estrada" = movimentoObstaculosAux (linhasBaixo $ splitAt (y+1) terrObst) ++ [(Estrada v, moveEstrada (jogador $ splitAt (y+1) terrObst) v x)] ++ movimentoObstaculosAux (linhasCima $ splitAt (y+1) terrObst)
        | otherwise = movimentoObstaculosAux terrObst

     where v = velocidade (fst(terrObst !! y))
           velCima = velocidade (fst (terrObst !! (y-1)))
           velBaixo = velocidade (fst (terrObst !! (y+1)))
           velocidade (Estrada x)  = x
           toString :: Terreno -> String
           toString t = case t of Estrada _ -> "Estrada"
                                  Rio _     -> "Rio"    
                                  Relva     -> "Relva" 
           linhasBaixo x  = init $ fst x
           linhasCima x = snd x
           jogador x = snd $ last $ fst x
@

-}

movimentoObstaculos :: [(Terreno,[Obstaculo])] -> Jogada -> Jogador -> [(Terreno,[Obstaculo])]
movimentoObstaculos terrObst mov (Jogador (x,y)) 
        | mov == (Move Direita) && (toString (fst(terrObst !! y))) == "Estrada" = movimentoObstaculosAux (linhasBaixo $ splitAt (y+1) terrObst) ++ [(Estrada v, moveEstrada (jogador $ splitAt (y+1) terrObst) v (x+1))] ++ movimentoObstaculosAux (linhasCima $ splitAt (y+1) terrObst)
        | mov == (Move Esquerda) && (toString (fst(terrObst !! y))) == "Estrada" = movimentoObstaculosAux (linhasBaixo $ splitAt (y+1) terrObst) ++ [(Estrada v, moveEstrada (jogador $ splitAt (y+1) terrObst) v (x-1))] ++ movimentoObstaculosAux (linhasCima $ splitAt (y+1) terrObst)
        | mov == (Move Cima) && (toString (fst(terrObst !! (y-1)))) == "Estrada" = movimentoObstaculosAux (linhasBaixo $ splitAt y terrObst) ++ [(Estrada velCima, moveEstrada (jogador $ splitAt y terrObst) velCima x)] ++ movimentoObstaculosAux (linhasCima $ splitAt y terrObst)
        | mov == (Move Baixo) && (toString (fst(terrObst !! (y+1)))) == "Estrada" = movimentoObstaculosAux (linhasBaixo $ splitAt (y+2) terrObst) ++ [(Estrada velBaixo, moveEstrada (jogador $ splitAt (y+2) terrObst) velBaixo x)] ++ movimentoObstaculosAux (linhasCima $ splitAt (y+2) terrObst)
        | mov == Parado && (toString (fst(terrObst !! y))) == "Estrada" = movimentoObstaculosAux (linhasBaixo $ splitAt (y+1) terrObst) ++ [(Estrada v, moveEstrada (jogador $ splitAt (y+1) terrObst) v x)] ++ movimentoObstaculosAux (linhasCima $ splitAt (y+1) terrObst)
        | otherwise = movimentoObstaculosAux terrObst

     where v = velocidade (fst(terrObst !! y))
           velCima = velocidade (fst (terrObst !! (y-1)))
           velBaixo = velocidade (fst (terrObst !! (y+1)))
           velocidade (Estrada x)  = x
           toString :: Terreno -> String
           toString t = case t of Estrada _ -> "Estrada"
                                  Rio _     -> "Rio"    
                                  Relva     -> "Relva" 
           linhasBaixo x  = init $ fst x
           linhasCima x = snd x
           jogador x = snd $ last $ fst x
