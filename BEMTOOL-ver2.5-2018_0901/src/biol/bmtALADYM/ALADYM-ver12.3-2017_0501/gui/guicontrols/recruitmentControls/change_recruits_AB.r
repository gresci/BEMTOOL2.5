# ALADYM  Age length based dynamic model - version 12.3
# Authors: G. Lembo, I. Bitetto, M.T. Facchini, M.T. Spedicato 2018
# COISPA Tecnologia & Ricerca, Via dei Trulli 18/20 - (Bari), Italy 
# In case of use of the model, the Authors should be cited.
# If you have any comments or suggestions please contact the following e-mail address: facchini@coispa.it
# ALADYM is believed to be reliable. However, we disclaim any implied warranty or representation about its accuracy, 
# completeness or appropriateness for any particular purpose.





change_recruits_AB <-function(w){
          gtkWidgetSetSensitive(lbl_A_recruits, TRUE)
          gtkWidgetSetSensitive(entryOFFSPRING_rand_a, TRUE)
          gtkWidgetSetSensitive(lbl_B_recruits, TRUE)
          gtkWidgetSetSensitive(entryOFFSPRING_rand_b, TRUE)

  select_index = -1
  selected <- gtkComboBoxGetActiveText(combo_OFFSPRING_rand)
select_index <- which(DISTRIBUTION == selected )          #DISTRIBUTION <- c("Lognormal","Gamma","Normal","Uniform")
# print(paste("Selected element: ", selected, "[",select_index,"]", sep=""))

      if (select_index == 1) {
          lbl_A_recruits_txt <- "Mean ln(x)"
          lbl_B_recruits_txt <- "Ds ln(x)"
      } else if (select_index == 2) {
          lbl_A_recruits_txt <- "Shape"
          lbl_B_recruits_txt <- "Scale"
      } else if (select_index == 3) {
          lbl_A_recruits_txt <- "Mean (x)"
          lbl_B_recruits_txt <- "Ds (x)"
      } else {
          gtkWidgetSetSensitive(lbl_A_maturityogive_L50_M, FALSE)
          gtkWidgetSetSensitive(entryOFFSPRING_rand_a, FALSE)
          gtkWidgetSetSensitive(lbl_B_maturityogive_L50_M, FALSE)
          gtkWidgetSetSensitive(entryOFFSPRING_rand_b, FALSE)
          lbl_A_recruits_txt <- "A"
          lbl_B_recruits_txt <- "B"
      }  
gtkLabelSetText(lbl_A_recruits, lbl_A_recruits_txt)
gtkLabelSetText(lbl_B_recruits, lbl_B_recruits_txt)
}