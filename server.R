
function(input, output) {
  
  filterData = reactive({
    
    testData %>%
      filter(Directorate2 == input$directorate)
  })
  
  returnBestTable = reactive({
    
    tidy_comments = filterData() %>%
      filter(!is.na(Best)) %>%
      unnest_tokens(word, Best)
    
    tidy_comments <- tidy_comments %>%
      anti_join(stop_words)
    
    tidy_comments %>%
      count(word, sort = TRUE) %>%
      slice(1:10) %>%
      as.data.frame
  })
   
  output$bestComments <- renderDataTable({

    datatable(
      returnBestTable(),
      selection = "single"
    )
  })
  
  output$bestText = renderText({
    
    validate(
      need(input$bestComments_rows_selected, "")
      )
    
    returnBestTable() %>%
      slice(input$bestComments_rows_selected) %>%
      pull(word)
  })
  
  output$improveComments <- renderDataTable({

    tidy_comments = filterData() %>%
      filter(!is.na(Improve)) %>%
      unnest_tokens(word, Improve)
    
    tidy_comments <- tidy_comments %>%
      anti_join(stop_words)
    
    tidy_comments %>%
      count(word, sort = TRUE) %>%
      slice(1:10) %>%
      as.data.frame
  })
}
