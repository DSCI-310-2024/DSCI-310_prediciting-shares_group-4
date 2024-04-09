# function input for tests
library(tidyverse)
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

str_wrong_type <- "shares = 593, num_hrefs = 4, num_imgs = 1, num_videos =0 "

null_df <- data.frame(
    shares = c(593, 711, 1500),
    num_hrefs = c(4, NA, 3),
    num_imgs = c(1, 1, 1),
    num_videos = c(0, 0, 0),
    max_negative_polarity = c(-0.2, -0.1 , -0.133333333))

real_data_with_2_rows <- data.frame(
  url = c("http://mashable.com/2013/01/07/amazon-instant-video-browser/", "http://mashable.com/2013/01/07/ap-samsung-sponsored-tweets/"),
  timedelta = c(731, 731),
  n_tokens_title = c(12, 9),
  n_tokens_content = c(219, 255),
  n_unique_tokens = c(0.663594467, 0.604743081),
  n_non_stop_words = c(0.999999992, 0.999999993),
  n_non_stop_unique_tokens = c(0.815384609, 0.791946303),
  num_hrefs = c(4, 3),
  num_self_hrefs = c(2, 1),
  num_imgs = c(1, 1),
  num_videos = c(0, 0),
  average_token_length = c(4.680365297, 4.91372549),
  num_keywords = c(5, 4),
  data_channel_is_lifestyle = c(0, 0),
  data_channel_is_entertainment = c(1, 0),
  data_channel_is_bus = c(0, 1),
  data_channel_is_socmed = c(0, 0),
  data_channel_is_tech = c(0, 0),
  data_channel_is_world = c(0, 0),
  kw_min_min = c(0, 0),
  kw_max_min = c(0, 0),
  shares = c(593, 711)
)

real_data_2rows_34<- data.frame(
  url = c("http://mashable.com/2013/01/07/apple-40-billion-app-downloads/",
          "http://mashable.com/2013/01/07/astronaut-notre-dame-bcs/"),
  timedelta = c(731, 731),
  n_tokens_title = c(9, 9),
  n_tokens_content = c(211, 531),
  n_unique_tokens = c(0.575129531, 0.503787878),
  n_non_stop_words = c(0.999999992, 0.999999997),
  n_non_stop_unique_tokens = c(0.663865541, 0.665634673),
  num_hrefs = c(3, 9),
  num_self_hrefs = c(1, 0),
  num_imgs = c(1, 1),
  num_videos = c(0, 0),
  average_token_length = c(4.393364929, 4.404896422),
  num_keywords = c(6, 7),
  data_channel_is_lifestyle = c(0, 0),
  data_channel_is_entertainment = c(0, 1),
  data_channel_is_bus = c(1, 0),
  data_channel_is_socmed = c(0, 0),
  data_channel_is_tech = c(0, 0),
  data_channel_is_world = c(0, 0),
  shares = c(1500, 1200))




# expected function output

 check_popular_value <- data.frame( 
    shares = c(593, 711, 1500),
    num_hrefs = c(4, 3, 3),
    num_imgs = c(1, 1, 1),
    num_videos = c(0, 0, 0),
    is_popular = as.factor(c(0, 0, 1)))

real_data_2_rows <- data.frame(
    shares = c(593, 711),
    num_hrefs = c(4, 3),
    num_imgs = c(1, 1),
    num_videos = c(0, 0),
    is_popular = as.factor(c(0, 0)))

real_data_2rows_34_expected <- data.frame(
    shares = c(1500, 1200),
    num_hrefs = c(3, 9),
    num_imgs = c(1, 1),
    num_videos = c(0, 0),
    is_popular = as.factor(c(1, 0)))

