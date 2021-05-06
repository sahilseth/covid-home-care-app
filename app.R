#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


install <- function(){
    
    install.packages("remotes")
    install.packages("pacman")
    remotes::install_github("RinteRface/shinyMobile")
    remotes::install_github("RinteRface/charpente")
    
    
    # google login:
    # https://lmyint.github.io/post/shiny-app-with-google-login/
    install.packages(c("googleAuthR", "shinyjs"))
    remotes::install_github("MarkEdmondson1234/googleID")
    remotes::install_github("MarkEdmondson1234/googleAuthR")
    
    
}



library(pacman)

# install()
# p_load(shiny)
# p_load(shinyMobile, shinyWidgets)
# p_load(charpente)
# p_load(googleAuthR, shinyjs, googleID)
# p_load(apexcharter)

# cant install: https://stackoverflow.com/questions/47891749/facing-issue-while-installing-packages-into-library-in-shinyapp-io
library(shiny)
library(shinyMobile)
library(shinyWidgets)
library(shinyjs)
library(charpente)
library(googleAuthR)
library(googleID)
library(apexcharter)


# google_auth()
source('google-auth-ex.R')

# Run the application 
shinyApp(ui = ui, server = server)




