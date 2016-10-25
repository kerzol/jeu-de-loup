###
### Q-learning algorithm for loup movements in Jeu de Loup
###

###
### States are Position x Position
###

source('loup.R')

### L --- loup controled by CPU
### @ --- chat controled by numberpad

### +-----+
### |L    |
### |     |
### |     |
### |     |
### |    @|
### +-----+

### Small syntax help
### a <- 5 assigns 5 to the variable called 'a'
### a <<- 5 assigns 5 to global variable called 'a'

ACTIONS = list (
    c( 1, 0),
    c( 0, 0),
    c(-1, 0),
    c( 1, 1),
    c( 0, 1),
    c(-1, 1),
    c( 1,-1),
    c( 0,-1),
    c(-1,-1)
)

### Position = [1,2..N]^2
### We need to describe positions of chat and loop, so
### S = Position^2
### Q : S x A -> R

Q <- array(data = 0, dim = c(N,N,N,N,length(ACTIONS)))

### Use it like this Q[chat.x, chat.y, loup.x, loup.y, action]


### Q-learning parameters
ALPHA = 0.6
LAMBDA = 0.4
PROBABILITY.OF.RANDOM.ACTION = 0


OLD.ACTION.INDEX <<- 0
OLD.STATE <<- c(0,0,0,0)

loup.move.Q <- function (chat, loup) {
    ## gives a vector from [-1,0,1]^2
    ## this vector indicates the direction of future movement


    ## using chat's and loup's positions we construct a current state
    current.state = c(chat[1], chat[2], loup[1], loup[2])
    
    policy <- Q[current.state[1],
                current.state[2],
                current.state[3],
                current.state[4],]

    old.Q <- Q[OLD.STATE[1], OLD.STATE[2], OLD.STATE[3], OLD.STATE[4], OLD.ACTION.INDEX]

    ## reward is the distance, less is better
    d <- max( abs(chat[1] - loup[1]), abs(chat[2] - loup[2]) )
    if (d == 0) {reward = 100}
    else {reward = 0}

    
    Q[OLD.STATE[1], OLD.STATE[2], OLD.STATE[3], OLD.STATE[4], OLD.ACTION.INDEX] <<-
        (1 - ALPHA) * old.Q  +
             ALPHA  * (reward + LAMBDA * max(policy) )

    policy <- Q[current.state[1],
                current.state[2],
                current.state[3],
                current.state[4],]


    if (runif(1) < PROBABILITY.OF.RANDOM.ACTION) {
        ## sometimes we do random action in order to explore environement
        action.index <- sample(1:length(ACTIONS),1)
    } else {
        ## sometimes we use the estimated Q-policy
        maximums <- which(policy == max(policy))
        if (length(maximums) > 1) {
            action.index <- sample (maximums, 1)
        } else {
            action.index <- maximums[1]
        }
    }

    OLD.ACTION.INDEX <<- action.index
    OLD.STATE <<- current.state
    return (ACTIONS[[action.index]])
}
