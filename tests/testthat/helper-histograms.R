# function input for tests
empty_df  <- data.frame()

good_df <- data.frame( 
    shares = c(593, 711, 1500),
    num_hrefs = c(4, 3, 3),
    num_imgs = c(1, 1, 1),
    num_videos = c(0, 0, 0))

list_wrong_type <- list(
    shares = c(593, 711, 1500),
    num_hrefs = c(4, 3, 3),
    num_imgs = c(1, 1, 1),
    num_videos = c(0, 0, 0),
    max_negative_polarity = c(-0.2, -0.1 , -0.133333333))

num_images <- 5
