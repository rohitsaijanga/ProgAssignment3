best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data <- as.data.frame(data)
    #c <- colnames(data)
    #c[c(11,17,23)]
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
    ## Return hospital name in that state with lowest 30-day death rate
    result <- csub[csub[,colneeded] == min(csub[,colneeded],na.rm = TRUE),2]
    result <- result[order(result)]
    result[1]
}

#best("TX","heart attack")
