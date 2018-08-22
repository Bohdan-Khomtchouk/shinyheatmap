# Copyright (C) 2016-2018 Bohdan Khomtchouk

# This file is part of shinyheatmap.

# ------------------------------------------------------------------------------------

library(shiny)
library(data.table)
library(gplots)
library(heatmaply)
library(tools)


# frontend
ui <- shinyUI(pageWithSidebar(
  headerPanel(h1("shinyheatmap", style = "font-family: 'Cyborg', cursive; font-weight: 500; line-height: 1.1; color: #FF0000;")),
  sidebarPanel(
    img(src = 'shinyheatmap_logo.png', align = "left", width = "50%", height = "50%"),
    downloadButton("downloadSmallData", label = "Download Small Input Sample File"),
    downloadButton("downloadMidData", label = "Download Mid-Sized Input Sample File"),
    downloadButton("downloadHugeData", label = "Download Huge Input Sample File"),
    fileInput("filename", "Choose File to Upload:", accept = c('.csv')),
    selectInput("lowColor", "Low Value:", c("green", "blue", "purple", "red", "orange", "yellow", "white", "black")),
    selectInput("midColor", "Mid Value:", c("none", "black", "green", "blue", "purple", "red", "orange", "yellow", "white")),
    selectInput("highColor", "High Value:", c("red", "orange", "yellow", "green", "blue", "purple", "orange", "white", "black")),    
    selectInput("dendrogram", "Apply Clustering:", c("none", "row", "column", "both")),
    #selectInput("correlationCoefficient", "Distance Metric (Option A):", c("pearson", "kendall", "spearman")),
    selectInput("distanceMethod", "Distance Metric:", c("euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski")),
    selectInput("agglomerationMethod", "Linkage Algorithm:", c("complete", "single", "average", "centroid", "median", "mcquitty", "ward.D", "ward.D2")),
    selectInput("scale", "Apply Scaling:", c("row", "column", "none")),
    selectInput("key", "Color Key:", c("TRUE", "FALSE")),    
    selectInput("trace", "Make Trace:", c("none", "column", "row", "both")),
    sliderInput("xfontsize", "Choose Y Font Size:", min = 0.3, max = 2, value = 0.5),
    sliderInput("yfontsize", "Choose X Font Size:", min = 0.3, max = 2, value = 0.72),
    downloadButton("downloadHeatmap", "Download Heatmap"),
    downloadButton("downloadClusteredInput", "Download Clustered Input File"),
    helpText(a("View shinyheatmap publication!", href = "http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0176334", target = "_blank")),
    helpText(a("View source code on Github!", href = "https://github.com/Bohdan-Khomtchouk/shinyheatmap", target = "_blank"))
  ),
  
  mainPanel(
    tags$head(includeScript("google-analytics.js")),
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: hidden; }"
    ),
    tabsetPanel(
      tabPanel("Instructions", textOutput("text1"), img(src='excel.png'), textOutput("text2"), textOutput("text3"), img(src='benchmarks.png', width="80%", height="80%"), textOutput("text4"), textOutput("text5")),
      tabPanel("Static Heatmap", uiOutput(outputId = "image"), uiOutput("sorry"), plotOutput("static", height = "600px")),
      tabPanel("Interactive Heatmap", uiOutput(outputId = "image2"), uiOutput("sorry2"), plotlyOutput("interactive", height = "700px"))
    ) 
  )
))