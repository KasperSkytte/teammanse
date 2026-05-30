library(shiny)

quiz_data <- list(
  list(q = "Hvad er svaret på alt?", p = "42|toogfyrre"),
  list(q = "Hvorfor blev der skrevet artikler om os i 1.G?", p = "varmluft|ballon|luftballon"),
  list(q = "Ved hvilken underviser var vi nødt til at evakuere lokalet?", p = "erik|fysik"),
  list(q = "Hvilken scorereplik blev brugt hyppigt i gymnasiet?", p = "svømning"),
  list(q = "Hvad fik man at spise hvis man bestilte nr. 24b på Café Istanbul?", p = "(?=.*bearnaise)(?=.*banan)(?=.*pizza)"),
  list(q = "Hvad udfordrede afleveringen af SRP i 3.G?", p = "snestorm"),
  list(q = "Hvad var kælenavnet på vores kemilærer?", p = "(?=.*doktor)(?=.*død)")
)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      body { background-color: #f8f9fa; }
      .quiz-container { max-width: 600px; margin: 50px auto; padding: 30px; background: white; border-radius: 15 overlap; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
      .question-text { font-size: 24px; font-weight: bold; margin-bottom: 20px; color: #333; }
      .score-text { font-size: 30px; color: #2c3e50; text-align: center; }
    "))
  ),
  
  fluidRow(
    column(12,
           div(class = "quiz-container",
               uiOutput("quiz_ui")
           )
    )
  )
)

server <- function(input, output, session) {
  
  current_idx <- reactiveVal(1)
  score <- reactiveVal(0)
  quiz_finished <- reactiveVal(FALSE)
  
  observeEvent(input$next_btn, {
    user_answer <- input$answer_input
    clean_user_answer <- tolower(user_answer)
    current_pattern <- quiz_data[[current_idx()]]$p
    
    if (grepl(current_pattern, clean_user_answer, perl = TRUE)) {
      score(score() + 1)
    }
    
    if (current_idx() < length(quiz_data)) {
      current_idx(current_idx() + 1)
    } else {
      quiz_finished(TRUE)
    }
  })
  
  observeEvent(input$reset_btn, {
    current_idx(1)
    score(0)
    quiz_finished(FALSE)
  })

  output$quiz_ui <- renderUI({
    if (!quiz_finished()) {
      tagList(
        div(class = "question-text", quiz_data[[current_idx()]]$q),
        textInput("answer_input", label = "Dit svar:", value = ""),
        br(),
        actionButton("next_btn", "Næste spørgsmål", class = "btn-primary btn-lg", width = "100%")
      )
    } else {
      tagList(
        div(class = "score-text", "Quiz færdig!"),
        hr(),
        div(style = "font-size: 40px; font-weight: bold;", paste0(score(), " / ", length(quiz_data))),
        if(score() <= 3)
          p("Det var noget lort!")
        else if(score() <= 6)
          p("Flot!")
        else if(score() == 7)
          p("Perfekt!"),
        p("Vi mødes på hej 32 9600 Aars", style = "text-align: center;"),
        br(),
        actionButton("reset_btn", "Prøv igen", class = "btn-default")
      )
    }
  })
}

shinyApp(ui, server)