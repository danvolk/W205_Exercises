Exercise 2 Instructions

The following instructions assume that you have Storm and postgres installed on your machine.

Step 1: Clone the repo down into your machine

Step 2: Install both `tweepy` and `psycopg2` via python's pip installer

Step 3: Create a database called `tcount` in postgres. The `tcount` database should contain a table called `tweetwordcount` with the following schema:

`CREATE TABLE tweetwordcount AS (word TEXT NOT NULL, count INT);`

Step 4: Navigate to the extweetwordcount folder in the repository and run the command `sparse run`. This will initiate the stream and run it until it is manually halted by the user. In order to keep it running, you will need to run the same command as part of a nohup call.

Step 5: After the stream has been stopped, you can view the results directly in postgres in a database called tcount. You can use the serving scripts to return results. In the `/results` folder you will find two scripts `finalresults.py` and `histogram.py`. Both can be used to query word counts by word or by count range.