###
### Jeu du loup
###

### L --- loup controled by CPU
### @ --- chat controled by numberpad

### +-----+
### |L    |
### |     |
### |     |
### |     |
### |    @|
### +-----+
###        NxN

### Small syntax help
### a <- 5 assigns 5 to the variable called 'a'
### a <<- 5 assigns 5 to global variable called 'a'

chat.old <<- c(1,1)
loup.old <<- c(1,1)


if (! exists('N') ) N = 7
## initalise positions of chat and loup
chat <- c(N,1)
loup <- c(1,N)


draw.chat.and.loup <- function (chat, loup) {
    ## draw an empty plot
    plot(0,0,
         xlim=c(0.5, N + 0.5),
         ylim=c(0.5, N + 0.5),
         ylab='', xlab ='',
         type='n')
    
    ## add the grid
    field = seq(0.5, N + 0.5, 1)
    abline(h = field, v = field)
    
    ## plot chat and loup
    points (chat[1], chat[2], pch = '@', col = 'blue')
    points (loup[1], loup[2], pch = 'L', col = 'red')

    chat.old <<- chat
    loup.old <<- loup
}


onKeybd <- function(key)
{
    keyPressed <<- key
}
chat.move.user <- function () {

    getGraphicsEvent(prompt = "", 
                     onMouseDown = NULL, onMouseMove = NULL,
                     onMouseUp = NULL, onKeybd = onKeybd,
                     consolePrompt = "")
    move <- c(0,0)

    ## Controls are
    ## 789
    ## 456
    ## 123
    if (keyPressed == '7') move <- c(-1, 1)
    if (keyPressed == '8') move <- c( 0, 1)
    if (keyPressed == '9') move <- c( 1, 1)
    
    if (keyPressed == '4') move <- c(-1, 0)
    if (keyPressed == '5') move <- c( 0, 0)
    if (keyPressed == '6') move <- c( 1, 0)

    if (keyPressed == '1') move <- c(-1,-1)
    if (keyPressed == '2') move <- c( 0,-1)
    if (keyPressed == '3') move <- c( 1,-1)
        
    return (move)
}
chat.move.random <- function() {
    random.move = sample(c(-1,0,1),2, replace=TRUE)
    ## Currently it moves randomly
    return (random.move)
}
chat.move <- chat.move.user


main <- function () {
    
    ## close all graphic devices
    graphics.off()

    ## open a new one
    X11(type = "Xlib") ## or windows()
    ## par (bg = 'black', fg = 'white')
        
    draw.chat.and.loup (chat, loup)

    total.steps <- 0
    miam.steps <- 0
    performance.history <- NULL
    
    while(TRUE) {

        Sys.sleep(0.4)
        
        ## chat and loup decides independently,
        ## they can even "jump" over, in this case loup don't eat chat
        new.chat <- chat.move()
        new.loup <- loup.move(chat, loup)
        
        chat <- chat + new.chat
        
        ## do not cross the borders
        chat[1] <- min(N, max (1, chat[1]))
        chat[2] <- min(N, max (1, chat[2]))
        
        loup <- loup + new.loup
        ## do not cross the borders
        loup[1] <- min(N, max (1, loup[1]))
        loup[2] <- min(N, max (1, loup[2]))

        draw.chat.and.loup (chat, loup)
        
        total.steps <- total.steps + 1
        if (all (chat == loup)) {
            miam.steps <- miam.steps + 1
            print('Miam!')
        }

        
        performance = miam.steps/total.steps
        print(paste('performance = ',performance))

        performance.history <- rbind(performance.history,
                                     c(total.steps, performance))
        
        points (1 + performance.history[,1]/length(performance.history[,1]) * N,
                1 + performance.history[,2] * N,
                pch=0, col = 'violet')

    }
}

loup.move.random <- function (chat, loup) {
    ## gives a vector from [-1,0,1]^2
    ## this vector indicates the direction of future movement

    random.move = sample(c(-1,0,1),2, replace=TRUE)
    ## Currently it moves randomly
    return (random.move)
}

loup.move <- loup.move.random
