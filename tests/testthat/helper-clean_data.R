# function input for tests
empty_df  <- data.frame()

good_df <- data.frame( 
    shares = c(593, 711, 1500),
    num_hrefs = c(4, 3, 3),
    num_imgs = c(1, 1, 1),
    num_videos = c(0, 0, 0),
    max_negative_polarity = c(-0.2, -0.1 , -0.133333333))


without_shares_df <- data.frame(
    num_imgs = c(1, 1, 1),
    num_videos = c(0, 0, 0),
    max_negative_polarity = c(-0.2, -0.1 , -0.133333333))


without_num_hrefs_num_imgs_df <- data.frame( 
    shares = c(593, 711, 1500),
    num_hrefs = c(4, 3, 3),
    num_videos = c(0, 0, 0),
    max_negative_polarity = c(-0.2, -0.1 , -0.133333333))

list_wrong_type <- list(
    shares = c(593, 711, 1500),
    num_hrefs = c(4, 3, 3),
    num_imgs = c(1, 1, 1),
    num_videos = c(0, 0, 0),
    max_negative_polarity = c(-0.2, -0.1 , -0.133333333))


# expected function output

 check_popular_value <- data.frame( 
    shares = c(593, 711, 1500),
    num_hrefs = c(4, 3, 3),
    num_imgs = c(1, 1, 1),
    num_videos = c(0, 0, 0),
    is_popular = as.factor(c(0, 0, 1)))




