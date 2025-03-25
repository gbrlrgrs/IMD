function(input, output, session) {
  # Run reactive code when button is clicked
  imd <- eventReactive(input$process, {  
    tblIMD %>%
      filter(str_starts(pcds, str_to_upper(input$PC))) %>%
      mutate(xx = ifelse(imd==0,
                         paste0("No IMD available for ", pcds),
                         paste0(cntry, " IMD decile for ", pcds, ' = ', dec))) %>% 
      pull(xx) %>%
      as.character()
  })
  
  output$IMD <- renderText({
    paste(imd(), collapse = "\n")
  })
}
