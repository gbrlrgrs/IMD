fluidPage(
  useShinyjs(),
  
  div(
    style = "display: flex; align-items: center; gap: 10px;",
    textInput("PC", "Enter Postcode:", "", 
              placeholder = "Type full or partial postcode..."),
    actionButton("process", "Get IMD")
  ),
  
  tags$p(tags$strong("IMD Results (1 = most deprived; 10 = least deprived):")),  # Label for the output
  verbatimTextOutput("IMD"),  # Output box
  
  # Notes with hyperlinks
  tags$p("Source data: ",
         tags$a("National Statistics Postcode Lookup (February 2025) for the UK", href = "https://geoportal.statistics.gov.uk/datasets/525b74a332c84146add21c9b54f5ce68/about", target = "_blank"),
         tags$br(),
         "Details of each country's IMD: ",
         tags$a("England", href = "https://www.gov.uk/government/statistics/english-indices-of-deprivation-2019", target = "_blank"),
         ", ",
         tags$a("Wales", href = "https://statswales.gov.wales/Catalogue/Community-Safety-and-Social-Inclusion/Welsh-Index-of-Multiple-Deprivation", target = "_blank"),
         ", ",
         tags$a("Scotland", href = "https://www.gov.scot/collections/scottish-index-of-multiple-deprivation-2020/", target = "_blank"),
         " (Scotland wins for having the best documentation), ",
         tags$a("Northern Ireland", href = "https://www.nisra.gov.uk/statistics/deprivation/northern-ireland-multiple-deprivation-measure-2017-nimdm2017", target = "_blank")
  ),
  
  tags$script(HTML("
    $(document).on('keypress', function(e) {
      if (e.which == 13) {  
        $('#process').click();
      }
    });
  "))
)