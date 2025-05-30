# Packages

library(here)
library(dplyr)
library(telegram.bot)

# Sample and Send

load(here::here("data/show_links_df.rda"))

sample_show_link <- show_links_df |> 
  dplyr::slice_sample(n = 1)

# paste together markdown for message parse_mode
telegram_message <- paste0(
  "Happy ", lubridate::wday(Sys.Date(), label = TRUE, abbr = FALSE), "! ", 
  "Today's Tao of Tim comes from the episode with ", 
  "[", sample_show_link$article, "]", "(", sample_show_link$urls, ").", 
  " Here's the show link: ", 
  "[", sample_show_link$link_title, "]", "(", sample_show_link$link_url, ")")

bot <- telegram.bot::Bot(token = Sys.getenv("R_TELEGRAM_BOT_TIM_TAO_BOT"))

bot$sendMessage(
  Sys.getenv("TELEGRAM_CHANNEL_ID"), 
  text = telegram_message, parse_mode = "Markdown")
