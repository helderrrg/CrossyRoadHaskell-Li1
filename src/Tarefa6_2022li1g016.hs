{- |
Module      : Main
Description : Aplicação gráfica de todas as tarefas
Copyright   : Daniel Silva <a104086@alunos.uminho.pt>
              Hélder Gomes <a104100@alunos.uminho.pt>

Módulo para a realização da Tarefa 6 do projeto de LI1 em 2022/23.
-}

module Main where

import LI12223
import Tarefa1_2022li1g016
import Tarefa2_2022li1g016
import Tarefa3_2022li1g016
import Tarefa4_2022li1g016
import Tarefa5_2022li1g016
import Bot

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Interface.IO.Game
import Data.Maybe
import Data.List



data Opcoes = Jogar
            | Sair
            | EditarJogador
            | Ajuda

data Menu = Controlador Opcoes
          | InicioJogo 
          | PerdeuJogo
          | EditarSkins Int
          | MenuAjuda

type Skin = String

type Controlo = Bool

type ControloBot = Bool

type Score = Int

type Time = Float

type MaxScore = Int

type Extra = String

type ModeloJogador = String

type EstadoGloss = (Menu, Jogo, TexturaTerreno, TexturaObstaculo, TexturaExtra, ModeloJogador, Skins, Score, MaxScore, Time, Controlo, ControloBot)

type TexturaExtra = [(Extra, Picture)] 

type TexturaTerreno = [(StringTerreno, (Picture, (Float, Float)))] 

type TexturaObstaculo = [(Obstaculo, (Picture, (Float, Float)))] 

type StringTerreno = String

type Skins = [(Skin, Picture)]

{- |
Função que entrega o estado a que o nosso jogo começa.  

@
estadoGlossInicial :: TexturaTerreno -> TexturaObstaculo -> TexturaExtra -> Skins -> EstadoGloss
estadoGlossInicial texturaTerreno texturaObstaculo texturaExtra skins = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, "1", skins, 0, 0, 0, False, False)
@

-}

estadoGlossInicial :: TexturaTerreno -> TexturaObstaculo -> TexturaExtra -> Skins -> EstadoGloss
estadoGlossInicial texturaTerreno texturaObstaculo texturaExtra skins = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, "1", skins, 0, 0, 0, False, False)

{- |
Função que devolve o estado do nosso jogo após precionarmos alguma tecla.

@
reageEventoGloss :: Event -> EstadoGloss -> EstadoGloss
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Jogar        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (InicioJogo               , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 0    , maxscore, 0   , False   , False      )
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador EditarJogador, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 1            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, False   , False      )
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Sair         , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = undefined                     
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Ajuda        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (MenuAjuda                , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyDown ) Down _ _) (Controlador Jogar        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador EditarJogador, jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyDown ) Down _ _) (Controlador EditarJogador, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Ajuda        , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyDown ) Down _ _) (Controlador Sair         , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar        , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyDown ) Down _ _) (Controlador Ajuda        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Sair         , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyUp   ) Down _ _) (Controlador Jogar        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Sair         , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyUp   ) Down _ _) (Controlador Ajuda        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador EditarJogador, jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyUp   ) Down _ _) (Controlador EditarJogador, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar        , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyUp   ) Down _ _) (Controlador Sair         , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Ajuda        , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (EditarSkins 1            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar        , jogo, texturaTerreno, texturaObstaculo, texturaExtra, "1"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (EditarSkins 2            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar        , jogo, texturaTerreno, texturaObstaculo, texturaExtra, "2"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (EditarSkins 3            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar        , jogo, texturaTerreno, texturaObstaculo, texturaExtra, "3"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (EditarSkins 4            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar        , jogo, texturaTerreno, texturaObstaculo, texturaExtra, "4"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (EditarSkins 5            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar        , jogo, texturaTerreno, texturaObstaculo, texturaExtra, "5"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (EditarSkins 1            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 5            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, "5"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (EditarSkins 2            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 1            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (EditarSkins 3            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 2            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (EditarSkins 4            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 3            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (EditarSkins 5            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 4            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (EditarSkins 1            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 2            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (EditarSkins 2            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 3            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (EditarSkins 3            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 4            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (EditarSkins 4            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 5            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (EditarSkins 5            , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 1            , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyUp   ) Down _ _) (InicioJogo, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
    | not (jogoTerminou jogo) && (not controloBot) = (InicioJogo       , (Jogo (animaJogador jogo (Move Cima)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score + 1, maxscore          , time, True    , controloBot)
    | not (jogoTerminou jogo) && (controloBot    ) = (InicioJogo       , jogo                                       , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score    , maxscore          , time, controlo, controloBot)
    | otherwise                                    = (Controlador Jogar, estadoInicial                              , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score    , max score maxscore, time, False   , controloBot)
reageEventoGloss (EventKey (SpecialKey KeyDown ) Down _ _) (InicioJogo, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
    | not (jogoTerminou jogo) && (not controloBot) = (InicioJogo       , (Jogo (animaJogador jogo (Move Baixo)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, True    , controloBot)
    | not (jogoTerminou jogo) && (controloBot    ) = (InicioJogo       , jogo                                        , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, controlo, controloBot)
    | otherwise                                    = (Controlador Jogar, estadoInicial                               , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, max score maxscore, time, False   , controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (InicioJogo, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
    | not (jogoTerminou jogo) && (not controloBot) = (InicioJogo       , (Jogo (animaJogador jogo (Move Esquerda)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, True    , controloBot)
    | not (jogoTerminou jogo) && (controloBot    ) = (InicioJogo       , jogo                                           , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, controlo, controloBot)
    | otherwise                                    = (Controlador Jogar, estadoInicial                                  , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, max score maxscore, time, False   , controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (InicioJogo, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
    | not (jogoTerminou jogo) && (not controloBot) = (InicioJogo       , (Jogo (animaJogador jogo (Move Direita)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, True    , controloBot)
    | not (jogoTerminou jogo) && (controloBot    ) = (InicioJogo       , jogo                                          , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, controlo, controloBot)
    | otherwise                                    = (Controlador Jogar, estadoInicial                                 , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, max score maxscore, time, False   , controloBot)                                                                                                                                                                                    
reageEventoGloss (EventKey (Char 'p') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, False   , controloBot)
reageEventoGloss (EventKey (Char 'P') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, False   , controloBot)             
reageEventoGloss (EventKey (Char 'b') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, False      ) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, True    , True       )
reageEventoGloss (EventKey (Char 'B') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, False      ) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, True    , True       )
reageEventoGloss (EventKey (Char 'b') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, True       ) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, True    , False      )
reageEventoGloss (EventKey (Char 'B') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, True       ) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, True    , False      )         
reageEventoGloss (EventKey (Char 'r') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (InicioJogo       , estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 0    , maxscore, 0   , False   , controloBot)
reageEventoGloss (EventKey (Char 'R') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (InicioJogo       , estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 0    , maxscore, 0   , False   , controloBot)
reageEventoGloss (EventKey (Char 'q') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 0    , maxscore, 0   , False   , False      ) 
reageEventoGloss (EventKey (Char 'Q') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 0    , maxscore, 0   , False   , False      )
reageEventoGloss (EventKey (Char 'q') Down _ _) (MenuAjuda    , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
reageEventoGloss (EventKey (Char 'Q') Down _ _) (MenuAjuda    , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (Char 'q') Down _ _) (EditarSkins _, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
reageEventoGloss (EventKey (Char 'Q') Down _ _) (EditarSkins _, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss _ s = s
@

-}

reageEventoGloss :: Event -> EstadoGloss -> EstadoGloss
-- | Controlo Menu
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Jogar        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (InicioJogo               ,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 0    , maxscore, 0   , False   , False      )
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador EditarJogador, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 1            ,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, False   , False      )
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Sair         , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = undefined                 
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Ajuda        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (MenuAjuda                ,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyDown ) Down _ _) (Controlador Jogar        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador EditarJogador,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyDown ) Down _ _) (Controlador EditarJogador, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Ajuda        ,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyDown ) Down _ _) (Controlador Sair         , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar        ,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyDown ) Down _ _) (Controlador Ajuda        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Sair         ,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyUp   ) Down _ _) (Controlador Jogar        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Sair         ,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyUp   ) Down _ _) (Controlador Ajuda        , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador EditarJogador,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyUp   ) Down _ _) (Controlador EditarJogador, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar        ,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyUp   ) Down _ _) (Controlador Sair         , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Ajuda        ,jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)

-- | Controlo Skins
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (EditarSkins 1, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, jogo, texturaTerreno, texturaObstaculo, texturaExtra, "1"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (EditarSkins 2, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, jogo, texturaTerreno, texturaObstaculo, texturaExtra, "2"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (EditarSkins 3, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, jogo, texturaTerreno, texturaObstaculo, texturaExtra, "3"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (EditarSkins 4, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, jogo, texturaTerreno, texturaObstaculo, texturaExtra, "4"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _) (EditarSkins 5, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, jogo, texturaTerreno, texturaObstaculo, texturaExtra, "5"          , skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (EditarSkins 1, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 5    , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (EditarSkins 2, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 1    , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (EditarSkins 3, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 2    , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (EditarSkins 4, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 3    , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (EditarSkins 5, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 4    , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (EditarSkins 1, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 2    , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (EditarSkins 2, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 3    , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (EditarSkins 3, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 4    , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (EditarSkins 4, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 5    , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (EditarSkins 5, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (EditarSkins 1    , jogo, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)

-- | Controlo jogador
reageEventoGloss (EventKey (SpecialKey KeyUp   ) Down _ _) (InicioJogo, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
    | not (jogoTerminou jogo) && (not controloBot) = (InicioJogo       , (Jogo (animaJogador jogo (Move Cima)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score + 1, maxscore          , time, True    , controloBot)
    | not (jogoTerminou jogo) && (controloBot    ) = (InicioJogo       , jogo                                       , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score    , maxscore          , time, controlo, controloBot)
    | otherwise                                    = (Controlador Jogar, estadoInicial                              , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score    , max score maxscore, time, False   , controloBot)
reageEventoGloss (EventKey (SpecialKey KeyDown ) Down _ _) (InicioJogo, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
    | not (jogoTerminou jogo) && (not controloBot) = (InicioJogo       , (Jogo (animaJogador jogo (Move Baixo)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, True    , controloBot)
    | not (jogoTerminou jogo) && (controloBot    ) = (InicioJogo       , jogo                                        , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, controlo, controloBot)
    | otherwise                                    = (Controlador Jogar, estadoInicial                               , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, max score maxscore, time, False   , controloBot)
reageEventoGloss (EventKey (SpecialKey KeyLeft ) Down _ _) (InicioJogo, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
    | not (jogoTerminou jogo) && (not controloBot) = (InicioJogo       , (Jogo (animaJogador jogo (Move Esquerda)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, True    , controloBot)
    | not (jogoTerminou jogo) && (controloBot    ) = (InicioJogo       , jogo                                           , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, controlo, controloBot)
    | otherwise                                    = (Controlador Jogar, estadoInicial                                  , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, max score maxscore, time, False   , controloBot)
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _) (InicioJogo, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
    | not (jogoTerminou jogo) && (not controloBot) = (InicioJogo       , (Jogo (animaJogador jogo (Move Direita)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, True    , controloBot)
    | not (jogoTerminou jogo) && (controloBot    ) = (InicioJogo       , jogo                                          , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore          , time, controlo, controloBot)
    | otherwise                                    = (Controlador Jogar, estadoInicial                                 , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, max score maxscore, time, False   , controloBot)                                                                                                                                                                                    

reageEventoGloss (EventKey (Char 'p') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, False   , controloBot)
reageEventoGloss (EventKey (Char 'P') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, False   , controloBot)
                   
reageEventoGloss (EventKey (Char 'b') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, False      ) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, True    , True       )
reageEventoGloss (EventKey (Char 'B') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, False      ) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, True    , True       )
reageEventoGloss (EventKey (Char 'b') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, True       ) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, True    , False      )
reageEventoGloss (EventKey (Char 'B') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, True       ) = (InicioJogo       , jogo         , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, True    , False      )
              
reageEventoGloss (EventKey (Char 'r') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (InicioJogo       , estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 0    , maxscore, 0   , False   , controloBot)
reageEventoGloss (EventKey (Char 'R') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (InicioJogo       , estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 0    , maxscore, 0   , False   , controloBot)

reageEventoGloss (EventKey (Char 'q') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 0    , maxscore, 0   , False   , False      ) 
reageEventoGloss (EventKey (Char 'Q') Down _ _) (InicioJogo   , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 0    , maxscore, 0   , False   , False      )
reageEventoGloss (EventKey (Char 'q') Down _ _) (MenuAjuda    , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
reageEventoGloss (EventKey (Char 'Q') Down _ _) (MenuAjuda    , jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss (EventKey (Char 'q') Down _ _) (EditarSkins _, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
reageEventoGloss (EventKey (Char 'Q') Down _ _) (EditarSkins _, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = (Controlador Jogar, estadoInicial, texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
reageEventoGloss _ s = s

{- |
Função que entrega o estado do jogo em função do tempo.  

@
reageTempoGloss :: Float -> EstadoGloss -> EstadoGloss
reageTempoGloss a (InicioJogo, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
            | not (jogoTerminou jogo) && controlo && (not controloBot) = (InicioJogo, (deslizaJogo (animaJogo jogo Parado) (score* (round time)*1000))      , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time+a, controlo, controloBot)
            | not (jogoTerminou jogo) && controlo && controloBot       = (InicioJogo, (deslizaJogo (animaJogo (bot jogo) Parado) (score* (round time)*1000)), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 9    , maxscore, time+a, controlo, controloBot)
reageTempoGloss _ s = s
@

-}

reageTempoGloss :: Float -> EstadoGloss -> EstadoGloss
reageTempoGloss a (InicioJogo, jogo@(Jogo jogador mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) 
            | not (jogoTerminou jogo) && controlo && (not controloBot) = (InicioJogo, (deslizaJogo (animaJogo jogo Parado) (score* (round time)*1000))      , texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time+a, controlo, controloBot)
            | not (jogoTerminou jogo) && controlo && controloBot       = (InicioJogo, (deslizaJogo (animaJogo (bot jogo) Parado) (score* (round time)*1000)), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, 9    , maxscore, time+a, controlo, controloBot)
reageTempoGloss _ s = s

{- |
Funções que entregam as velocidade/dimensões do nosso jogo

@
fr :: Int
fr = 1

dm :: Display
dm = FullScreen

l :: Float
l = 90

altura :: Float
altura = 350

comprimento :: Float
comprimento = (-425)
@

-}

fr :: Int
fr = 1

dm :: Display
dm = FullScreen

l :: Float
l = 90

altura :: Float
altura = 350

comprimento :: Float
comprimento = (-425)

{- |
Função que desenha o nosso jogador com a skin adequada e na posição pedida.

@
desenhaJogador :: Jogador -> ModeloJogador -> Skins -> Picture
desenhaJogador (Jogador(x,y)) modeloJogador skins = Translate (realPosX x) (realPosY y) textura
    where textura = (fromJust . lookup ("jogador" ++ modeloJogador)) skins
@

-}

desenhaJogador :: Jogador -> ModeloJogador -> Skins -> Picture
desenhaJogador (Jogador(x,y)) modeloJogador skins = Translate (realPosX x) (realPosY y) textura
    where textura = (fromJust . lookup ("jogador" ++ modeloJogador)) skins

{- |
Função que transforma a coordena x do gloss nas coordenadas do nosso jogo.

@
realPosX :: Int -> Float
realPosX = (+(comprimento - l)) . (*l) . realToFrac . succ
@

-}

realPosX :: Int -> Float
realPosX = (+(comprimento - l)) . (*l) . realToFrac . succ

{- |
Função que transforma a coordena y do gloss nas coordenadas do nosso jogo.

@
realPosY :: Int -> Float
realPosY = (+altura) . (*(-l)) . realToFrac
@

-}

realPosY :: Int -> Float
realPosY = (+altura) . (*(-l)) . realToFrac

{- |
Função que recebe um mapa e devolve uma lista com apenas as lista de obstáculos.

@
onlyObstaculos :: Mapa -> [[Obstaculo]]
onlyObstaculos (Mapa l []) = [[]]
onlyObstaculos (Mapa l ((_, obstaculos):t)) = obstaculos : onlyObstaculos (Mapa l t)
@

-}

onlyObstaculos :: Mapa -> [[Obstaculo]]
onlyObstaculos (Mapa l []) = [[]]
onlyObstaculos (Mapa l ((_, obstaculos):t)) = obstaculos : onlyObstaculos (Mapa l t)

{- |
Função que recebe um mapa e devolve uma lista com apenas as lista de terrenos.

@
onlyTerrenos :: Jogo -> [[Terreno]]
onlyTerrenos (Jogo _ (Mapa l [])) = []
onlyTerrenos (Jogo jogador (Mapa l ((terreno, []):t))) = onlyTerrenos (Jogo jogador (Mapa l t))
onlyTerrenos (Jogo jogador (Mapa l ((terreno, _):t)))  = (replicate l terreno) : onlyTerrenos (Jogo jogador (Mapa l t))
@

-}

onlyTerrenos :: Jogo -> [[Terreno]]
onlyTerrenos (Jogo _ (Mapa l [])) = []
onlyTerrenos (Jogo jogador (Mapa l ((terreno, []):t))) = onlyTerrenos (Jogo jogador (Mapa l t))
onlyTerrenos (Jogo jogador (Mapa l ((terreno, _):t)))  = (replicate l terreno) : onlyTerrenos (Jogo jogador (Mapa l t))

{- |
Função que recebe uma lista de terrenos e devolve uma lista de terrenos em String.

@
stringTerrenos :: [Terreno]-> [StringTerreno]
stringTerrenos [] = []
stringTerrenos (Rio _ :t)     = "Rio"     : stringTerrenos t
stringTerrenos (Estrada _ :t) = "Estrada" : stringTerrenos t
stringTerrenos (Relva :t)     = "Relva"   : stringTerrenos t
@

-}

stringTerrenos :: [Terreno]-> [StringTerreno]
stringTerrenos [] = []
stringTerrenos (Rio _ :t)     = "Rio"     : stringTerrenos t
stringTerrenos (Estrada _ :t) = "Estrada" : stringTerrenos t
stringTerrenos (Relva :t)     = "Relva"   : stringTerrenos t

{- |
Função que desenha a imagem escolhida para cada terreno.

@
desenhaTerreno :: Float -> Float -> StringTerreno -> TexturaTerreno -> Picture
desenhaTerreno x y terreno texturasTerrenos = Translate realX realY textura
    where tuple   = (fromJust . lookup terreno) texturasTerrenos
          textura = fst tuple
          realX   = ((+x) . fst . snd) tuple
          realY   = ((+y) . snd . snd) tuple
@

-}

desenhaTerreno :: Float -> Float -> StringTerreno -> TexturaTerreno -> Picture
desenhaTerreno x y terreno texturasTerrenos = Translate realX realY textura
    where tuple   = (fromJust . lookup terreno) texturasTerrenos
          textura = fst tuple
          realX   = ((+x) . fst . snd) tuple
          realY   = ((+y) . snd . snd) tuple

{- |
Função que desenha a linha de cada terreno.

@
desenhaLinhaTerreno :: Float -> Float -> [StringTerreno] -> TexturaTerreno -> [Picture]
desenhaLinhaTerreno x y (h:t) texturas = terreno : resto
    where terreno = desenhaTerreno x y h texturas
          resto   = desenhaLinhaTerreno (x+l) y t texturas
desenhaLinhaTerreno _ _ _ _ = []
@

-}          

desenhaLinhaTerreno :: Float -> Float -> [StringTerreno] -> TexturaTerreno -> [Picture]
desenhaLinhaTerreno x y (h:t) texturas = terreno : resto
    where terreno = desenhaTerreno x y h texturas
          resto   = desenhaLinhaTerreno (x+l) y t texturas
desenhaLinhaTerreno _ _ _ _ = []

{- |
Função que desenha as várias linhas de terrenos de um Mapa.

@
desenhaMapaTerreno :: Float -> Float -> [[StringTerreno]] -> TexturaTerreno -> [Picture]
desenhaMapaTerreno x y (h:t) textures = linhaTerrenos ++ resto
    where linhaTerrenos = desenhaLinhaTerreno x y h textures
          resto         = desenhaMapaTerreno x (y-l) t textures
desenhaMapaTerreno _ _ _ _ = []   
@

-}      

desenhaMapaTerreno :: Float -> Float -> [[StringTerreno]] -> TexturaTerreno -> [Picture]
desenhaMapaTerreno x y (h:t) textures = linhaTerrenos ++ resto
    where linhaTerrenos = desenhaLinhaTerreno x y h textures
          resto         = desenhaMapaTerreno x (y-l) t textures
desenhaMapaTerreno _ _ _ _ = []   

{- |
Função que desenha a imagem escolhida para cada obstáculo.

@
desenhaObstaculo :: Float -> Float -> Obstaculo -> TexturaObstaculo -> Picture
desenhaObstaculo x y obstaculo texturasObstaculos = Translate realX realY textura
    where tuple = (fromJust . lookup obstaculo) texturasObstaculos
          textura = fst tuple
          realX = ((+x) . fst . snd) tuple
          realY = ((+y) . snd . snd) tuple
@

-}   

desenhaObstaculo :: Float -> Float -> Obstaculo -> TexturaObstaculo -> Picture
desenhaObstaculo x y obstaculo texturasObstaculos = Translate realX realY textura
    where tuple = (fromJust . lookup obstaculo) texturasObstaculos
          textura = fst tuple
          realX = ((+x) . fst . snd) tuple
          realY = ((+y) . snd . snd) tuple

{- |
Função que desenha a linha de cada obstáculo.

@
desenhaLinhaObstaculo :: Float -> Float -> [Obstaculo] -> TexturaObstaculo -> [Picture]
desenhaLinhaObstaculo x y (h:t) texturas = obstaculo : resto
    where obstaculo = desenhaObstaculo x y h texturas
          resto     = desenhaLinhaObstaculo (x+l) y t texturas
desenhaLinhaObstaculo _ _ _ _            = []
@

-}   

desenhaLinhaObstaculo :: Float -> Float -> [Obstaculo] -> TexturaObstaculo -> [Picture]
desenhaLinhaObstaculo x y (h:t) texturas = obstaculo : resto
    where obstaculo = desenhaObstaculo x y h texturas
          resto     = desenhaLinhaObstaculo (x+l) y t texturas
desenhaLinhaObstaculo _ _ _ _            = []

{- |
Função que desenha as várias linhas de obstáculos de um Mapa.

@
desenhaLinhaObstaculo :: Float -> Float -> [Obstaculo] -> TexturaObstaculo -> [Picture]
desenhaLinhaObstaculo x y (h:t) texturas = obstaculo : resto
    where obstaculo = desenhaObstaculo x y h texturas
          resto     = desenhaLinhaObstaculo (x+l) y t texturas
desenhaLinhaObstaculo _ _ _ _            = []
@

-}   

desenhaMapaObstaculo :: Float -> Float -> [[Obstaculo]] -> TexturaObstaculo -> [Picture]
desenhaMapaObstaculo x y (h:t) textures = linhaObstaculos ++ resto
    where linhaObstaculos = desenhaLinhaObstaculo x y h textures
          resto           = desenhaMapaObstaculo x (y-l) t textures
desenhaMapaObstaculo _ _ _ _ = []

{- |
Função que desenha os vários estados do jogo (como por exemplo: o menú inicial quando escolhemos o botão Jogar, ou quando escolhemos o botão Skins, ... / cada atualização do nosso jogo, seja pelo movimento do mapa ou do jogador / etc.)

@
desenhaEstadoGloss :: EstadoGloss -> Picture
desenhaEstadoGloss (Controlador Jogar, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
    | modeloJogador == "1" = Pictures ([background] ++ [Translate (0) (50) botaoSelect, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador1] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "2" = Pictures ([background] ++ [Translate (0) (50) botaoSelect, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 3 3     jogador2] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "3" = Pictures ([background] ++ [Translate (0) (50) botaoSelect, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador3] ++ desenhoMaxScore ++ desenhoScore) 
    | modeloJogador == "4" = Pictures ([background] ++ [Translate (0) (50) botaoSelect, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador4] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "5" = Pictures ([background] ++ [Translate (0) (50) botaoSelect, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador5] ++ desenhoMaxScore ++ desenhoScore)
        where background    = (fromJust . lookup "background"     ) texturaExtra
              botao         = (fromJust . lookup "botao"          ) texturaExtra
              botaoSelect   = (fromJust . lookup "botaoselecionar") texturaExtra
              botaoJogar    = (fromJust . lookup "bjogar"         ) texturaExtra
              botaoSair     = (fromJust . lookup "bsair"          ) texturaExtra
              botaoAjuda    = (fromJust . lookup "bajuda"         ) texturaExtra
              botaoSkins    = (fromJust . lookup "bskins"         ) texturaExtra
              botaoScore    = (fromJust . lookup "bscore"         ) texturaExtra
              botaoTopScore = (fromJust . lookup "btopscore"      ) texturaExtra  
              crossyroad    = (fromJust . lookup "crossyroad"     ) texturaExtra
              jogador1      = Pictures [(fromJust . lookup "jogador1" ) skins] 
              jogador2      = Pictures [(fromJust . lookup "jogador2" ) skins]
              jogador3      = Pictures [(fromJust . lookup "jogador3" ) skins]
              jogador4      = Pictures [(fromJust . lookup "jogador4" ) skins]
              jogador5      = Pictures [(fromJust . lookup "jogador5" ) skins]
              desenhoMaxScore | maxscore < 10   = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ (show maxscore))) texturaExtra]
                              | maxscore < 100  = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ (tail (show maxscore)))) texturaExtra]
                              | maxscore < 1000 = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show maxscore)))])) texturaExtra] ++ [Translate (-540) (437) $ (fromJust . lookup ("n" ++ [(last (show maxscore))])) texturaExtra]
                              | otherwise       = [Rotate (90) $ Translate (-445) (-645) $ (fromJust . lookup "n8") texturaExtra]
              desenhoScore | score < 10   = [Translate (810) (437) $ (fromJust . lookup ("n" ++ (show score))) texturaExtra]
                           | score < 100  = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ (tail (show score)))) texturaExtra]
                           | score < 1000 = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show score)))])) texturaExtra] ++ [Translate (900) (437) $ (fromJust . lookup ("n" ++ [(last (show score))])) texturaExtra]
                           | otherwise    = [Rotate (90) $ Translate (-445) (795) $ (fromJust . lookup "n8") texturaExtra]
desenhaEstadoGloss (Controlador EditarJogador, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
    | modeloJogador == "1" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botaoSelect, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador1] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "2" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botaoSelect, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 3 3     jogador2] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "3" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botaoSelect, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador3] ++ desenhoMaxScore ++ desenhoScore) 
    | modeloJogador == "4" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botaoSelect, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador4] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "5" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botaoSelect, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador5] ++ desenhoMaxScore ++ desenhoScore)
        where background    = (fromJust . lookup "background"     ) texturaExtra
              botao         = (fromJust . lookup "botao"          ) texturaExtra
              botaoSelect   = (fromJust . lookup "botaoselecionar") texturaExtra
              botaoJogar    = (fromJust . lookup "bjogar"         ) texturaExtra
              botaoSair     = (fromJust . lookup "bsair"          ) texturaExtra
              botaoAjuda    = (fromJust . lookup "bajuda"         ) texturaExtra
              botaoSkins    = (fromJust . lookup "bskins"         ) texturaExtra
              botaoScore    = (fromJust . lookup "bscore"         ) texturaExtra
              botaoTopScore = (fromJust . lookup "btopscore"      ) texturaExtra  
              crossyroad    = (fromJust . lookup "crossyroad"     ) texturaExtra
              jogador1      = Pictures [(fromJust . lookup "jogador1" ) skins] 
              jogador2      = Pictures [(fromJust . lookup "jogador2" ) skins]
              jogador3      = Pictures [(fromJust . lookup "jogador3" ) skins]
              jogador4      = Pictures [(fromJust . lookup "jogador4" ) skins]
              jogador5      = Pictures [(fromJust . lookup "jogador5" ) skins]
              desenhoMaxScore | maxscore < 10   = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ (show maxscore))) texturaExtra]
                              | maxscore < 100  = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ (tail (show maxscore)))) texturaExtra]
                              | maxscore < 1000 = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show maxscore)))])) texturaExtra] ++ [Translate (-540) (437) $ (fromJust . lookup ("n" ++ [(last (show maxscore))])) texturaExtra]
                              | otherwise       = [Rotate (90) $ Translate (-445) (-645) $ (fromJust . lookup "n8") texturaExtra]
              desenhoScore | score < 10   = [Translate (810) (437) $ (fromJust . lookup ("n" ++ (show score))) texturaExtra]
                           | score < 100  = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ (tail (show score)))) texturaExtra]
                           | score < 1000 = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show score)))])) texturaExtra] ++ [Translate (900) (437) $ (fromJust . lookup ("n" ++ [(last (show score))])) texturaExtra]
                           | otherwise    = [Rotate (90) $ Translate (-445) (795) $ (fromJust . lookup "n8") texturaExtra]
desenhaEstadoGloss (Controlador Ajuda, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
    | modeloJogador == "1" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botaoSelect, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador1] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "2" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botaoSelect, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 3   3   jogador2] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "3" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botaoSelect, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador3] ++ desenhoMaxScore ++ desenhoScore) 
    | modeloJogador == "4" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botaoSelect, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador4] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "5" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botaoSelect, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador5] ++ desenhoMaxScore ++ desenhoScore)
        where background    = (fromJust . lookup "background"     ) texturaExtra
              botao         = (fromJust . lookup "botao"          ) texturaExtra
              botaoSelect   = (fromJust . lookup "botaoselecionar") texturaExtra
              botaoJogar    = (fromJust . lookup "bjogar"         ) texturaExtra
              botaoSair     = (fromJust . lookup "bsair"          ) texturaExtra
              botaoAjuda    = (fromJust . lookup "bajuda"         ) texturaExtra
              botaoSkins    = (fromJust . lookup "bskins"         ) texturaExtra
              botaoScore    = (fromJust . lookup "bscore"         ) texturaExtra
              botaoTopScore = (fromJust . lookup "btopscore"      ) texturaExtra  
              crossyroad    = (fromJust . lookup "crossyroad"     ) texturaExtra
              jogador1      = Pictures [(fromJust . lookup "jogador1" ) skins] 
              jogador2      = Pictures [(fromJust . lookup "jogador2" ) skins]
              jogador3      = Pictures [(fromJust . lookup "jogador3" ) skins]
              jogador4      = Pictures [(fromJust . lookup "jogador4" ) skins]
              jogador5      = Pictures [(fromJust . lookup "jogador5" ) skins]
              desenhoMaxScore | maxscore < 10   = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ (show maxscore))) texturaExtra]
                              | maxscore < 100  = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ (tail (show maxscore)))) texturaExtra]
                              | maxscore < 1000 = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show maxscore)))])) texturaExtra] ++ [Translate (-540) (437) $ (fromJust . lookup ("n" ++ [(last (show maxscore))])) texturaExtra]
                              | otherwise       = [Rotate (90) $ Translate (-445) (-645) $ (fromJust . lookup "n8") texturaExtra]
              desenhoScore | score < 10   = [Translate (810) (437) $ (fromJust . lookup ("n" ++ (show score))) texturaExtra]
                           | score < 100  = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ (tail (show score)))) texturaExtra]
                           | score < 1000 = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show score)))])) texturaExtra] ++ [Translate (900) (437) $ (fromJust . lookup ("n" ++ [(last (show score))])) texturaExtra]
                           | otherwise    = [Rotate (90) $ Translate (-445) (795) $ (fromJust . lookup "n8") texturaExtra]
desenhaEstadoGloss (Controlador Sair, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
    | modeloJogador == "1" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botaoSelect] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador1] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "2" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botaoSelect] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 3   3   jogador2] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "3" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botaoSelect] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador3] ++ desenhoMaxScore ++ desenhoScore) 
    | modeloJogador == "4" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botaoSelect] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador4] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "5" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botaoSelect] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador5] ++ desenhoMaxScore ++ desenhoScore)
        where background    = (fromJust . lookup "background"     ) texturaExtra
              botao         = (fromJust . lookup "botao"          ) texturaExtra
              botaoSelect   = (fromJust . lookup "botaoselecionar") texturaExtra
              botaoJogar    = (fromJust . lookup "bjogar"         ) texturaExtra
              botaoSair     = (fromJust . lookup "bsair"          ) texturaExtra
              botaoAjuda    = (fromJust . lookup "bajuda"         ) texturaExtra
              botaoSkins    = (fromJust . lookup "bskins"         ) texturaExtra
              botaoScore    = (fromJust . lookup "bscore"         ) texturaExtra
              botaoTopScore = (fromJust . lookup "btopscore"      ) texturaExtra  
              crossyroad    = (fromJust . lookup "crossyroad"     ) texturaExtra
              jogador1      = Pictures [(fromJust . lookup "jogador1" ) skins] 
              jogador2      = Pictures [(fromJust . lookup "jogador2" ) skins]
              jogador3      = Pictures [(fromJust . lookup "jogador3" ) skins]
              jogador4      = Pictures [(fromJust . lookup "jogador4" ) skins]
              jogador5      = Pictures [(fromJust . lookup "jogador5" ) skins]
              desenhoMaxScore | maxscore < 10   = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ (show maxscore))) texturaExtra]
                              | maxscore < 100  = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ (tail (show maxscore)))) texturaExtra]
                              | maxscore < 1000 = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show maxscore)))])) texturaExtra] ++ [Translate (-540) (437) $ (fromJust . lookup ("n" ++ [(last (show maxscore))])) texturaExtra]
                              | otherwise       = [Rotate (90) $ Translate (-445) (-645) $ (fromJust . lookup "n8") texturaExtra]
              desenhoScore | score < 10   = [Translate (810) (437) $ (fromJust . lookup ("n" ++ (show score))) texturaExtra]
                           | score < 100  = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ (tail (show score)))) texturaExtra]
                           | score < 1000 = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show score)))])) texturaExtra] ++ [Translate (900) (437) $ (fromJust . lookup ("n" ++ [(last (show score))])) texturaExtra]
                           | otherwise    = [Rotate (90) $ Translate (-445) (795) $ (fromJust . lookup "n8") texturaExtra]                   
desenhaEstadoGloss (InicioJogo, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures ([background] ++ desenhoDoMapaTerrenos ++ desenhodoMapaObstaculos ++ [desenhoDoJogador] ++ [desenhoPausa] ++ desenhoScore)
    where desenhoDoMapaTerrenos   = desenhaMapaTerreno comprimento altura (map stringTerrenos (onlyTerrenos jogo)) texturaTerreno
          desenhodoMapaObstaculos = desenhaMapaObstaculo comprimento altura (onlyObstaculos mapa) texturaObstaculo
          desenhoDoJogador        = desenhaJogador jogador modeloJogador skins
          desenhoPausa | not controlo && (time > 0) =  Pictures ([Translate (0) (-80) pausa] ++ [Translate (0) (70) $ scale (0.25) (0.25) $ ((fromJust . lookup "crossyroad") texturaExtra)])
                       | not controlo               = Pictures [Translate (0) (70) $ scale (0.25) (0.25) $ ((fromJust . lookup "crossyroad") texturaExtra)]
                       | otherwise                  = Blank
          background = (fromJust . lookup "background") texturaExtra
          pausa      = (fromJust . lookup "pausa"     ) texturaExtra
          desenhoScore | score < 10   = [Translate (405) (337) $ (fromJust . lookup ("n" ++ (show score))) texturaExtra]
                       | score < 100  = [Translate (405) (337) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (450) (337) $ (fromJust . lookup ("n" ++ (tail (show score)))) texturaExtra]
                       | score < 1000 = [Translate (405) (337) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (450) (337) $ (fromJust . lookup ("n" ++ [(head (tail (show score)))])) texturaExtra] ++ [Translate (495) (337) $ (fromJust . lookup ("n" ++ [(last (show score))])) texturaExtra]
                       | otherwise    = [Rotate (90) $ Translate (-345) (445) $ (fromJust . lookup "n8") texturaExtra]
desenhaEstadoGloss (MenuAjuda, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures $ [background] ++ [imagemAjuda]
    where imagemAjuda = (fromJust . lookup "ajuda"     ) texturaExtra
          background  = (fromJust . lookup "background") texturaExtra
desenhaEstadoGloss (EditarSkins 1, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures [Translate (-15) 0 background, Translate (100) (-300) $ Pictures [Translate (-700) (235) $ scale 4 4 jogador1, Translate (-400) (250) $ scale 4 4 jogador2, Translate (-100) (250) $ scale 4 4 jogador3, Translate (200) (250) $ scale 3.8 3.8 jogador4, Translate (500) (240) $ scale 3.8 3.8 jogador5, Translate (735) (725) $ scale 0.1 0.1 crossyroad, Translate (-705) (235) $ selecionador, Translate (-80) (550) $ scale 5 5 botaoSkins]]
    where background   = (fromJust . lookup "background") texturaExtra
          crossyroad   = (fromJust . lookup "crossyroad") texturaExtra
          jogador1     = Pictures [(fromJust . lookup "jogador1" ) skins] 
          jogador2     = Pictures [(fromJust . lookup "jogador2" ) skins]
          jogador3     = Pictures [(fromJust . lookup "jogador3" ) skins]
          jogador4     = Pictures [(fromJust . lookup "jogador4" ) skins]
          jogador5     = Pictures [(fromJust . lookup "jogador5" ) skins]
          selecionador = ((fromJust . lookup "selecionador") texturaExtra)
          botaoSkins   = (fromJust . lookup "bskins") texturaExtra
desenhaEstadoGloss (EditarSkins 2, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures [Translate (-15) 0 background, Translate (100) (-300) $ Pictures [Translate (-700) (235) $ scale 4 4 jogador1, Translate (-400) (250) $ scale 4 4 jogador2, Translate (-100) (250) $ scale 4 4 jogador3, Translate (200) (250) $ scale 3.8 3.8 jogador4, Translate (500) (240) $ scale 3.8 3.8 jogador5, Translate (735) (725) $ scale 0.1 0.1 crossyroad, Translate (-410) (235) $ selecionador, Translate (-80) (550) $ scale 5 5 botaoSkins]]
    where background   = (fromJust . lookup "background") texturaExtra
          crossyroad   = (fromJust . lookup "crossyroad") texturaExtra
          jogador1     = Pictures [(fromJust . lookup "jogador1" ) skins] 
          jogador2     = Pictures [(fromJust . lookup "jogador2" ) skins]
          jogador3     = Pictures [(fromJust . lookup "jogador3" ) skins]
          jogador4     = Pictures [(fromJust . lookup "jogador4" ) skins]
          jogador5     = Pictures [(fromJust . lookup "jogador5" ) skins]
          selecionador = ((fromJust . lookup "selecionador") texturaExtra)
          botaoSkins   = (fromJust . lookup "bskins") texturaExtra
desenhaEstadoGloss (EditarSkins 3, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures [Translate (-15) 0 background, Translate (100) (-300) $ Pictures [Translate (-700) (235) $ scale 4 4 jogador1, Translate (-400) (250) $ scale 4 4 jogador2, Translate (-100) (250) $ scale 4 4 jogador3, Translate (200) (250) $ scale 3.8 3.8 jogador4, Translate (500) (240) $ scale 3.8 3.8 jogador5, Translate (735) (725) $ scale 0.1 0.1 crossyroad, Translate (-105) (235) $ selecionador, Translate (-80) (550) $ scale 5 5 botaoSkins]]
    where background   = (fromJust . lookup "background") texturaExtra
          crossyroad   = (fromJust . lookup "crossyroad") texturaExtra
          jogador1     = Pictures [(fromJust . lookup "jogador1" ) skins] 
          jogador2     = Pictures [(fromJust . lookup "jogador2" ) skins]
          jogador3     = Pictures [(fromJust . lookup "jogador3" ) skins]
          jogador4     = Pictures [(fromJust . lookup "jogador4" ) skins]
          jogador5     = Pictures [(fromJust . lookup "jogador5" ) skins]
          selecionador = ((fromJust . lookup "selecionador") texturaExtra)
          botaoSkins   = (fromJust . lookup "bskins") texturaExtra
desenhaEstadoGloss (EditarSkins 4, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures [Translate (-15) 0 background, Translate (100) (-300) $ Pictures [Translate (-700) (235) $ scale 4 4 jogador1, Translate (-400) (250) $ scale 4 4 jogador2, Translate (-100) (250) $ scale 4 4 jogador3, Translate (200) (250) $ scale 3.8 3.8 jogador4, Translate (500) (240) $ scale 3.8 3.8 jogador5, Translate (735) (725) $ scale 0.1 0.1 crossyroad, Translate (210) (235) $ selecionador, Translate (-80) (550) $ scale 5 5 botaoSkins]]
    where background   = (fromJust . lookup "background") texturaExtra
          crossyroad   = (fromJust . lookup "crossyroad") texturaExtra
          jogador1     = Pictures [(fromJust . lookup "jogador1" ) skins] 
          jogador2     = Pictures [(fromJust . lookup "jogador2" ) skins]
          jogador3     = Pictures [(fromJust . lookup "jogador3" ) skins]
          jogador4     = Pictures [(fromJust . lookup "jogador4" ) skins]
          jogador5     = Pictures [(fromJust . lookup "jogador5" ) skins]
          selecionador = ((fromJust . lookup "selecionador") texturaExtra)
          botaoSkins   = (fromJust . lookup "bskins") texturaExtra
desenhaEstadoGloss (EditarSkins 5, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures [Translate (-15) 0 background, Translate (100) (-300) $ Pictures [Translate (-700) (235) $ scale 4 4 jogador1, Translate (-400) (250) $ scale 4 4 jogador2, Translate (-100) (250) $ scale 4 4 jogador3, Translate (200) (250) $ scale 3.8 3.8 jogador4, Translate (500) (240) $ scale 3.8 3.8 jogador5, Translate (735) (725) $ scale 0.1 0.1 crossyroad, Translate (505) (235) $ selecionador, Translate (-80) (550) $ scale 5 5 botaoSkins]]
    where background   = (fromJust . lookup "background") texturaExtra
          crossyroad   = (fromJust . lookup "crossyroad") texturaExtra
          jogador1     = Pictures [(fromJust . lookup "jogador1" ) skins] 
          jogador2     = Pictures [(fromJust . lookup "jogador2" ) skins]
          jogador3     = Pictures [(fromJust . lookup "jogador3" ) skins]
          jogador4     = Pictures [(fromJust . lookup "jogador4" ) skins]
          jogador5     = Pictures [(fromJust . lookup "jogador5" ) skins]
          selecionador = ((fromJust . lookup "selecionador") texturaExtra)
          botaoSkins   = (fromJust . lookup "bskins") texturaExtra
desenhaEstadoGloss _ = Blank 
@

-}   

desenhaEstadoGloss :: EstadoGloss -> Picture
desenhaEstadoGloss (Controlador Jogar, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
    | modeloJogador == "1" = Pictures ([background] ++ [Translate (0) (50) botaoSelect, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador1] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "2" = Pictures ([background] ++ [Translate (0) (50) botaoSelect, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 3 3     jogador2] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "3" = Pictures ([background] ++ [Translate (0) (50) botaoSelect, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador3] ++ desenhoMaxScore ++ desenhoScore) 
    | modeloJogador == "4" = Pictures ([background] ++ [Translate (0) (50) botaoSelect, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador4] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "5" = Pictures ([background] ++ [Translate (0) (50) botaoSelect, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador5] ++ desenhoMaxScore ++ desenhoScore)
        where background    = (fromJust . lookup "background"     ) texturaExtra
              botao         = (fromJust . lookup "botao"          ) texturaExtra
              botaoSelect   = (fromJust . lookup "botaoselecionar") texturaExtra
              botaoJogar    = (fromJust . lookup "bjogar"         ) texturaExtra
              botaoSair     = (fromJust . lookup "bsair"          ) texturaExtra
              botaoAjuda    = (fromJust . lookup "bajuda"         ) texturaExtra
              botaoSkins    = (fromJust . lookup "bskins"         ) texturaExtra
              botaoScore    = (fromJust . lookup "bscore"         ) texturaExtra
              botaoTopScore = (fromJust . lookup "btopscore"      ) texturaExtra  
              crossyroad    = (fromJust . lookup "crossyroad"     ) texturaExtra
              jogador1      = Pictures [(fromJust . lookup "jogador1" ) skins] 
              jogador2      = Pictures [(fromJust . lookup "jogador2" ) skins]
              jogador3      = Pictures [(fromJust . lookup "jogador3" ) skins]
              jogador4      = Pictures [(fromJust . lookup "jogador4" ) skins]
              jogador5      = Pictures [(fromJust . lookup "jogador5" ) skins]
              desenhoMaxScore | maxscore < 10   = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ (show maxscore))) texturaExtra]
                              | maxscore < 100  = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ (tail (show maxscore)))) texturaExtra]
                              | maxscore < 1000 = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show maxscore)))])) texturaExtra] ++ [Translate (-540) (437) $ (fromJust . lookup ("n" ++ [(last (show maxscore))])) texturaExtra]
                              | otherwise       = [Rotate (90) $ Translate (-445) (-645) $ (fromJust . lookup "n8") texturaExtra]
              desenhoScore | score < 10   = [Translate (810) (437) $ (fromJust . lookup ("n" ++ (show score))) texturaExtra]
                           | score < 100  = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ (tail (show score)))) texturaExtra]
                           | score < 1000 = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show score)))])) texturaExtra] ++ [Translate (900) (437) $ (fromJust . lookup ("n" ++ [(last (show score))])) texturaExtra]
                           | otherwise    = [Rotate (90) $ Translate (-445) (795) $ (fromJust . lookup "n8") texturaExtra]

desenhaEstadoGloss (Controlador EditarJogador, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
    | modeloJogador == "1" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botaoSelect, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador1] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "2" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botaoSelect, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 3 3     jogador2] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "3" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botaoSelect, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador3] ++ desenhoMaxScore ++ desenhoScore) 
    | modeloJogador == "4" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botaoSelect, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador4] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "5" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botaoSelect, Translate (0) (-150) botao, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador5] ++ desenhoMaxScore ++ desenhoScore)
        where background    = (fromJust . lookup "background"     ) texturaExtra
              botao         = (fromJust . lookup "botao"          ) texturaExtra
              botaoSelect   = (fromJust . lookup "botaoselecionar") texturaExtra
              botaoJogar    = (fromJust . lookup "bjogar"         ) texturaExtra
              botaoSair     = (fromJust . lookup "bsair"          ) texturaExtra
              botaoAjuda    = (fromJust . lookup "bajuda"         ) texturaExtra
              botaoSkins    = (fromJust . lookup "bskins"         ) texturaExtra
              botaoScore    = (fromJust . lookup "bscore"         ) texturaExtra
              botaoTopScore = (fromJust . lookup "btopscore"      ) texturaExtra  
              crossyroad    = (fromJust . lookup "crossyroad"     ) texturaExtra
              jogador1      = Pictures [(fromJust . lookup "jogador1" ) skins] 
              jogador2      = Pictures [(fromJust . lookup "jogador2" ) skins]
              jogador3      = Pictures [(fromJust . lookup "jogador3" ) skins]
              jogador4      = Pictures [(fromJust . lookup "jogador4" ) skins]
              jogador5      = Pictures [(fromJust . lookup "jogador5" ) skins]
              desenhoMaxScore | maxscore < 10   = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ (show maxscore))) texturaExtra]
                              | maxscore < 100  = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ (tail (show maxscore)))) texturaExtra]
                              | maxscore < 1000 = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show maxscore)))])) texturaExtra] ++ [Translate (-540) (437) $ (fromJust . lookup ("n" ++ [(last (show maxscore))])) texturaExtra]
                              | otherwise       = [Rotate (90) $ Translate (-445) (-645) $ (fromJust . lookup "n8") texturaExtra]
              desenhoScore | score < 10   = [Translate (810) (437) $ (fromJust . lookup ("n" ++ (show score))) texturaExtra]
                           | score < 100  = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ (tail (show score)))) texturaExtra]
                           | score < 1000 = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show score)))])) texturaExtra] ++ [Translate (900) (437) $ (fromJust . lookup ("n" ++ [(last (show score))])) texturaExtra]
                           | otherwise    = [Rotate (90) $ Translate (-445) (795) $ (fromJust . lookup "n8") texturaExtra]

desenhaEstadoGloss (Controlador Ajuda, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
    | modeloJogador == "1" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botaoSelect, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador1] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "2" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botaoSelect, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 3   3   jogador2] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "3" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botaoSelect, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador3] ++ desenhoMaxScore ++ desenhoScore) 
    | modeloJogador == "4" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botaoSelect, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador4] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "5" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botaoSelect, Translate (0) (-250) botao] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador5] ++ desenhoMaxScore ++ desenhoScore)
        where background    = (fromJust . lookup "background"     ) texturaExtra
              botao         = (fromJust . lookup "botao"          ) texturaExtra
              botaoSelect   = (fromJust . lookup "botaoselecionar") texturaExtra
              botaoJogar    = (fromJust . lookup "bjogar"         ) texturaExtra
              botaoSair     = (fromJust . lookup "bsair"          ) texturaExtra
              botaoAjuda    = (fromJust . lookup "bajuda"         ) texturaExtra
              botaoSkins    = (fromJust . lookup "bskins"         ) texturaExtra
              botaoScore    = (fromJust . lookup "bscore"         ) texturaExtra
              botaoTopScore = (fromJust . lookup "btopscore"      ) texturaExtra  
              crossyroad    = (fromJust . lookup "crossyroad"     ) texturaExtra
              jogador1      = Pictures [(fromJust . lookup "jogador1" ) skins] 
              jogador2      = Pictures [(fromJust . lookup "jogador2" ) skins]
              jogador3      = Pictures [(fromJust . lookup "jogador3" ) skins]
              jogador4      = Pictures [(fromJust . lookup "jogador4" ) skins]
              jogador5      = Pictures [(fromJust . lookup "jogador5" ) skins]
              desenhoMaxScore | maxscore < 10   = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ (show maxscore))) texturaExtra]
                              | maxscore < 100  = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ (tail (show maxscore)))) texturaExtra]
                              | maxscore < 1000 = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show maxscore)))])) texturaExtra] ++ [Translate (-540) (437) $ (fromJust . lookup ("n" ++ [(last (show maxscore))])) texturaExtra]
                              | otherwise       = [Rotate (90) $ Translate (-445) (-645) $ (fromJust . lookup "n8") texturaExtra]
              desenhoScore | score < 10   = [Translate (810) (437) $ (fromJust . lookup ("n" ++ (show score))) texturaExtra]
                           | score < 100  = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ (tail (show score)))) texturaExtra]
                           | score < 1000 = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show score)))])) texturaExtra] ++ [Translate (900) (437) $ (fromJust . lookup ("n" ++ [(last (show score))])) texturaExtra]
                           | otherwise    = [Rotate (90) $ Translate (-445) (795) $ (fromJust . lookup "n8") texturaExtra]

desenhaEstadoGloss (Controlador Sair, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot)
    | modeloJogador == "1" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botaoSelect] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador1] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "2" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botaoSelect] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 3   3   jogador2] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "3" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botaoSelect] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador3] ++ desenhoMaxScore ++ desenhoScore) 
    | modeloJogador == "4" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botaoSelect] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador4] ++ desenhoMaxScore ++ desenhoScore)
    | modeloJogador == "5" = Pictures ([background] ++ [Translate (0) (50) botao, Translate (0) (-50) botao, Translate (0) (-150) botao, Translate (0) (-250) botaoSelect] ++ [Translate (0) (45) botaoJogar, Translate (0) (-55) botaoSkins, Translate (0) (-158) botaoAjuda, Translate (0) (-259) botaoSair, Translate (690) (440) botaoScore, Translate (-800) (440) botaoTopScore, Translate (0) (300) $ scale 0.4 0.4 crossyroad, Translate (-820) (-370) $ scale 2.5 2.5 jogador5] ++ desenhoMaxScore ++ desenhoScore)
        where background    = (fromJust . lookup "background"     ) texturaExtra
              botao         = (fromJust . lookup "botao"          ) texturaExtra
              botaoSelect   = (fromJust . lookup "botaoselecionar") texturaExtra
              botaoJogar    = (fromJust . lookup "bjogar"         ) texturaExtra
              botaoSair     = (fromJust . lookup "bsair"          ) texturaExtra
              botaoAjuda    = (fromJust . lookup "bajuda"         ) texturaExtra
              botaoSkins    = (fromJust . lookup "bskins"         ) texturaExtra
              botaoScore    = (fromJust . lookup "bscore"         ) texturaExtra
              botaoTopScore = (fromJust . lookup "btopscore"      ) texturaExtra  
              crossyroad    = (fromJust . lookup "crossyroad"     ) texturaExtra
              jogador1      = Pictures [(fromJust . lookup "jogador1" ) skins] 
              jogador2      = Pictures [(fromJust . lookup "jogador2" ) skins]
              jogador3      = Pictures [(fromJust . lookup "jogador3" ) skins]
              jogador4      = Pictures [(fromJust . lookup "jogador4" ) skins]
              jogador5      = Pictures [(fromJust . lookup "jogador5" ) skins]
              desenhoMaxScore | maxscore < 10   = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ (show maxscore))) texturaExtra]
                              | maxscore < 100  = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ (tail (show maxscore)))) texturaExtra]
                              | maxscore < 1000 = [Translate (-630) (437) $ (fromJust . lookup ("n" ++ [(head (show maxscore))])) texturaExtra] ++ [Translate (-585) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show maxscore)))])) texturaExtra] ++ [Translate (-540) (437) $ (fromJust . lookup ("n" ++ [(last (show maxscore))])) texturaExtra]
                              | otherwise       = [Rotate (90) $ Translate (-445) (-645) $ (fromJust . lookup "n8") texturaExtra]
              desenhoScore | score < 10   = [Translate (810) (437) $ (fromJust . lookup ("n" ++ (show score))) texturaExtra]
                           | score < 100  = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ (tail (show score)))) texturaExtra]
                           | score < 1000 = [Translate (810) (437) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (855) (437) $ (fromJust . lookup ("n" ++ [(head (tail (show score)))])) texturaExtra] ++ [Translate (900) (437) $ (fromJust . lookup ("n" ++ [(last (show score))])) texturaExtra]
                           | otherwise    = [Rotate (90) $ Translate (-445) (795) $ (fromJust . lookup "n8") texturaExtra]
                           
desenhaEstadoGloss (InicioJogo, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures ([background] ++ desenhoDoMapaTerrenos ++ desenhodoMapaObstaculos ++ [desenhoDoJogador] ++ [desenhoPausa] ++ desenhoScore)
    where desenhoDoMapaTerrenos   = desenhaMapaTerreno comprimento altura (map stringTerrenos (onlyTerrenos jogo)) texturaTerreno
          desenhodoMapaObstaculos = desenhaMapaObstaculo comprimento altura (onlyObstaculos mapa) texturaObstaculo
          desenhoDoJogador        = desenhaJogador jogador modeloJogador skins
          desenhoPausa | not controlo && (time > 0) =  Pictures ([Translate (0) (-80) pausa] ++ [Translate (0) (70) $ scale (0.25) (0.25) $ ((fromJust . lookup "crossyroad") texturaExtra)])
                       | not controlo               = Pictures [Translate (0) (70) $ scale (0.25) (0.25) $ ((fromJust . lookup "crossyroad") texturaExtra)]
                       | otherwise                  = Blank
          background = (fromJust . lookup "background") texturaExtra
          pausa      = (fromJust . lookup "pausa"     ) texturaExtra
          desenhoScore | score < 10   = [Translate (405) (337) $ (fromJust . lookup ("n" ++ (show score))) texturaExtra]
                       | score < 100  = [Translate (405) (337) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (450) (337) $ (fromJust . lookup ("n" ++ (tail (show score)))) texturaExtra]
                       | score < 1000 = [Translate (405) (337) $ (fromJust . lookup ("n" ++ [(head (show score))])) texturaExtra] ++ [Translate (450) (337) $ (fromJust . lookup ("n" ++ [(head (tail (show score)))])) texturaExtra] ++ [Translate (495) (337) $ (fromJust . lookup ("n" ++ [(last (show score))])) texturaExtra]
                       | otherwise    = [Rotate (90) $ Translate (-345) (445) $ (fromJust . lookup "n8") texturaExtra]

desenhaEstadoGloss (MenuAjuda, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures $ [background] ++ [imagemAjuda]
    where imagemAjuda = (fromJust . lookup "ajuda"     ) texturaExtra
          background  = (fromJust . lookup "background") texturaExtra

desenhaEstadoGloss (EditarSkins 1, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures [Translate (-15) 0 background, Translate (100) (-300) $ Pictures [Translate (-700) (235) $ scale 4 4 jogador1, Translate (-400) (250) $ scale 4 4 jogador2, Translate (-100) (250) $ scale 4 4 jogador3, Translate (200) (250) $ scale 3.8 3.8 jogador4, Translate (500) (240) $ scale 3.8 3.8 jogador5, Translate (735) (725) $ scale 0.1 0.1 crossyroad, Translate (-705) (235) $ selecionador, Translate (-80) (550) $ scale 5 5 botaoSkins]]
    where background   = (fromJust . lookup "background") texturaExtra
          crossyroad   = (fromJust . lookup "crossyroad") texturaExtra
          jogador1     = Pictures [(fromJust . lookup "jogador1" ) skins] 
          jogador2     = Pictures [(fromJust . lookup "jogador2" ) skins]
          jogador3     = Pictures [(fromJust . lookup "jogador3" ) skins]
          jogador4     = Pictures [(fromJust . lookup "jogador4" ) skins]
          jogador5     = Pictures [(fromJust . lookup "jogador5" ) skins]
          selecionador = ((fromJust . lookup "selecionador") texturaExtra)
          botaoSkins   = (fromJust . lookup "bskins") texturaExtra
desenhaEstadoGloss (EditarSkins 2, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures [Translate (-15) 0 background, Translate (100) (-300) $ Pictures [Translate (-700) (235) $ scale 4 4 jogador1, Translate (-400) (250) $ scale 4 4 jogador2, Translate (-100) (250) $ scale 4 4 jogador3, Translate (200) (250) $ scale 3.8 3.8 jogador4, Translate (500) (240) $ scale 3.8 3.8 jogador5, Translate (735) (725) $ scale 0.1 0.1 crossyroad, Translate (-410) (235) $ selecionador, Translate (-80) (550) $ scale 5 5 botaoSkins]]
    where background   = (fromJust . lookup "background") texturaExtra
          crossyroad   = (fromJust . lookup "crossyroad") texturaExtra
          jogador1     = Pictures [(fromJust . lookup "jogador1" ) skins] 
          jogador2     = Pictures [(fromJust . lookup "jogador2" ) skins]
          jogador3     = Pictures [(fromJust . lookup "jogador3" ) skins]
          jogador4     = Pictures [(fromJust . lookup "jogador4" ) skins]
          jogador5     = Pictures [(fromJust . lookup "jogador5" ) skins]
          selecionador = ((fromJust . lookup "selecionador") texturaExtra)
          botaoSkins   = (fromJust . lookup "bskins") texturaExtra
desenhaEstadoGloss (EditarSkins 3, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures [Translate (-15) 0 background, Translate (100) (-300) $ Pictures [Translate (-700) (235) $ scale 4 4 jogador1, Translate (-400) (250) $ scale 4 4 jogador2, Translate (-100) (250) $ scale 4 4 jogador3, Translate (200) (250) $ scale 3.8 3.8 jogador4, Translate (500) (240) $ scale 3.8 3.8 jogador5, Translate (735) (725) $ scale 0.1 0.1 crossyroad, Translate (-105) (235) $ selecionador, Translate (-80) (550) $ scale 5 5 botaoSkins]]
    where background   = (fromJust . lookup "background") texturaExtra
          crossyroad   = (fromJust . lookup "crossyroad") texturaExtra
          jogador1     = Pictures [(fromJust . lookup "jogador1" ) skins] 
          jogador2     = Pictures [(fromJust . lookup "jogador2" ) skins]
          jogador3     = Pictures [(fromJust . lookup "jogador3" ) skins]
          jogador4     = Pictures [(fromJust . lookup "jogador4" ) skins]
          jogador5     = Pictures [(fromJust . lookup "jogador5" ) skins]
          selecionador = ((fromJust . lookup "selecionador") texturaExtra)
          botaoSkins   = (fromJust . lookup "bskins") texturaExtra
desenhaEstadoGloss (EditarSkins 4, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures [Translate (-15) 0 background, Translate (100) (-300) $ Pictures [Translate (-700) (235) $ scale 4 4 jogador1, Translate (-400) (250) $ scale 4 4 jogador2, Translate (-100) (250) $ scale 4 4 jogador3, Translate (200) (250) $ scale 3.8 3.8 jogador4, Translate (500) (240) $ scale 3.8 3.8 jogador5, Translate (735) (725) $ scale 0.1 0.1 crossyroad, Translate (210) (235) $ selecionador, Translate (-80) (550) $ scale 5 5 botaoSkins]]
    where background   = (fromJust . lookup "background") texturaExtra
          crossyroad   = (fromJust . lookup "crossyroad") texturaExtra
          jogador1     = Pictures [(fromJust . lookup "jogador1" ) skins] 
          jogador2     = Pictures [(fromJust . lookup "jogador2" ) skins]
          jogador3     = Pictures [(fromJust . lookup "jogador3" ) skins]
          jogador4     = Pictures [(fromJust . lookup "jogador4" ) skins]
          jogador5     = Pictures [(fromJust . lookup "jogador5" ) skins]
          selecionador = ((fromJust . lookup "selecionador") texturaExtra)
          botaoSkins   = (fromJust . lookup "bskins") texturaExtra
desenhaEstadoGloss (EditarSkins 5, jogo@(Jogo jogador@(Jogador (x,y)) mapa), texturaTerreno, texturaObstaculo, texturaExtra, modeloJogador, skins, score, maxscore, time, controlo, controloBot) = Pictures [Translate (-15) 0 background, Translate (100) (-300) $ Pictures [Translate (-700) (235) $ scale 4 4 jogador1, Translate (-400) (250) $ scale 4 4 jogador2, Translate (-100) (250) $ scale 4 4 jogador3, Translate (200) (250) $ scale 3.8 3.8 jogador4, Translate (500) (240) $ scale 3.8 3.8 jogador5, Translate (735) (725) $ scale 0.1 0.1 crossyroad, Translate (505) (235) $ selecionador, Translate (-80) (550) $ scale 5 5 botaoSkins]]
    where background   = (fromJust . lookup "background") texturaExtra
          crossyroad   = (fromJust . lookup "crossyroad") texturaExtra
          jogador1     = Pictures [(fromJust . lookup "jogador1" ) skins] 
          jogador2     = Pictures [(fromJust . lookup "jogador2" ) skins]
          jogador3     = Pictures [(fromJust . lookup "jogador3" ) skins]
          jogador4     = Pictures [(fromJust . lookup "jogador4" ) skins]
          jogador5     = Pictures [(fromJust . lookup "jogador5" ) skins]
          selecionador = ((fromJust . lookup "selecionador") texturaExtra)
          botaoSkins   = (fromJust . lookup "bskins") texturaExtra
desenhaEstadoGloss _ = Blank 

{- |
Função main, onde estão todos os importes de imagens e de todas as funções principais ao funcionamento do nosso jogo.

@
main :: IO ()
main = do
    rio             <- loadBMP "glossImages/rio.bmp"
    relva           <- loadBMP "glossImages/relva.bmp"
    estrada         <- loadBMP "glossImages/estrada.bmp"
    tronco          <- loadBMP "glossImages/tronco.bmp"
    arvore          <- loadBMP "glossImages/arvore.bmp"
    carro           <- loadBMP "glossImages/carro.bmp"
    background      <- loadBMP "glossImages/background.bmp"
    ajuda           <- loadBMP "glossImages/ajuda.bmp"
    jogador1        <- loadBMP "glossImages/jogadorRugby.bmp"
    jogador2        <- loadBMP "glossImages/jogadorFutebol.bmp"
    jogador3        <- loadBMP "glossImages/jogadorBasket.bmp"
    jogador4        <- loadBMP "glossImages/jogadorMario.bmp"
    jogador5        <- loadBMP "glossImages/jogadorLuigi.bmp"
    selecionador    <- loadBMP "glossImages/selecionador.bmp"
    crossyroad      <- loadBMP "glossImages/crossyroad.bmp"
    pausa           <- loadBMP "glossImages/pausa.bmp"
    botao           <- loadBMP "glossImages/button.bmp"
    botaoselecionar <- loadBMP "glossImages/buttonSelect.bmp"
    bjogar          <- loadBMP "glossImages/bjogar.bmp"
    bscore          <- loadBMP "glossImages/bscore.bmp"
    btopscore       <- loadBMP "glossImages/btopscore.bmp"
    bskins          <- loadBMP "glossImages/bskins.bmp"
    bajuda          <- loadBMP "glossImages/bajuda.bmp"
    bsair           <- loadBMP "glossImages/bsair.bmp"
    n0              <- loadBMP "glossImages/0.bmp"
    n1              <- loadBMP "glossImages/1.bmp"
    n2              <- loadBMP "glossImages/2.bmp"
    n3              <- loadBMP "glossImages/3.bmp"
    n4              <- loadBMP "glossImages/4.bmp"
    n5              <- loadBMP "glossImages/5.bmp"
    n6              <- loadBMP "glossImages/6.bmp"
    n7              <- loadBMP "glossImages/7.bmp"
    n8              <- loadBMP "glossImages/8.bmp"
    n9              <- loadBMP "glossImages/9.bmp"
    play dm
         (greyN 0.5)
         fr
         (estadoGlossInicial
         [
            ("Rio",     ((scale 0.3 0.3 rio), (0,0))), 
            ("Relva",   ((scale 0.3 0.3 relva), (0,0))),
            ("Estrada", ((scale 0.3 0.3 estrada), (0,0)))
         ]
         [
            (Arvore,  ((scale 0.3 0.3 arvore), (0,0))),
            (Tronco,  ((scale 0.3 0.3 tronco), (0,0))),
            (Carro,   (rotate (-90) (scale 0.13 0.13 carro), (0,0))),
            (Nenhum,  (Blank, (0,0)))
         ]
         [
            ("background"      , (scale 1.4 1.4 background)),
            ("ajuda"           , (scale 0.7 0.7 ajuda)),
            ("selecionador"    , (scale 1 1 selecionador)),
            ("crossyroad"      , crossyroad),
            ("pausa"           , (scale 0.95 0.95 pausa)),
            ("botao"           , (scale 1.3 1.3 botao)),
            ("bjogar"          , (scale 0.35 0.35 bjogar)),
            ("bscore"          , (scale 0.35 0.35 bscore)),
            ("btopscore"       , (scale 0.35 0.35 btopscore)),
            ("bskins"          , (scale 0.35 0.35 bskins)),
            ("bajuda"          , (scale 0.35 0.35 bajuda)),
            ("bsair"           , (scale 0.35 0.35 bsair)),
            ("botaoselecionar" , (scale 1.3 1.3 botaoselecionar)),
            ("n0"              , (scale 0.55 0.55 n0)),
            ("n1"              , (scale 0.55 0.55 n1)),
            ("n2"              , (scale 0.55 0.55 n2)),
            ("n3"              , (scale 0.55 0.55 n3)),
            ("n4"              , (scale 0.55 0.55 n4)),
            ("n5"              , (scale 0.55 0.55 n5)),
            ("n6"              , (scale 0.55 0.55 n6)),
            ("n7"              , (scale 0.55 0.55 n7)),
            ("n8"              , (scale 0.55 0.55 n8)),
            ("n9"              , (scale 0.55 0.55 n9))

         ]
         [
            ("jogador1", (scale 0.2 0.2 jogador1)), 
            ("jogador2", (scale 0.3 0.3 jogador2)),
            ("jogador3", (scale 0.2 0.2 jogador3)),
            ("jogador4", (scale 0.2 0.2 jogador4)),
            ("jogador5", (scale 0.3 0.3 jogador5))
         ]
         )
        desenhaEstadoGloss
        reageEventoGloss
        reageTempoGloss
@

-}  

main :: IO ()
main = do
    rio             <- loadBMP "glossImages/rio.bmp"
    relva           <- loadBMP "glossImages/relva.bmp"
    estrada         <- loadBMP "glossImages/estrada.bmp"
    tronco          <- loadBMP "glossImages/tronco.bmp"
    arvore          <- loadBMP "glossImages/arvore.bmp"
    carro           <- loadBMP "glossImages/carro.bmp"
    background      <- loadBMP "glossImages/background.bmp"
    ajuda           <- loadBMP "glossImages/ajuda.bmp"
    jogador1        <- loadBMP "glossImages/jogadorRugby.bmp"
    jogador2        <- loadBMP "glossImages/jogadorFutebol.bmp"
    jogador3        <- loadBMP "glossImages/jogadorBasket.bmp"
    jogador4        <- loadBMP "glossImages/jogadorMario.bmp"
    jogador5        <- loadBMP "glossImages/jogadorLuigi.bmp"
    selecionador    <- loadBMP "glossImages/selecionador.bmp"
    crossyroad      <- loadBMP "glossImages/crossyroad.bmp"
    pausa           <- loadBMP "glossImages/pausa.bmp"
    botao           <- loadBMP "glossImages/button.bmp"
    botaoselecionar <- loadBMP "glossImages/buttonSelect.bmp"
    bjogar          <- loadBMP "glossImages/bjogar.bmp"
    bscore          <- loadBMP "glossImages/bscore.bmp"
    btopscore       <- loadBMP "glossImages/btopscore.bmp"
    bskins          <- loadBMP "glossImages/bskins.bmp"
    bajuda          <- loadBMP "glossImages/bajuda.bmp"
    bsair           <- loadBMP "glossImages/bsair.bmp"
    n0              <- loadBMP "glossImages/0.bmp"
    n1              <- loadBMP "glossImages/1.bmp"
    n2              <- loadBMP "glossImages/2.bmp"
    n3              <- loadBMP "glossImages/3.bmp"
    n4              <- loadBMP "glossImages/4.bmp"
    n5              <- loadBMP "glossImages/5.bmp"
    n6              <- loadBMP "glossImages/6.bmp"
    n7              <- loadBMP "glossImages/7.bmp"
    n8              <- loadBMP "glossImages/8.bmp"
    n9              <- loadBMP "glossImages/9.bmp"
    play dm
         (greyN 0.5)
         fr
         (estadoGlossInicial
         [
            ("Rio",     ((scale 0.3 0.3 rio), (0,0))), 
            ("Relva",   ((scale 0.3 0.3 relva), (0,0))),
            ("Estrada", ((scale 0.3 0.3 estrada), (0,0)))
         ]
         [
            (Arvore,  ((scale 0.3 0.3 arvore), (0,0))),
            (Tronco,  ((scale 0.3 0.3 tronco), (0,0))),
            (Carro,   (rotate (-90) (scale 0.13 0.13 carro), (0,0))),
            (Nenhum,  (Blank, (0,0)))
         ]
         [
            ("background"      , (scale 1.4 1.4 background)),
            ("ajuda"           , (scale 0.7 0.7 ajuda)),
            ("selecionador"    , (scale 1 1 selecionador)),
            ("crossyroad"      , crossyroad),
            ("pausa"           , (scale 0.95 0.95 pausa)),
            ("botao"           , (scale 1.3 1.3 botao)),
            ("bjogar"          , (scale 0.35 0.35 bjogar)),
            ("bscore"          , (scale 0.35 0.35 bscore)),
            ("btopscore"       , (scale 0.35 0.35 btopscore)),
            ("bskins"          , (scale 0.35 0.35 bskins)),
            ("bajuda"          , (scale 0.35 0.35 bajuda)),
            ("bsair"           , (scale 0.35 0.35 bsair)),
            ("botaoselecionar" , (scale 1.3 1.3 botaoselecionar)),
            ("n0"              , (scale 0.55 0.55 n0)),
            ("n1"              , (scale 0.55 0.55 n1)),
            ("n2"              , (scale 0.55 0.55 n2)),
            ("n3"              , (scale 0.55 0.55 n3)),
            ("n4"              , (scale 0.55 0.55 n4)),
            ("n5"              , (scale 0.55 0.55 n5)),
            ("n6"              , (scale 0.55 0.55 n6)),
            ("n7"              , (scale 0.55 0.55 n7)),
            ("n8"              , (scale 0.55 0.55 n8)),
            ("n9"              , (scale 0.55 0.55 n9))

         ]
         [
            ("jogador1", (scale 0.2 0.2 jogador1)), 
            ("jogador2", (scale 0.3 0.3 jogador2)),
            ("jogador3", (scale 0.2 0.2 jogador3)),
            ("jogador4", (scale 0.2 0.2 jogador4)),
            ("jogador5", (scale 0.3 0.3 jogador5))
         ]
         )
        desenhaEstadoGloss
        reageEventoGloss
        reageTempoGloss

{- |
Estado inicial do nosso jogo.

@
estadoInicial = jogo1


jogo1= Jogo (Jogador (5,6)) mapa1

mapa1 = (Mapa 11 [(Relva, [Nenhum, Arvore, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Arvore, Arvore]),
                 (Rio (-1), [Tronco, Nenhum, Tronco, Tronco, Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco, Nenhum]),
                 (Rio 2, [Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco, Tronco, Nenhum, Tronco, Tronco, Nenhum]),
                 (Rio (-1), [Nenhum, Nenhum, Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco, Tronco, Nenhum, Tronco]),
                 (Rio 1, [Tronco, Nenhum, Tronco, Nenhum, Tronco, Tronco, Nenhum, Tronco, Tronco, Tronco, Nenhum]),
                 (Estrada 1, [Carro, Carro, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Carro]),
                 (Relva, [Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Arvore, Arvore, Arvore]),
                 (Relva, [Arvore, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Arvore, Arvore, Arvore, Arvore, Arvore]),
                 (Relva, [Arvore, Arvore, Nenhum, Nenhum, Nenhum, Arvore, Arvore, Arvore, Arvore, Arvore, Arvore])])
@

-} 

estadoInicial = jogo1


jogo1= Jogo (Jogador (5,6)) mapa1

mapa1 = (Mapa 11 [(Relva, [Nenhum, Arvore, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Arvore, Arvore]),
                 (Rio (-1), [Tronco, Nenhum, Tronco, Tronco, Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco, Nenhum]),
                 (Rio 2, [Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco, Tronco, Nenhum, Tronco, Tronco, Nenhum]),
                 (Rio (-1), [Nenhum, Nenhum, Tronco, Tronco, Nenhum, Tronco, Nenhum, Tronco, Tronco, Nenhum, Tronco]),
                 (Rio 1, [Tronco, Nenhum, Tronco, Nenhum, Tronco, Tronco, Nenhum, Tronco, Tronco, Tronco, Nenhum]),
                 (Estrada 1, [Carro, Carro, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Carro]),
                 (Relva, [Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Arvore, Arvore, Arvore]),
                 (Relva, [Arvore, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Arvore, Arvore, Arvore, Arvore, Arvore]),
                 (Relva, [Arvore, Arvore, Nenhum, Nenhum, Nenhum, Arvore, Arvore, Arvore, Arvore, Arvore, Arvore])])
