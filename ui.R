
library(shiny)

shinyUI(fluidPage(
  titlePanel("Loan Calculator"),
  sidebarLayout(
    sidebarPanel(
      helpText("This app computes monthly payment 
               based on your inputs."),            
      br(),            
      numericInput("Loan_amt",
                   label = h6("Enter the loan amount (in $)"),
                   value = 5000),
      br(),            
      sliderInput("int_rate",
                  label = h6("Indicate the interest rate (in %)"),
                  min = 0, max = 25, value = 7),
      
      br(),            
      sliderInput("time_period",
                  label = h6("Select the loan duration"),
                  min = 0, max = 120, value = 7),
      selectInput("durtn",
                  label = h6(""),
                  choices = list("Years" = 1,
                                 "Quarters" = 2,
                                 "Months" =3),
                  selected = 1 
      ), 
      br(),
      br(),            
      actionButton("Calc", label = "Calculate!")        
      ),
    mainPanel(
      tabsetPanel(
        tabPanel("Output",
                 p(h5("Values you entered:")),
                 textOutput("text_Loan_amt"),
                 textOutput("text_int_rate"),
                 textOutput("text_time_period"),
                 textOutput("text_duration"),
                 br(),
                 p(h5("Calculated amount:")),
                 textOutput("text_intr"),
                 textOutput("text_amtplus"),
                 textOutput("text_mthpay")
        ),
        tabPanel("Documentation",
                 p(h4("Loan Calculator:")),
                 br(),
                 helpText("This application computes monthly payment of loan after sum up with interest"),
                    HTML("<u><b>Calculation's Equation : </b></u>
                        <br> <br>
                        <b> A = P + I = P(1 + rt) ; R = r * 100 </b>
                        <br>
                        where: <br>
                        A = Total amount (Loan + Interest) <br>
                        P = Loan amount <br>
                        I = Interest <br>
                        r = Interest rate per year, in decimal<br>
                        t = Duration in years/quarters/months
                    ")                
        )
      )
    )
  )
))