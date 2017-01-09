rankall <- function(outcome, num = "best") 
    {
    
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
    c <- c[order(c)]
    ## Check that state and outcome are valid
    
    get_hospital <- function(state){
        
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
    
    d <- csub[csub[,ncol(csub)]== num,2]
    return (d)
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    }
    ## For each state, find the hospital of the given rank    
    hospital <- lapply(c, get_hospital)
    
    result <- cbind(hospital = hospital, state = c)
    result <- as.data.frame(result)
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    result
}


# head(rankall("heart attack", 20), 10)
# tail(rankall("pneumonia", "worst"), 3)
# tail(rankall("heart failure"), 10)
