# ALADYM  Age length based dynamic model - version 12.3
# Authors: G. Lembo, I. Bitetto, M.T. Facchini, M.T. Spedicato 2018
# COISPA Tecnologia & Ricerca, Via dei Trulli 18/20 - (Bari), Italy 
# In case of use of the model, the Authors should be cited.
# If you have any comments or suggestions please contact the following e-mail address: facchini@coispa.it
# ALADYM is believed to be reliable. However, we disclaim any implied warranty or representation about its accuracy, 
# completeness or appropriateness for any particular purpose.



#
#
#
#
#
#
#
#
#
# ------------------------------------------------------------------------------
# Function to reload the values for the production according to the 
# seed value
# ------------------------------------------------------------------------------
#
reload_EMPTY_escape_survival_extvectorF<- function(w) {
                           
escape_survival_extvector_F_list <<- list()
escape_survival_extvector_FIndex <<- 0

if (!IN_BEMTOOL | (IN_BEMTOOL & phase=="SIMULATION") ) {
  n_ages <- as.numeric(gtkEntryGetText(entryVBF_F_lifespan))  
} else {
  n_ages <- as.numeric(new_aldPopulation@lifespan[2,1])      
} 
#
first_age_fem <- 0
n_ages <- n_ages - trunc(Tr/12)
first_age_fem <- trunc(Tr/12)

      FF_matrix <- data.frame(matrix(1, nrow=1, ncol=n_ages))
     # colnames(FF_matrix) <- c("year",paste("age", c(0:(n_ages-1)), sep=""))   
      colnames(FF_matrix) <-   c(paste("age", c(first_age_fem:(n_ages+first_age_fem-1)), sep="") )
   for (r in 1:nrow(FF_matrix)) { 
  FF_temp <- as.list(FF_matrix[r,]) 
  escape_survival_extvector_F_list <<- c(escape_survival_extvector_F_list, list(FF_temp)) 
  }
  
    escape_surv_extvector_Ftable <<- FF_matrix    
  
  escape_survival_extvector_F.model <<- gtkListStoreNew(rep("gdouble", n_ages), "gboolean")  
 
  for (i in 1:length(escape_survival_extvector_F_list)) {
    iter <- escape_survival_extvector_F.model$append()$iter
   #print(paste("in sexratios.model:", as.character(sexratios[[i]]$month)))
    #escape_survival_extvector_F.model$set(iter,0, escape_survival_extvector_F_list[[i]]$year)
    for (e in 1:(n_ages) ) {
   # print(paste("in model:", years[nc]) )
         escape_survival_extvector_F.model$set(iter, e-1, as.numeric(escape_survival_extvector_F_list[[i]][e]))
    }
       escape_survival_extvector_F.model$set(iter, (n_ages),TRUE)
  } 

escape_survival_extvector_F.treeview$destroy()
escape_survival_extvector_F.treeview <<- gtkTreeViewNewWithModel(escape_survival_extvector_F.model)
escape_survival_extvector_F.treeview$setRulesHint(TRUE)
escape_survival_extvector_F.treeview$getSelection()$setMode("single")
escape_survival_extvector_F.add_columns(escape_survival_extvector_F.treeview)
escape_survival_extvector_F.sw$add(escape_survival_extvector_F.treeview)  
  
}


reload_escape_survival_extvectorF<- function(w) {
                           
escape_survival_extvector_F_list <<- list()
escape_survival_extvector_FIndex <<- 0

if (!IN_BEMTOOL | (IN_BEMTOOL & phase=="SIMULATION") ) {
  n_ages <- as.numeric(gtkEntryGetText(entryVBF_F_lifespan))  
} else {
  n_ages <- as.numeric(new_aldPopulation@lifespan[2,1])      
} 
#
first_age_fem <- 0
n_ages <- n_ages - trunc(Tr/12)
first_age_fem <- trunc(Tr/12)

     FF_matrix <-  escape_surv_extvector_Ftable 
     # colnames(FF_matrix) <- c("year",paste("age", c(0:(n_ages-1)), sep=""))   
      colnames(FF_matrix) <-   c(paste("age", c(first_age_fem:(n_ages+first_age_fem-1)), sep="") )
   for (r in 1:nrow(FF_matrix)) { 
  FF_temp <- as.list(FF_matrix[r,]) 
  escape_survival_extvector_F_list <<- c(escape_survival_extvector_F_list, list(FF_temp)) 
  }

  escape_survival_extvector_F.model <<- gtkListStoreNew(rep("gdouble", n_ages), "gboolean")  
 
  for (i in 1:length(escape_survival_extvector_F_list)) {
    iter <- escape_survival_extvector_F.model$append()$iter
   #print(paste("in sexratios.model:", as.character(sexratios[[i]]$month)))
    #escape_survival_extvector_F.model$set(iter,0, escape_survival_extvector_F_list[[i]]$year)
    for (e in 1:(n_ages) ) {
   # print(paste("in model:", years[nc]) )
         escape_survival_extvector_F.model$set(iter, e-1, as.numeric(escape_survival_extvector_F_list[[i]][e]))
    }
       escape_survival_extvector_F.model$set(iter, (n_ages),TRUE)
  } 

escape_survival_extvector_F.treeview$destroy()
escape_survival_extvector_F.treeview <<- gtkTreeViewNewWithModel(escape_survival_extvector_F.model)
escape_survival_extvector_F.treeview$setRulesHint(TRUE)
escape_survival_extvector_F.treeview$getSelection()$setMode("single")
escape_survival_extvector_F.add_columns(escape_survival_extvector_F.treeview)
escape_survival_extvector_F.sw$add(escape_survival_extvector_F.treeview)  
  
}