from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT



class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()
        self.conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")


    def process(self, tup):
        word = tup.values[0]

        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres
        # Database name: Tcount
        # Table name: Tweetwordcount
        # you need to create both the database and the table in advance.


        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])
        
        # Create a cursor object
        self.cur = self.conn.cursor()
        
        # Update count value for a word
        self.cur.execute("UPDATE tweetwordcount SET count=count+1 WHERE word=%s", (word,))
        
        # If word is not in database add it
        if self.cur.rowcount == 0:
            self.cur.execute("INSERT INTO tweetwordcount (word, count) VALUES (%s,1)",(word,))
        
        # Commit changes
        self.conn.commit()

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
