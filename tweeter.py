import tweepy
import json

with open('twitterauth.json') as file:
    secrets = json.load(file)

auth = tweepy.OAuthHandler(secrets['consumer_key'], secrets['consumer_secret'])
auth.set_access_token(secrets['access_token'], secrets['access_token_secret'])

with open('tweet.txt') as file:
    tweettxt = json.load(file)


twitter = tweepy.API(auth)

twitter.update_status(tweettxt['text'])
