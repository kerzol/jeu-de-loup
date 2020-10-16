## First, we define how large is our environnement
N = 5

## then we load some files that describe behaviour of loup, chat, and related stuff
source('q-loup-1.R') # where states are cooridnates
## source('q-loup.R') # where states are differences between positions


## Next, we can try to run the game, by executing the following line
## which produces totally random movements, without any learning
chat.move <- chat.move.random; loup.move <- loup.move.random; PROBABILITY.OF.RANDOM.ACTION = 0; main()

## To stop the execution one type Ctrl-C in terminal.

## Now, we are ready to read following lines, undertand and run them (In that order):



## loup moves sometimes random, sometimes not. With learning
chat.move <- chat.move.random; loup.move <- loup.move.Q;  PROBABILITY.OF.RANDOM.ACTION = 0.3; main()

## loup moves only using Q-function. With learning
chat.move <- chat.move.random; loup.move <- loup.move.Q; PROBABILITY.OF.RANDOM.ACTION = 0; main()

## User controls chat
chat.move <- chat.move.user; loup.move <- loup.move.Q; PROBABILITY.OF.RANDOM.ACTION = 0; main()


## cyclic learning...
## chat moves cyclically
##
##  +-----+   +-----+   +-----+   +-----+   +-----+ 
## 5|   @ |  5|     |  5|     |  5|     |  5|   @ | 
## 4|     |  4|    @|  4|     |  4|  @  |  4|     |  +-+-+----+
## 3|     |  3|     |  3|   @ |  3|     |  3|     |  |e|t|c...|
## 2|     |  2|     |  2|     |  2|     |  2|     |  +-+-+-----
## 1|     |  1|     |  1|     |  1|     |  1|     | 
##  +-----+   +-----+   +-----+   +-----+   +-----+ 
##   12345     12345     12345     12345     12345
chat <- c(4,5);
cycl <- list(
    c(1,-1),
    c(-1,-1),
    c(-1,1),
    c(1,1)
)
GI <<- 0
chat.move.cyclic <- function () {
    GI <<- GI + 1
    if (GI > length(cycl)) GI <<- 1
    return (cycl[[GI]])
}
## cyclic chat with sometimes random actions of loup
chat.move <- chat.move.cyclic; loup.move <- loup.move.Q;  PROBABILITY.OF.RANDOM.ACTION = 0.2; main()


## cyclic chat without random actions of loup
chat <- c(4,5)
chat.move <- chat.move.cyclic; loup.move <- loup.move.Q;  PROBABILITY.OF.RANDOM.ACTION = 0.1; main()

## user controls chat
chat <- c(4,5)
chat.move <- chat.move.user; loup.move <- loup.move.Q;  PROBABILITY.OF.RANDOM.ACTION = 0.2; main()
