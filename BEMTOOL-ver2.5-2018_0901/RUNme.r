# BEMTOOL - Bio-Economic Model TOOLs - version 2.5
# Authors: G. Lembo, I. Bitetto, M.T. Facchini, M.T. Spedicato 2018
# COISPA Tecnologia & Ricerca, Via dei Trulli 18/20 - (Bari), Italy 
# In case of use of the model, the Authors should be cited.
# If you have any comments or suggestions please contact the following e-mail address: facchini@coispa.it
# BEMTOOL is believed to be reliable. However, we disclaim any implied warranty or representation about its accuracy, 
# completeness or appropriateness for any particular purpose.

## The easiest way to get ggplot2 is to install the whole tidyverse:
#install.packages("tidyverse")

if (!("ggplot2" %in% installed.packages()[,1])) {
    install.packages("ggplot2", dependencies = TRUE)
}

if (!("iterators" %in% installed.packages()[,1])) {
    install.packages("iterators", dependencies = TRUE)
}

if (!("ggplotFL" %in% installed.packages()[,1])) {
    install.packages(repos="http://flr-project.org/R", "ggplotFL", dependencies = TRUE)
}

if (!("FLCore" %in% installed.packages()[,1])) {
    install.packages(repos="http://flr-project.org/R", "FLCore", dependencies = TRUE)
}

if (!("gridExtra" %in% installed.packages()[,1])) {
    install.packages("gridExtra", dependencies = TRUE)
}

if (!("akima" %in% installed.packages()[,1])) {
    install.packages("akima", dependencies = TRUE)
}

if (!("stringr" %in% installed.packages()[,1])) {
    install.packages("stringr", dependencies = TRUE)
}

if (!("RGtk2" %in% installed.packages()[,1])) {
    install.packages("RGtk2", dependencies = TRUE)
}

if (!("Hmisc" %in% installed.packages()[,1])) {
    install.packages("Hmisc", dependencies = TRUE)
}

if (!("timeDate" %in% installed.packages()[,1])) {
    install.packages("timeDate", dependencies = TRUE)
}

if (!("reshape" %in% installed.packages()[,1])) {
    install.packages("reshape", dependencies = TRUE)
}

if (!("scales" %in% installed.packages()[,1])) {
    install.packages("scales", dependencies = TRUE)
}

