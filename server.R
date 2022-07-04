#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

library(car)    # Import library to use recode() function

shinyServer(function(input, output) {
  
  values <- reactiveValues()
  # Calculate the amount and interest
  observe({
    input$Calc
    values$int <- isolate({
      input$Loan_amt * input$int_rate *
        recode(input$durtn, "1 = '1'; 2 = '0.25'; 
               3 = '0.08333333'")/100 * input$time_period  
    })
    values$amt <- ({isolate(input$Loan_amt) + values$int
    })
    values$mthpay <- values$amt / (input$time_period * 12)
                     
    })
  
  # Display values entered
  output$text_Loan_amt <- renderText({
    input$Calc
    paste("Loan amount: [$]", isolate(input$Loan_amt))
  })
  
  output$text_int_rate <- renderText({
    input$Calc
    paste("Interest rate: ", isolate(input$int_rate), 
          " % per year")
  })
  
  output$text_time_period <- renderText({
    input$Calc
    paste("Duration: ", isolate(input$time_period),
          recode(isolate(input$select_time),
                 "1 = 'Years'; 2 = 'Quarters';3 = 'Months'")
    )
  })
  
  # Display calculated values
  
  output$text_intr <- renderText({
    if(input$Calc == 0) ""
    else
      paste("Interest [$]:", values$int)
  })
  
  output$text_amtplus <- renderText({
    if(input$Calc == 0) ""
    else 
      paste("Total Loan Amount, with Interest [$]:", values$amt)
  })
  
  output$text_mthpay <- renderText({
    if(input$Calc == 0) ""
    else 
      paste("Total Monthly Payment[$]:", values$mthpay)
  })
})
