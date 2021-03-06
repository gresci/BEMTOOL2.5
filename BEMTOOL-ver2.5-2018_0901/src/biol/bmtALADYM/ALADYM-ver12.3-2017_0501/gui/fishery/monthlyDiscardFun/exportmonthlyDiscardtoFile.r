# ALADYM  Age length based dynamic model - version 12.3
# Authors: G. Lembo, I. Bitetto, M.T. Facchini, M.T. Spedicato 2018
# COISPA Tecnologia & Ricerca, Via dei Trulli 18/20 - (Bari), Italy 
# In case of use of the model, the Authors should be cited.
# If you have any comments or suggestions please contact the following e-mail address: facchini@coispa.it
# ALADYM is believed to be reliable. However, we disclaim any implied warranty or representation about its accuracy, 
# completeness or appropriateness for any particular purpose.




exportmonthlyDiscardtoFile<-function(w) {
dialog <- gtkFileChooserDialog("Enter a name for the .csv file", main_window, "save", "gtk-cancel", GtkResponseType["cancel"], "gtk-save", GtkResponseType["accept"])
if (dialog$run() == GtkResponseType["accept"]) {

# save_selectivity_path = "C:\\FACCHINI_MT\\SOFTWARE COISPA\\under_construction\\BEMTOOL-ver_pre-beta\\saved_selectivity.csv"
save_monthlyDiscarddata_path <- dialog$getFilename()

vai <- T
dialog$destroy()
} else {
 vai <- F
dialog$destroy()
}

if (vai) {
gtkWidgetSetSensitive(main_window, FALSE)
wnd <- showMessage("        Saving monthly discard...        ")

all_monthlyDiscarddata <- data.frame(matrix(nrow=0, ncol=4 ))
colnames(all_monthlyDiscarddata) <- c("year",	"month",	"DISCARD",	"fleet_segment") 

monthlyDiscard_data <- get_discard_data()

for (fs in 1:length(FLEETSEGMENTS_names) ) {

#fs_object <- FleetList_simulation[[fs]]

monthlyDiscarddata_table <- data.frame(matrix(nrow=(length(years)*12)+1, ncol=4 ))
heading <-  c("year",	"month",	"DISCARD",	"fleet_segment") 
colnames(monthlyDiscarddata_table) <- heading

 years_rep <- rep(years, 12)
   years_rep <- years_rep[order(years_rep)]
   years_rep <- c("", years_rep)
   months_rep <- rep(MONTHS, length(years))
   months_rep <- c("seed", months_rep)
   monthlyDiscarddata_table$year <- years_rep
   monthlyDiscarddata_table$month <- months_rep
  monthlyDiscarddata_table$fleet_segment <- FLEETSEGMENTS_names[fs]
  
  monthlyDiscarddata_table$DISCARD <-  monthlyDiscard_data$Discard[monthlyDiscard_data$Gear == FLEETSEGMENTS_names[fs]]   
all_monthlyDiscarddata <- rbind(all_monthlyDiscarddata, monthlyDiscarddata_table)   
}

# all_monthlyDiscarddata$DISCARD <-  monthlyDiscard_data$Discard[1:(1+length(years)*12)]  
# all_monthlyDiscarddata$fleet_segment <- monthlyDiscard_data$Gear[1:(1+length(years)*12)]



#to_add <- data.frame(matrix(NA, nrow=nrow(selectivity_table), ncol=(5-selectivity_params$n_par)))
#selectivity_table <- cbind(selectivity_table, to_add)
#selectivity_table <- cbind(selectivity_table, rep(sel_type, nrow(selectivity_table)))
#selectivity_table <- cbind(selectivity_table, rep(FLEETSEGMENTS_names[fs], nrow(selectivity_table)))
#colnames(selectivity_table) <- c("year", "month", "param1", "param2", "param3", "param4", "param5", "sel_type", "fleet_segment") 
#all_selectivities <- rbind(all_selectivities, selectivity_table)
#}
write.table(all_monthlyDiscarddata, file=save_monthlyDiscarddata_path, sep=";", row.names=FALSE)

wnd$destroy()   
gtkWidgetSetSensitive(main_window, TRUE)
wnd <- showMessageOK("        Monthly discard saved!        ")
} 
}
