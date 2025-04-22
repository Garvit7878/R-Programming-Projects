
# Sentiment Analysis on Tweets using R
# Author: Garvit Sharma | University ID: 2301730190

# Install required packages (uncomment if not installed)
# install.packages(c("rtweet", "tidytext", "dplyr", "ggplot2", "tidyr"))

library(rtweet)
library(tidytext)
library(dplyr)
library(ggplot2)
library(tidyr)

# Step 1: Fetch Tweets
tweets <- search_tweets("R programming", n = 500, lang = "en", include_rts = FALSE)

# Step 2: Text Cleaning
tweets_clean <- tweets %>%
  select(text) %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words, by = "word") %>%
  filter(!word %in% c("https", "t.co", "rt", "amp"))

# Step 3: Sentiment Analysis using Bing Lexicon
bing_sentiment <- tweets_clean %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment, sort = TRUE)

# Visualization: Bing Lexicon Sentiment
ggplot(bing_sentiment, aes(x = sentiment, y = n, fill = sentiment)) +
  geom_col() +
  labs(title = "Sentiment Analysis of Tweets on 'R programming'",
       x = "Sentiment", y = "Count") +
  theme_minimal()

# Optional: NRC Sentiment Breakdown
nrc_sentiment <- tweets_clean %>%
  inner_join(get_sentiments("nrc")) %>%
  count(sentiment, sort = TRUE)

# Visualization: NRC Emotions
ggplot(nrc_sentiment, aes(x = reorder(sentiment, n), y = n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(title = "NRC Emotion Breakdown", x = "Emotion", y = "Count") +
  theme_minimal()
