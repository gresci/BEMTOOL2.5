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
# ------------------------------------------------------------------------------
# create model for the tree of discard
# ------------------------------------------------------------------------------
#
FISHINGEFFORT_fore.create_model <- function() {
#print("Creating model...")   
  # create list store
 FISHINGEFFORT_fore.model <<- gtkListStoreNew("gchararray",  rep("gdouble", length(MONTHS)), "gboolean")  
  add.FISHINGEFFORT_fore()
  # add items 
  for (i in 1:length(FISHINGEFFORT_fore)) {
    iter <- FISHINGEFFORT_fore.model$append()$iter
   #print(paste("in sexratios.model:", as.character(sexratios[[i]]$month)))
    FISHINGEFFORT_fore.model$set(iter,0, FISHINGEFFORT_fore[[i]]$year)
    for (e in 1:length(MONTHS)) {
   # print(paste("in model:", years[nc]) )
         FISHINGEFFORT_fore.model$set(iter, e, as.numeric(FISHINGEFFORT_fore[[i]][e+1]))
    }
       FISHINGEFFORT_fore.model$set(iter, 13,TRUE)
  } 
  #print("FISHINGEFFORT forecast Model successfully created!")  
}