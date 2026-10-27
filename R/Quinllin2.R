library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(DT)
library(readr)

# 1. Carga e inicialización de los datos proporcionados
contenido_csv <- "codigo,nombre,ciudad,edad,asignatura,semestre,nota1,nota2
1001,Pedro Sanchez,Riobamba,20,Calculo,5,8.3,2.5
1002,Pedro Sanchez,Loja,19,Fisica,7,7.1,7.9
1003,Lucia Gomez,Riobamba,19,Estadistica,3,8.3,5.7
1004,Maria Diaz,Guayaquil,22,Algebra,2,2.2,8.7
1005,Elena Gomez,Cuenca,29,Calculo,8,3.3,7.1
1006,Luis Perez,Quito,26,Estadistica,4,4,1.1
1007,Ana Lopez,Quito,30,Estadistica,6,4.7,7.2
1008,Elena Martinez,Manta,27,Estadistica,5,6.7,9
1009,Diego Sanchez,Manta,30,Programacion,2,8.3,6.7
1010,Lucia Diaz,Cuenca,23,Programacion,7,3.3,2
1011,Luis Diaz,Guayaquil,27,Estadistica,3,8.4,9.3
1012,Pedro Diaz,Manta,27,Fisica,3,1.1,7.1
1013,Diego Martinez,Loja,23,Fisica,6,6.9,2.3
1014,Diego Gomez,Manta,29,Algebra,1,8.3,7.7
1015,Diego Perez,Cuenca,20,Calculo,6,5.2,9.5
1016,Pedro Rodriguez,Cuenca,21,Calculo,8,2.8,4.8
1017,Sofia Rodriguez,Quito,28,Fisica,3,1.2,3.7
1018,Lucia Sanchez,Ambato,28,Calculo,2,3.5,3.3
1019,Carlos Rodriguez,Guayaquil,20,Programacion,3,9.2,3
1020,Lucia Martinez,Riobamba,30,Fisica,8,9.4,6.1
1021,Diego Perez,Quito,24,Estadistica,3,5.9,7.8
1022,Pedro Garcia,Riobamba,20,Programacion,1,3,7
1023,Ana Gomez,Guayaquil,19,Algebra,6,5.4,5.9
1024,Juan Sanchez,Ambato,24,Estadistica,2,8.2,8.3
1025,Carlos Lopez,Manta,20,Fisica,2,4.7,7.8
1026,Luis Garcia,Quito,26,Calculo,8,1.9,1.2
1027,Lucia Gomez,Quito,30,Algebra,8,3.5,4.4
1028,Carlos Lopez,Quito,24,Algebra,2,4.3,1.5
1029,Diego Diaz,Manta,26,Calculo,4,3.3,8.2
1030,Diego Martinez,Riobamba,21,Calculo,6,5.2,9.3
1031,Lucia Perez,Loja,19,Calculo,1,4.3,5.9
1032,Carlos Diaz,Loja,23,Programacion,5,2.1,8.7
1033,Luis Rodriguez,Loja,27,Estadistica,7,1.4,6.3
1034,Carlos Gomez,Cuenca,29,Fisica,8,3.4,7
1035,Luis Gomez,Quito,26,Estadistica,5,9.7,5.6
1036,Elena Rodriguez,Guayaquil,29,Estadistica,3,5.4,7.9
1037,Diego Garcia,Guayaquil,30,Estadistica,7,5.3,9.1
1038,Maria Diaz,Quito,30,Fisica,6,7.7,8.4
1039,Luis Sanchez,Guayaquil,28,Fisica,8,7,1.6
1040,Sofia Sanchez,Quito,24,Estadistica,3,1.4,1
1041,Maria Rodriguez,Manta,30,Fisica,6,7.3,1.5
1042,Juan Garcia,Guayaquil,22,Calculo,5,4.3,8.8
1043,Diego Diaz,Cuenca,28,Estadistica,8,9,6.2
1044,Diego Diaz,Manta,18,Fisica,1,8,3.8
1045,Elena Sanchez,Riobamba,20,Calculo,4,2.3,9.6
1046,Luis Perez,Ambato,29,Programacion,8,3.7,6.3
1047,Diego Diaz,Manta,19,Estadistica,2,2.1,5.8
1048,Lucia Rodriguez,Guayaquil,22,Fisica,5,6.3,4.5
1049,Ana Diaz,Quito,18,Programacion,7,6.1,3.9
1050,Elena Perez,Ambato,29,Programacion,6,7.2,8.3
1051,Sofia Martinez,Loja,20,Fisica,8,3.8,1.4
1052,Elena Rodriguez,Guayaquil,26,Fisica,8,6.5,4.3
1053,Elena Rodriguez,Loja,19,Algebra,4,9.9,8.7
1054,Carlos Rodriguez,Riobamba,23,Programacion,6,7.7,7.3
1055,Juan Sanchez,Manta,20,Fisica,7,1.7,7.2
1056,Elena Garcia,Quito,20,Algebra,5,5.1,4.1
1057,Maria Lopez,Manta,26,Estadistica,8,1.5,6
1058,Juan Perez,Quito,19,Calculo,1,4.1,2.2
1059,Maria Rodriguez,Ambato,18,Algebra,2,7.6,8.1
1060,Ana Perez,Cuenca,23,Fisica,3,1,9
1061,Luis Garcia,Quito,27,Fisica,1,7.9,2.8
1062,Elena Gomez,Loja,25,Programacion,1,5.2,7.9
1063,Pedro Diaz,Quito,27,Estadistica,3,7.5,6.4
1064,Diego Sanchez,Guayaquil,27,Estadistica,7,7,9.6
1065,Ana Martinez,Ambato,30,Estadistica,2,6.1,2.4
1066,Elena Martinez,Guayaquil,21,Algebra,4,7.3,5.7
1067,Diego Lopez,Quito,23,Calculo,5,6.9,8.9
1068,Diego Perez,Manta,21,Algebra,8,3.6,8.8
1069,Carlos Martinez,Manta,30,Calculo,7,1.9,1.2
1070,Pedro Sanchez,Quito,21,Programacion,7,9.7,9.8
1071,Sofia Sanchez,Riobamba,26,Fisica,3,7.6,5.4
1072,Diego Garcia,Quito,25,Calculo,4,6.5,4.5
1073,Pedro Diaz,Manta,24,Calculo,5,2.1,4.8
1074,Carlos Rodriguez,Manta,27,Estadistica,3,6,1.8
1075,Pedro Diaz,Guayaquil,18,Algebra,7,3.4,2.5
1076,Carlos Lopez,Guayaquil,19,Programacion,1,9.1,4.6
1077,Elena Rodriguez,Riobamba,25,Estadistica,6,1.1,4.1
1078,Lucia Martinez,Loja,20,Estadistica,5,3.1,4.7
1079,Luis Martinez,Riobamba,27,Calculo,2,2.2,3.7
1080,Luis Sanchez,Manta,24,Algebra,4,3.9,6
1081,Sofia Martinez,Quito,28,Programacion,2,7.5,2.4
1082,Pedro Diaz,Quito,18,Fisica,1,9.9,9.6
1083,Lucia Gomez,Manta,29,Fisica,7,7.4,1.4
1084,Maria Martinez,Manta,19,Programacion,5,5.5,4.3
1085,Lucia Garcia,Ambato,20,Estadistica,6,4.9,9.7
1086,Maria Diaz,Riobamba,30,Fisica,2,9.5,6.8
1087,Lucia Diaz,Manta,30,Fisica,5,2.1,1.6
1088,Elena Lopez,Manta,20,Programacion,6,1.7,4.7
1089,Ana Garcia,Riobamba,23,Algebra,1,9,4.8
1090,Juan Diaz,Riobamba,27,Estadistica,8,4.8,5.6
1091,Elena Lopez,Ambato,22,Fisica,1,1.4,5
1092,Pedro Martinez,Guayaquil,21,Calculo,8,6.8,6.6
1093,Sofia Martinez,Manta,19,Estadistica,6,5.2,2.3
1094,Pedro Garcia,Quito,18,Calculo,2,6.6,9.2
1095,Sofia Gomez,Quito,29,Estadistica,8,3.4,6.1
1096,Juan Gomez,Guayaquil,18,Estadistica,6,2.4,5.9
1097,Carlos Lopez,Quito,29,Programacion,4,2,2.1
1098,Carlos Martinez,Guayaquil,22,Algebra,2,5.6,7.9
1099,Carlos Rodriguez,Manta,29,Fisica,8,5.9,5.3
1100,Lucia Lopez,Quito,19,Fisica,7,2.3,8"

# Procesar los datos y calcular la Nota Final promedio
datos_base <- read_csv(contenido_csv) %>%
  mutate(Nota_Final = round((nota1 + nota2) / 2, 2))

lista_asignaturas <- unique(datos_base$asignatura)

# 2. Interfaz de Usuario (UI)
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Rendimiento Académico"),

  dashboardSidebar(
    sidebarMenu(
      menuItem("Panel de Control", tabName = "panel", icon = icon("chart-bar")),
      menuItem("Tabla de Registros", tabName = "tabla_pestana", icon = icon("table"))
    ),
    selectInput("filtro_asignatura", "Filtrar por Asignatura:",
                choices = c("Todas", lista_asignaturas), selected = "Todas")
  ),

  dashboardBody(
    tabItems(
      # Pestaña Principal: Estadísticas
      tabItem(tabName = "panel",
              fluidRow(
                valueBoxOutput("kpi_promedio", width = 4),
                valueBoxOutput("kpi_aprobados", width = 4),
                valueBoxOutput("kpi_total", width = 4)
              ),
              fluidRow(
                box(title = "Distribución de Notas Finales", status = "primary", solidHeader = TRUE,
                    plotOutput("plot_histograma"), width = 6),
                box(title = "Nota Promedio por Ciudad", status = "warning", solidHeader = TRUE,
                    plotOutput("plot_barras_ciudad"), width = 6)
              ),
              fluidRow(
                box(title = "Edad vs Nota Final", status = "info", solidHeader = TRUE,
                    plotOutput("plot_dispersion_edad"), width = 12)
              )
      ),

      # Pestaña de la Tabla Completa
      tabItem(tabName = "tabla_pestana",
              fluidRow(
                box(title = "Base de Datos de Estudiantes", status = "primary", solidHeader = TRUE,
                    DTOutput("tabla_maestra"), width = 12)
              )
      )
    )
  )
)

# 3. Servidor (Server)
server <- function(input, output) {

  # Filtro reactivo basado en la selección del menú lateral
  datos_filtrados <- reactive({
    if (input$filtro_asignatura == "Todas") {
      datos_base
    } else {
      datos_base %>% filter(asignatura == input$filtro_asignatura)
    }
  })

  # KPI 1: Promedio de la Nota Final (Aprobación >= 7.0 estándar en Ecuador)
  output$kpi_promedio <- renderValueBox({
    media <- mean(datos_filtrados()$Nota_Final)
    valueBox(
      round(media, 2), "Nota Promedio General", icon = icon("graduation-cap"),
      color = if(media >= 7.0) "green" else "red"
    )
  })

  # KPI 2: Porcentaje de Alumnos Aprobados
  output$kpi_aprobados <- renderValueBox({
    porcentaje <- mean(datos_filtrados()$Nota_Final >= 7.0) * 100
    valueBox(
      paste0(round(porcentaje, 1), "%"), "Tasa de Aprobación (>= 7.0)",
      icon = icon("check-circle"), color = "teal"
    )
  })

  # KPI 3: Total de Alumnos Evaluados
  output$kpi_total <- renderValueBox({
    total_registros <- nrow(datos_filtrados())
    valueBox(
      total_registros, "Total Estudiantes",
      icon = icon("users"), color = "purple"
    )
  })

  # Gráfico 1: Histograma de Notas Finales
  output$plot_histograma <- renderPlot({
    ggplot(datos_filtrados(), aes(x = Nota_Final)) +
      geom_histogram(binwidth = 0.5, fill = "#605ca8", color = "white", alpha = 0.8) +
      geom_vline(xintercept = 7.0, linetype = "dashed", color = "darkred", size = 1) +
      labs(x = "Nota Final Promedio", y = "Número de Alumnos") +
      theme_minimal()
  })

  # Gráfico 2: Rendimiento Promedio por Ciudad
  output$plot_barras_ciudad <- renderPlot({
    resumen_ciudad <- datos_filtrados() %>%
      group_by(ciudad) %>%
      summarise(Media_Ciudad = mean(Nota_Final))

    ggplot(resumen_ciudad, aes(x = reorder(ciudad, -Media_Ciudad), y = Media_Ciudad)) +
      geom_bar(stat = "identity", fill = "#ff851b", alpha = 0.8) +
      labs(x = "Ciudad", y = "Nota Promedio") +
      theme_minimal()
  })

  # Gráfico 3: Relación entre Edad y Notas por Asignatura
  output$plot_dispersion_edad <- renderPlot({
    ggplot(datos_filtrados(), aes(x = edad, y = Nota_Final, color = asignatura)) +
      geom_point(size = 3, alpha = 0.7) +
      geom_smooth(method = "lm", se = FALSE, linetype = "dotted", color = "grey") +
      labs(x = "Edad del Estudiante", y = "Nota Final") +
      theme_minimal()
  })

  # Tabla Interactiva Completa
  output$tabla_maestra <- renderDT({
    datatable(datos_filtrados(), options = list(pageLength = 10, scrollX = TRUE))
  })
}
# 4. Inicializar Aplicación
shinyApp(ui = ui, server = server)
