
# settings:
# https://console.developers.google.com/apis/credentials/oauthclient/9662917876-u78pfn54f5efdbb895d7j8t2isaltj4c.apps.googleusercontent.com?project=9662917876






gar_set_client(web_json = "client_secret.json",
               scopes = c("https://www.googleapis.com/auth/userinfo.email",
                          "https://www.googleapis.com/auth/userinfo.profile"), 
               activate = "web")

ui <- navbarPage(
  title = "App Name",
  windowTitle = "Browser window title",
  tabPanel("Tab 1",
           useShinyjs(),
           sidebarLayout(
             sidebarPanel(
               p("Welcome!"),
               googleAuthUI("gauth_login")
             ),
             mainPanel(
               textOutput("display_username")
             )
           )
  ),
  tabPanel("Tab 2",
           p("Layout for tab 2")
  )
)

server <- function(input, output, session) {
  ## Global variables needed throughout the app
  rv <- reactiveValues(
    login = FALSE
  )
  
  ## Authentication
  accessToken <- callModule(googleAuth, "gauth_login",
                            login_class = "btn btn-primary",
                            logout_class = "btn btn-primary")
  userDetails <- reactive({
    validate(
      need(accessToken(), "not logged in")
    )
    rv$login <- TRUE
    with_shiny(get_user_info, shiny_access_token = accessToken())
  })
  
  ## Display user's Google display name after successful login
  output$display_username <- renderText({
    validate(
      need(userDetails(), "getting user details")
    )
    userDetails()$displayName
  })
  
  ## Workaround to avoid shinyaps.io URL problems
  observe({
    if (rv$login) {
      shinyjs::onclick("gauth_login-googleAuthUi",
                       shinyjs::runjs("window.location.href = 'https://sethsa.shinyapps.io/covid-home-care';"))
    }
  })
}
