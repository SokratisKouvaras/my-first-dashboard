server <- function(input,output,session){
  
  filtered_df <- reactive({
    if (input$variable=="all"){
      res <- data3
    }
    else{
      res <- data3[data3$RegistrationMethod == input$variable, ]
    }
    if (input$attedance_time=="all"){
      res <- res
    }
    else{
      res <- res[res$AttendanceState == input$attedance_time, ]
      
    }
    res
  })
  
  output$table <- DT::renderDataTable({
    
    DT::datatable(
      data3,
      filter = 'top', extensions = c('Buttons', 'Scroller'),
      options = list(scrollY = 500,
                     scrollX = 500,
                     deferRender = TRUE,
                     scroller = FALSE,
                     paging = TRUE,
                     pageLength = 50,
                     buttons = list(list(extend = 'colvis', targets = 0, visible = FALSE)),
                     dom = 'lBfrtip',
                     fixedColumns = TRUE), 
      rownames = FALSE)
  })
  
  output$time_series <- renderPlot({
    ggplot(filtered_df(),aes(x=filtered_df()[,8],color=data3$AttendanceState)) + 
      geom_bar(color="#86BC25",fill="steelblue") + 
      theme(axis.text.x = element_text(angle=45, hjust = 1)) + 
      labs(x = "Registration Day") + 
      scale_x_date(date_labels = "%d-%m-%Y",breaks='7 days')
  })
  
  output$word_cloud_companies <-renderPlot({
    
    if(input$attedance == "both"){
      tempCompanies <- as.data.frame(xtabs(~ CompanyClass , data =data3))
    }else{
      tempCompanies <- as.data.frame(xtabs(~ CompanyClass , data = data3[data3$AttendanceState == input$attedance, ]))
    }
    response <- tempCompanies[tempCompanies$Freq >= input$no_of_companies, ]
    
    
    ggplot(response, 
           aes(
             label = CompanyClass,size = Freq,
             color = factor(sample.int(10, nrow(response), replace = TRUE)),)) +
      geom_text_wordcloud(shape ="circle") +
      theme_minimal()
    
  })
  
  output$word_cloud_job_functions <-renderPlot({
    
    temp <- as.data.frame(xtabs(~ JobFunctionClass , data = data3))
    
    ggplot(temp, 
           aes(
             label = JobFunctionClass,size = Freq,
             color = factor(sample.int(10, nrow(temp), replace = TRUE)),)) +
      geom_text_wordcloud(shape ="circle") + 
      theme_minimal()
    
  })
  
  output$histogram <- renderPlot({
    
    if (input$attedance_job_function=="all"){
      
      filtered_data<-data3
      
    }else{
      
      filtered_data <- data3[data3$AttendanceState == input$attedance_job_function,]
      
    }
    
    ggplot(filtered_data,aes(x=filtered_data[,15])) + 
      geom_bar(color="#86BC25",fill="steelblue") + 
      labs(x = "Job Function") + 
      theme(axis.text.x = element_text(angle=45, hjust = 1))
  })
  
  output$no_of_participants <- renderText({ nrow(data3) })
  
  output$org_name <- renderText({unique(data3[,2])}) 
}
