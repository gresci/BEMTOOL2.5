# ALADYM  Age length based dynamic model - version 12.3
# Authors: G. Lembo, I. Bitetto, M.T. Facchini, M.T. Spedicato 2018
# COISPA Tecnologia & Ricerca, Via dei Trulli 18/20 - (Bari), Italy 
# In case of use of the model, the Authors should be cited.
# If you have any comments or suggestions please contact the following e-mail address: facchini@coispa.it
# ALADYM is believed to be reliable. However, we disclaim any implied warranty or representation about its accuracy, 
# completeness or appropriateness for any particular purpose.




#
# ------------------------------------------------------------------------------
# Function for the editing of the cells
# ------------------------------------------------------------------------------
#
escape_survival_extvector_F.cell_edited <- function(cell, path.string, new.text, data) {
 if (!is.na(as.double(new.text) )) {
  if (! (as.double(new.text) <= 1 & as.double(new.text) >= 0) ) {
      showError("Value for escape survivability rate for FEMALES must be between 0 and 1!")
 } else { 
  #checkPtrType(data, "GtkListStore")
  escape_survival_extvector_F.model <- data 
  path <- gtkTreePathNewFromString(path.string)
  print(paste("Discard (FEMALES) Edited row:", (as.numeric(path.string)+1)))
  column <- as.integer(cell$getData("column"))
  print(paste("Discard (FEMALES) Edited column:", column))
  iter <- escape_survival_extvector_F.model$getIter(path)$iter
   #print(paste("new text:", new.text))
  	i <- path$getIndices()[[1]]+1
  	#print(paste("indice i:", i))
  	#print(Zvector_M[[i]])
  	escape_survival_extvector_F_list[[i]][column+1] <<- as.double(new.text)           # [column+1]
  #	print(paste("indice column:", column+1))
  #	print(Zvector_M[[i]][column+1])
  	escape_survival_extvector_F.model$set(iter, column, escape_survival_extvector_F_list[[i]][column+1])
  	
FleetList_simulation[[gtkComboBoxGetActive(combo_fleetsegments)+1]]@escape.survivability.DOS.ext_vect.F <<- get_table("ESCAPE_SURVIVABILITY_EXT_VECTOR_F")
  }
   } else {
    showError("Value for escape survivability rate for FEMALES must be a number!")
  }
}
