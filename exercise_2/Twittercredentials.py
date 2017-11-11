import tweepy

consumer_key = "RtIFHuwdXTwDfU1Yrr1AxRoCq";
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "5yIY0zpmS32lz9aoHTvje0FTcjup1xgGQ3FCEhjxw87qhKKPD7";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "929426240930381824-6CS45rSBUUz8MVcJUfYQktl8VLA31V7";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "WhLtEDBDr8EEruu2MUD0eKXa1UAdBTreaKEVChe19a165";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



