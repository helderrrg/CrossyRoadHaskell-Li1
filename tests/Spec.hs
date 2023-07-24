module Main where

import Tarefa1_2022li1g016_Spec
import Tarefa2_2022li1g016_Spec
import Tarefa3_2022li1g016_Spec
import Tarefa4_2022li1g016_Spec
import Tarefa5_2022li1g016_Spec
import Bot_Spec
import Test.HUnit

runTestsT1 = runTestTT testesTarefa1

runTestsT2 = runTestTT testesTarefa2

runTestsT3 = runTestTT testesTarefa3

runTestsT4 = runTestTT testesTarefa4

runTestsT5 = runTestTT testesTarefa5

runTestsT6 = runTestTT testesBot

main = runTestTTAndExit $ TestList [testesTarefa1, testesTarefa2, testesTarefa3, testesTarefa4, testesTarefa5, testesBot]
