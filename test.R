# source('q-loup.R') # states are differences between positions
N = 5
source('q-loup-1.R') # states are cooridnates

## totally random movements, without any learning
chat.move <- chat.move.random; loup.move <- loup.move.random; PROBABILITY.OF.RANDOM.ACTION = 0; main()


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
chat.move <- chat.move.cyclic; loup.move <- loup.move.Q;  PROBABILITY.OF.RANDOM.ACTION = 0; main()

## user controls chat
chat <- c(4,5)
chat.move <- chat.move.user; loup.move <- loup.move.Q;  PROBABILITY.OF.RANDOM.ACTION = 0.2; main()
