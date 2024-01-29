# -*- coding: utf-8 -*-
"""
Created on Sat Jan  6 15:20:14 2024

@author: shanu
"""

import re

chat1 = 'codebasics: you ask lot of questions 😠  1235678912, abc@xyz.com'
chat2 = 'codebasics: here it is: (123)-567-8912, abc@xyz.com'
chat3 = 'codebasics: yes, phone: 1235678912 email: abc@xyz.com'

pattern ='\d{10}|\(\d{3}\)-\d{3}-\d{4}'
re.findall(pattern, chat2)

email_pat ="\w*\@\w*\.\w*"
re.findall(email_pat,chat1)

'''
1. Extract all twitter handles from following text. Twitter handle is the text that 
appears after https://twitter.com/ and is a single word.
 Also it contains only alpha numeric characters i.e. A-Z a-z , o to 9 and underscore _'''
text = '''
Follow our leader Elon musk on twitter here: https://twitter.com/elonmusk, more information 
on Tesla's products can be found at https://www.tesla.com/. Also here are leading influencers 
for tesla related news,
https://twitter.com/teslarati
https://twitter.com/dummy_tesla
https://twitter.com/dummy_2_tesla
'''
pattern = 'https://twitter.com/(\w+)' # todo: type your regex here

re.findall(pattern, text)

'''
2. Extract Concentration Risk Types. It will be a text that appears after "Concentration Risk:", In below example, your regex should extract these two strings

(1) Credit Risk

(2) Supply Rish
'''

text = '''
Concentration of Risk: Credit Risk
Financial instruments that potentially subject us to a concentration of credit risk consist of cash, cash equivalents, marketable securities,
restricted cash, accounts receivable, convertible note hedges, and interest rate swaps. Our cash balances are primarily invested in money market funds
or on deposit at high credit quality financial institutions in the U.S. These deposits are typically in excess of insured limits. As of September 30, 2021
and December 31, 2020, no entity represented 10% or more of our total accounts receivable balance. The risk of concentration for our convertible note
hedges and interest rate swaps is mitigated by transacting with several highly-rated multinational banks.
Concentration of Risk: Supply Risk
We are dependent on our suppliers, including single source suppliers, and the inability of these suppliers to deliver necessary components of our
products in a timely manner at prices, quality levels and volumes acceptable to us, or our inability to efficiently manage these components from these
suppliers, could have a material adverse effect on our business, prospects, financial condition and operating results.
'''
pattern = 'Concentration of Risk:(.*)\n' # todo: type your regex here

re.findall(pattern, text)


import spacy 

nlp= spacy.load("en_core_web_sm")
doc=nlp("Dr, Starnge likes Pav Bhaji. Hulk likes Chhat.")

for sentence in doc.sents:
    print(sentence)






















