#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),

    # Your application UI logic
    navbarPage(
      title = img(src = "www/interact-logo.png", height = 60),


      tabPanel('About', mod_about_ui('about')),
      tabPanel('Interactive Map', mod_map_ui('map')),
      tabPanel('Dashboard'),
      tags$footer(class = "footer",
                      div(class = "row",
                          div(class = "container-left",

                              a(href="http://www.link-to-logo-1.com", img(src="www/tuos-logo.png", height="42")),

                              a(href="http://www.link-to-logo-2.com", img(src="www/madesmarter-logo.png", height="42")),

                              a(href="http://www.link-to-logo-3.com", img(src="www/strathclyde-logo.png", height="42")),

                              a(href="http://www.link-to-logo-3.com", img(src="www/ukri-logo.png", height="42")),

                              a(href="http://www.link-to-logo-3.com", img(src="www/loughborough-logo.png", height="42"))

                      ),
                      div(class = "container-right",
                          includeHTML(here::here('inst/app/www/social-svg.html'))
                          )
                  )
      )

 # end of footer code



    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "interactgolem"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
