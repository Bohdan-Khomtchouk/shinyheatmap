# Copyright (C) 2016 Bohdan Khomtchouk

# This file is part of shinyheatmap.

# ------------------------------------------------------------------------------------

library(shiny)
library(gplots)
library(heatmaply)
library(tools)


# frontend
ui <- shinyUI(pageWithSidebar(
  headerPanel("shinyheatmap"),
  sidebarPanel(
    helpText(a("Click Here for the Source Code on Github!", href = "https://github.com/Bohdan-Khomtchouk/Microscope", target = "_blank")),
    downloadButton("downloadData", label = "Download Sample Input File"),
    fileInput("filename", "Choose File to Upload:", accept = c('.csv')),
    selectInput("lowColor", "Low Value:", c("green", "blue", "purple", "red", "orange", "yellow")),
    selectInput("highColor", "High Value:", c("red", "orange", "yellow", "green", "blue", "purple")),    
    selectInput("dendrogram", "Apply Clustering:", c("none", "row", "column", "both")),
    selectInput("scale", "Apply Scaling:", c("row", "column", "none")),
    selectInput("key", "Color Key:", c("TRUE", "FALSE")),    
    selectInput("trace", "Make Trace:", c("none", "column", "row", "both")),
    sliderInput("xfontsize", "Choose Y Font Size:", min = 0.3, max = 2, value = 0.5),
    sliderInput("yfontsize", "Choose X Font Size:", min = 0.3, max = 2, value = 0.72),
    downloadButton("downloadHeatmap", "Download Heatmap")
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Instructions", textOutput("text1"), img(src='excel.png'), textOutput("text2"), textOutput("text3"), textOutput("text4")),
      tabPanel("Static Heatmap", plotOutput("static", height = "600px")),
      tabPanel("Interactive Heatmap", plotOutput("interactive"))
	  ) 
  )
  ))
