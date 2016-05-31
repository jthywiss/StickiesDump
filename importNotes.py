#!/usr/bin/python
#
# importNotes.py
#

import imaplib
import sys
from datetime import date
from getpass import getpass

hostname = 'imap.example.com'
print 'IMAP server: ',hostname
username = 'username'
print 'User name: ',username
password = getpass()

print '+++ Connecting to', hostname
connection = imaplib.IMAP4_SSL(hostname)

print '+++ capabilities: ', connection.capabilities

print '+++ Logging in as', username
connection.login_cram_md5(username, password)

files = sys.argv[1:]

for filename in files:
    note = open(filename).read()
    imapInternalDate = int(filename)
    
    print 'APPEND:  \'Notes\', \'\', ',imaplib.Time2Internaldate(imapInternalDate), ',', str(note)
    connection.append('Notes', '', imaplib.Time2Internaldate(imapInternalDate), str(note))

#connection.close()
connection.logout()
