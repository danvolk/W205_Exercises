import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Create a helper function
def get_words(lb, ub, conn):
    cur = conn.cursor()
    cur.execute("""
    SELECT * 
    FROM tweetwordcount 
    WHERE count between %s and %s 
    ORDER BY count DESC;""", (lb,ub))
    recs = cur.fetchall()
    for rec in recs:
        print "word = ", rec[0]
        print "count = ", rec[1], "\n"
    
# Create a connection object to the tcount db
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")    

# Create a function that validates the range
def clean_args(args):
    rng = args.split(",")
    rng = [int(x.strip()) for x in rng if x.isdigit()]
    rng.sort()
    if len(rng) == 2:
        return True, rng[0], rng[1]
    else:
        return False, '', ''

if len(sys.argv) != 2:
    print "Invalid arguments"
else:
    valid, lb, ub = clean_args(sys.argv[1])
    if valid:
        get_words(lb, ub, conn)
    else:
        print "Invalid arguments"

conn.close()
