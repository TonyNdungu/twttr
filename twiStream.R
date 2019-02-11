# Load required libraries
library(twitteR)
library(streamR)
library(ROAuth)
#======================== App Credentials ===============================================================================================

# Add App Keys Provided by Twitter
consumerKey = "T247avsV5cil8YUYuSYl25yCa"
consumerSecret = "W0HPnGJp2XqsLpyhImjOgem29f0dcxIrkDdzO0aicv3nMDbGdy"

# Setup Twitter App Credentials
reqURL <-"https://api.twitter.com/oauth/request_token"
accessURL <-"https://api.twitter.com/oauth/access_token"
authURL <-"https://api.twitter.com/oauth/authorize"
consKey <- consumerKey
consSecret <- consumerSecret

#======================= Authenticate ===================================================================================================

# Authenticate Credentials
twitCred <- OAuthFactory$new(consumerKey=consKey,consumerSecret=consSecret,requestURL=reqURL,accessURL=accessURL,authURL=authURL)

# Download Authentication Certificate
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

# Initiate System Handshake
twitCred$handshake(cainfo="cacert.pem")

# Set SSL Certs 
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

# Save Authentication Credentials
save(list="twitCred", file="twitteR_credentials")

#=====================================================
# Collection
load("my_oauth.Rdata")

filterStream(file.name = "tweets.json", 
             track = c("@UKenyatta"), 
             language = "en",
             timeout = 0,
             oauth = twitCred)

tweets.df <- parseTweets("tweets.json", simplify = FALSE)

# If above fails
library(RJSONIO)
j = fromJSON('tweets.json')
View(j)

a <-parseTweets('tweets.json')
View(a)
write.csv(x = a,file = 'whatisaroad.csv')
View(a)