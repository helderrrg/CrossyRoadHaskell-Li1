# Crossy Road Haskell

## Software Labs I | Laboratórios de Informática I
## Grade: 17/20 :star:

This game was developed during the first semester of the Software Engineering degree @ University of Minho.

The project involved reimagining the classic game Crossy Road, while also having the creative freedom to introduce new elements and completely overhaul the visual design.

It was fully developed in Haskell and consisted of 6 tasks:

1. Verify if a given map is valid;

2. Continuous generation of the map;

3. Character movement and obstacles;

4. Check if the game;

5. Map scrolling;

6. Create and implement game graphics, using Gloss.

## Game gallery

<img align = "center" width = 900px src = "https://github.com/helderrrg/Projeto-LI1/blob/main/assets/mainpage.jpg"/>
<img align = "center" width = 900px src = "https://github.com/helderrrg/Projeto-LI1/blob/main/assets/skins.jpg"/>
<img align = "center" width = 900px src = "https://github.com/helderrrg/Projeto-LI1/blob/main/assets/help.jpg"/>
<img align = "center" width = 900px src = "https://github.com/helderrrg/Projeto-LI1/blob/main/assets/game.png"/>

## Installing and running the game

**If you use any arch-based distro, head to the next section.**
Firstly, install Haskell Platform (GHC and Cabal).
To do so, follow the instructions for your specific system at: [haskell.org/downloads](https://www.haskell.org/downloads/)

Finally, since the graphical interface of the game was developed using the [Gloss](https://hackage.haskell.org/package/gloss) library, you'll need to install it:

```bash
$ cabal update
$ cabal install --lib gloss
$ cabal install --lib gloss-juicy
```

Since I used some more external libraries, you'll need to install them too:

```bash
$ cabal install --lib strict-io
```

#### Cloning the repository

```bash
$ git clone git@github.com:helderrrg/Projeto-LI1.git
```


#### Compiling

```bash
$ cd Projeto-LI1/src
$ ghc Main.hs
```

#### Running

```bash
$ cd ..
$ ./src/Main
```
## Interpreter

You can open the interpreter Haskell (GHCi) using the cabal or directly.

1. Using `cabal`

```bash
$ cabal repl
```

2. Using `GHCi`

```bash
$ ghci -i="src" -i="tests" src/Main.hs
```

## Documentation

You can generate documentation with the [Haddock](https://haskell-haddock.readthedocs.io/).

1. Using `cabal`

```bash
$ cabal haddock --haddock-all
```

2. Using directly `haddock`

```bash
$ haddock -h -o doc/html src/*.hs
```

## Grupo 16

- Daniel Silva;
- [Hélder Gomes](https://github.com/helderrrg)