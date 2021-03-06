# BEMTOOL - Bio-Economic Model TOOLs - version 2.5
# Authors: G. Lembo, I. Bitetto, M.T. Facchini, M.T. Spedicato 2018
# COISPA Tecnologia & Ricerca, Via dei Trulli 18/20 - (Bari), Italy 
# In case of use of the model, the Authors should be cited.
# If you have any comments or suggestions please contact the following e-mail address: facchini@coispa.it
# BEMTOOL is believed to be reliable. However, we disclaim any implied warranty or representation about its accuracy, 
# completeness or appropriateness for any particular purpose.



#
#
#
#
#
#
#
#
# ------------------------------------------------------------------------------
# create model for the tree of p production
# ------------------------------------------------------------------------------
#
bmt_DAY.create_model <- function() {
#print("Creating model...")   
  # create list store
  bmt_DAY.model <<- gtkListStoreNew("gchararray",  rep("gdouble", length(MONTHS)), "gboolean")  
  bmt_add.DAY()
  # add items 
  for (i in 1:length(bmt_DAY_list)) {
    iter <- bmt_DAY.model$append()$iter
   #print(paste("in sexratios.model:", as.character(sexratios[[i]]$month)))
    bmt_DAY.model$set(iter,0, bmt_DAY_list[[i]]$year)
    for (e in 1:length(MONTHS)) {
   # print(paste("in model:", years[nc]) )
         bmt_DAY.model$set(iter, e, as.numeric(bmt_DAY_list[[i]][e+1]))
    }
       bmt_DAY.model$set(iter, 13,TRUE)
  } 
  #print("DAY Model successfully created!")  
}
