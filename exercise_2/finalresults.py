import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Create a helper function for a single word
def wordcount(word, conn):
    cur = conn.cursor()
    cur.execute("SELECT * FROM tweetwordcount WHERE word=%s", (word,))
    recs = cur.fetchall()
    if len(recs) == 0:
        print 'The total number of occurrences of "' + word + '": 0'
    elif len(recs) == 1: 
        rec = recs[0]
        print 'The total number of occurrences of "' + rec[0] + '":', rec[1]
    else:
        print "More than one record returned"
    
# Create a helper function for all words
def allwords(conn):
    cur = conn.cursor()
    cur.execute("SELECT * FROM tweetwordcount ORDER BY word")
    recs = cur.fetchall()
    for rec in recs:
        print "word = ", rec[0]
        print "count = ", rec[1], "\n"
    
    
# Create a connection object to the tcount db
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")    

if len(sys.argv) != 2:
    allwords(conn)
else: 
    word = sys.argv[1]
    word = word.lower()
    wordcount(word, conn)

conn.close()
