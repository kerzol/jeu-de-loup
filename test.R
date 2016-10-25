# source('q-loup.R') # states are differences between positions
N = 5
source('q-loup-1.R') # states are cooridnates

## random learning
chat.move <- chat.move.random; loup.move <- loup.move.Q;  PROBABILITY.OF.RANDOM.ACTION = 0.3; main()


## totally random
chat.move <- chat.move.random; loup.move <- loup.move.random; PROBABILITY.OF.RANDOM.ACTION = 0; main()


## without learning
chat.move <- chat.move.random; loup.move <- loup.move.Q; PROBABILITY.OF.RANDOM.ACTION = 0; main()

## vs user
chat.move <- chat.move.user; loup.move <- loup.move.Q; PROBABILITY.OF.RANDOM.ACTION = 0; main()


## cyclic learning...
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
## with random actions
chat.move <- chat.move.cyclic; loup.move <- loup.move.Q;  PROBABILITY.OF.RANDOM.ACTION = 0.2; main()


## cyclic without random actions
chat <- c(4,5)
chat.move <- chat.move.cyclic; loup.move <- loup.move.Q;  PROBABILITY.OF.RANDOM.ACTION = 0; main()

## user control
chat <- c(4,5)
chat.move <- chat.move.user; loup.move <- loup.move.Q;  PROBABILITY.OF.RANDOM.ACTION = 0.2; main()


