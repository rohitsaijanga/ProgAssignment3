rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data <- as.data.frame(data)
    if(outcome == "heart attack")
    {
        colneeded <- 11  
    }
    else if(outcome == "heart failure")
    {
        colneeded <- 17
    }
    else if(outcome == "pneumonia")
    {
        colneeded <- 23
    }
    else
    {
        stop("invalid outcome")
    }
    c <- unique(data$State)
    ## Check that state and outcome are valid
    
    if ((sum(c == state)) != 1)
    {
        stop("invalid state")
    }

    csub <- subset(data[(data[,7]== state),])
    csub[,colneeded] <- as.numeric(csub[,colneeded])
    csub <- csub[!is.na(csub[,colneeded]),]
    csub <- csub[order(csub[,2]),]
    csub <- csub[order(csub[,colneeded]),]
    rank <- c(1:nrow(csub))
    csub <- cbind(csub,rank)
    
    if(num == "best")
    {
        num <- 1
    }else if(num == "worst") 
    {
        num <- max(rank)
    }else if( num > max(rank)) 
    {
        return(NA)
    }
    
    csub[csub[,ncol(csub)]== num,2]
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
}



# rankhospital(state = "MD",outcome = "heart attack",num = 5000 )
