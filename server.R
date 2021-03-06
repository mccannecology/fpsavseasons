# server.R

source("helpers.R")

shinyServer(function(input, output) {
 
  ###############################
  # Determine simulation number #  
  ###############################  
  # assign user inputs to a data.frame (1 row)
  row_to_match <- reactive({
    
    # combine user-inputs into a row 
    # make a list, then convert to a data frame 
    as.data.frame(list(TOTALN = input$TOTALN,
                       initial_perc_FP_cover = input$initial_perc_FP_cover,
                       initial_perc_SAV_cover = input$initial_perc_SAV_cover,
                       days = input$days))
        
  })
  
  # simulation number will be sent to the output 
  # (Not sure if this is necessary)
  output$simulation <- renderText({
    row_to_match <- row_to_match() 
    row.match(row_to_match, data, nomatch = NA) 
  })
  
  # simulation number is a reactive object 
  # that can be used by other functions below
  # just follow "sim_numb" with () - e.g., sim_numb()
  sim_numb <- renderText({
    row_to_match <- row_to_match() 
    row.match(row_to_match, data, nomatch = NA) 
  })
  
  ###########################################
  # Assign reactive inputs to the variables #
  ###########################################
  # Use to get the right path / filename for alt. state trajectories
  TOTALN <- reactive({
    input$TOTALN
  })
  
  days <- reactive({
    input$days
  })
    
  ###########
  # COVER #
  ###########
  # if images are saved locally
  #output$cover <- renderImage({
    
    # When input$simulation is 3, filename is ./www/3/cover.jpg
    #filename <- file.path('./www',paste(sim_numb(),"/cover.jpg", sep=""))
    
    # Return a list containing the filename and alt text
    #list(src = filename, contentType = "image/jpg")
    
  #}, deleteFile = FALSE)
  
  # if images are stored remotely 
  output$cover <- renderImage({
  
    # URL varies depending on input 
    url <- paste("https://s3.amazonaws.com/fpsavseasons/",sim_numb(),"/cover.jpg",sep="")
    
    download(url,"cover.jpg",mode="wb")
    
    filename <- normalizePath(file.path('./',paste('cover','.jpg', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename)
  
  }, deleteFile = FALSE)
  
  ###########
  # INITIAL #
  ###########
  # if images are saved locally
  # output$initial <- renderImage({
  
    # When input$simulation is 3, filename is ./www/3/initial.jpg
    # filename <- file.path('./www',paste(sim_numb(),"/initial.jpg", sep=""))
    
    # Return a list containing the filename and alt text
    # list(src = filename, contentType = "image/jpg")
    
  # }, deleteFile = FALSE)
  
  # if images are stored remotely 
  output$initial <- renderImage({
    
    # URL varies depending on input 
    url <- paste("https://s3.amazonaws.com/fpsavseasons/",sim_numb(),"/initial.jpg",sep="")
    
    download(url,"initial.jpg",mode="wb")
    
    filename <- normalizePath(file.path('./',paste('initial','.jpg', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename)
    
  })
  
  ##########
  # MIDDLE #
  ##########
  # if images are saved locally
  # output$middle <- renderImage({
    
    # When input$simulation is 3, filename is ./www/3/middle.jpg
    # filename <- file.path('./www',paste(sim_numb(),"/middle.jpg", sep=""))
    
    # Return a list containing the filename and alt text
    # list(src = filename, contentType = "image/jpg")
    
  # }, deleteFile = FALSE)
  
  # if images are stored remotely 
  output$middle <- renderImage({
  
    # URL varies depending on input 
    url <- paste("https://s3.amazonaws.com/fpsavseasons/",sim_numb(),"/middle.jpg",sep="")
    
    download(url,"middle.jpg",mode="wb")
    
    filename <- normalizePath(file.path('./',paste('middle','.jpg', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename)
  
  })
  
  #########
  # FINAL #
  #########
  # if images are saved locally
  # output$final <- renderImage({
    
    # When input$simulation is 3, filename is ./www/3/final.jpg
    # filename <- file.path('./www',paste(sim_numb(),"/final.jpg", sep=""))
    
    # Return a list containing the filename and alt text
    # list(src = filename, contentType = "image/jpg")
    
  # }, deleteFile = FALSE)
  
  # if images are stored remotely 
  output$final <- renderImage({
  
    # URL varies depending on input 
    url <- paste("https://s3.amazonaws.com/fpsavseasons/",sim_numb(),"/final.jpg",sep="")
    
    download(url,"final.jpg",mode="wb")
    
    filename <- normalizePath(file.path('./',paste('final','.jpg', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename)
  
  })
  
  #############
  # NUTRIENTS #
  #############
  # if images are saved locally
  # output$nutrients <- renderImage({
    
    # When input$simulation is 3, filename is ./www/3/nutrients.jpg
    # filename <- file.path('./www',paste(sim_numb(),"/nutrients.jpg", sep=""))
    
    # Return a list containing the filename and alt text
    # list(src = filename, contentType = "image/jpg")
    
  # }, deleteFile = FALSE)
  
  # if images are stored remotely 
  output$nutrients <- renderImage({
  
    # URL varies depending on input 
    url <- paste("https://s3.amazonaws.com/fpsavseasons/",sim_numb(),"/nutrients.jpg",sep="")
  
    download(url,"nutrients.jpg",mode="wb")
  
    filename <- normalizePath(file.path('./',paste('nutrients','.jpg', sep='')))
  
    # Return a list containing the filename and alt text
    list(src = filename)
  
  })
  
  #############
  # ALT STATE #
  #############
  # if images are saved locally
  # output$AltStatePlot <- renderImage({
    
    #filename <- file.path('./www',paste(sim_numb(),"/nutrients.jpg", sep=""))
    
    # Uses all user inputs (excel intial FP and SAV) to find plot location / name 
    # filename <- file.path('./www/AltState/',paste("alt_plot_","_",
                                                  #TOTALN(),"_",
                                                  #shadingbyFP(),"_",
                                                  #size(),"_",
                                                  #shape(),"_",
                                                  #wind_direction(),"_",
                                                  #wind_shape2(),"_",
                                                  #".jpg", sep=""))
    
    # Return a list containing the filename and alt text
    #list(src = filename, contentType = "image/jpg")
    
  #}, deleteFile = FALSE)
  
  # if images are stored remotely 
  output$AltStatePlot <- renderImage({
  
    # URL varies depending on input 
    url <- paste("https://s3.amazonaws.com/fpsavseasons/AltState/",
                 "alt_states_plot_",
                 TOTALN(),"_",
                 days(),"_",
                 ".jpg",sep="")
    
    download(url,"altstate.jpg",mode="wb")
    
    filename <- normalizePath(file.path('./',paste('altstate','.jpg', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename,
         height=500,
         width=500)
  
  })
  
  ######################
  # IMAGES FOR WELCOME # 
  ######################
  # PICTURE OF FP-SAV STATES 
  # if images are saved locally
  output$alt_states <- renderImage({
  
  filename <- file.path("./www/alt_states.jpg")
  
  # Return a list containing the filename and alt text
  list(src = filename, contentType = "image/jpg")
  
  }, deleteFile = FALSE)
  
})