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
#
#
# ------------------------------------------------------------------------------
# Function for the editing of the cells
# ------------------------------------------------------------------------------
#
bmt_behav_progr.cell_edited <- function(cell, path.string, new.text, data) {
  #checkPtrType(data, "behav_progrkListStore")
  if (is.na(as.double(new.text) )) {
      showError("Coefficients for fleet dynamics must be a number!")
 } else {
 bmt_behav_progr.model <- data 
  path <- gtkTreePathNewFromString(path.string)
  print(paste("behav_progr Edited row:", (as.numeric(path.string)+1)))
  column <- as.integer(cell$getData("column"))
  print(paste("behav_progr Edited column:", column))
  iter <- bmt_behav_progr.model$getIter(path)$iter
   #print(paste("new text:", new.text))
  	i <- path$getIndices()[[1]]+1
  	#print(paste("indice i:", i))
  #	print(pproductions[[i]])
  	bmt_behav_progr_list[[i]][column+1] <<- as.double(new.text)           # [column+1]
  #	print(paste("indice column:", column+1))
  #	print(pproductions[[i]][column+1])
  	bmt_behav_progr.model$set(iter, column, bmt_behav_progr_list[[i]][column+1])

         for (r in 1:length(bmt_behav_progr_list)) {
  bmt_fleet.behav_progr[r,] <<- as.numeric(as.character(bmt_behav_progr_list[[r]]))
  }
  
        for (nro in 1:nrow( bmt_fleet.behav_progr)) {
    mat_cfg_TechProgress[4:nrow(mat_cfg_TechProgress),nro+1] <<- as.character(bmt_fleet.behav_progr[nro,2:ncol(bmt_fleet.behav_progr)])
}

print(mat_cfg_TechProgress)

}
}
