
# in python 2 , for urllib maybe
import subprocess
import sys
import urllib
import urllib2
import json

import os
#for open and write

#if not file("/etc/machine-id")
    #raise(Exception("no file machine-id"))
if (os.path.exists("/etc/DEVELOPMENT_ENVF")):
    flagreg = ".flagreg"
else:
    flagreg = "/storage/.config/factory.status"
if (os.path.exists("/etc/DEVELOPMENT_ENV")):
    #regurl="http://reg.com.funhome.tv:5001/reg"
    #regurl="http://127.0.0.1:5047/reg"
    regurl="https://reg.com.funhome.tv/devreg"
else:
    regurl="https://reg.com.funhome.tv/reg"

if os.path.exists(flagreg):
    with open(flagreg,'r') as flh:
        fcont=flh.read()
    jc2=json.loads(fcont)
    print("read file ok")
#    print(jc2["id"], jc2["StatusCode"])
    if(jc2["StatusCode"]=='200' and (not (len(jc2["id"]) == 0))):
        raise(Exception("already registed"))

if not os.path.exists("/etc/machine-id"):
    genrandmid="uuidgen --random > testmid.txt"
    subprocess.Popen([genrandmid], shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    cmdgetmid="openssl dgst -sha3-256 testmid.txt"
else:
    cmdgetmid="openssl dgst -sha3-256  /etc/machine-id"

dgst = subprocess.Popen([cmdgetmid], shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
readout1 = dgst.stdout.readline()
dgstpart = readout1.split(" ")[-1]
#print (readout1)

#print ("dgstpart", dgstpart)
#print ("len dgst",len(dgstpart))

def url_quote(var):
    return urllib2.quote(var, safe="")

def load_url(url):
    try:
        request = urllib2.Request(url)
        response = urllib2.urlopen(request)
        content = response.read()
        return content.strip()
    except Exception as e:
        print('oe::load_url(' + url + ')', 'ERROR: (' + repr(e) + ')')

regdata={ 
        'mi':dgstpart,
        'a':'0.0.0.0',
        'name':'waitsetup.funhome.tv',
        'aaaa':'0::1',
        }

#urldatastr = urllib.urlencode(regdata)
urldatastr = "machineid=%s&a=%s&name=%s&aaaa=%s" %( 
        urllib2.quote(dgstpart[:64]) ,
        urllib2.quote('0.0.0.0'),
        urllib2.quote('waitsetup.funhome.tv'),
        urllib2.quote('0::1')
        )
fakemid="(hidden)"
urldatastr_hidden = "machineid=%s&a=%s&name=%s&aaaa=%s" %( 
        urllib2.quote(fakemid) ,
        urllib2.quote('0.0.0.0'),
        urllib2.quote('waitsetup.funhome.tv'),
        urllib2.quote('0::1')
        )
#request = urllib2.Request(regurl,regdata)
#print (regurl,urldatastr)
print (regurl,urldatastr_hidden)
response = urllib2.urlopen(regurl,urldatastr)
print ("urldatastr:", urldatastr_hidden)

content = response.read()
print (content)
jc=json.loads(content)
if jc['StatusCode'] == '200':
    print ("success")
    jc['id']=str(dgstpart[:64])
    json.dump(jc,fp=open(flagreg,'w'),indent=4)
    os.chmod(flagreg,256) ## make the file read only by the owner
    
    with open(flagreg,'r') as flh:
        fcont=flh.read()
    jc2=json.loads(fcont)
    print("read file ok")
    #    print(jc2["id"], jc2["StatusCode"])
    print(fakemid,jc2["StatusCode"]) 
else:
    print ("something wrong")

