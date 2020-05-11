import paramiko
import sys
import time
import re
import io

ipaddr ='10.10.10.2'
username = "admin"
password = "admin"
enable = "enable"
conf = "configure terminal"
host = "hostname R2"
end = "end"
exit = "exit"

def GET_SERIAL(remote_conn):
    print("Interactive SSH session established")
    remote_conn.send("show system info\r")
    time.sleep(2)
    output = remote_conn.recv(65535)
    print(output)
    #test = re.search(r'SN:(\s[0-9]*)', output)
    #print test.group(1)
    #print output
    #time.sleep(2)


#def COMMONEND():
#    remote_conn.send("end\r")
#    remote_conn.send("disable\r")
#    remote_conn.close()

pan = "52.207.193.172"
x = paramiko.SSHClient()
private_key = "/Users/pnegron/OneDrive - Guidewire Software Inc/keys/VaNetopsUtil.pem"
zz = open(private_key)
zzz = zz.read()
zz.close()
x.set_missing_host_key_policy(paramiko.AutoAddPolicy())
x.connect(pan, username=username, allow_agent= False, key_filename=private_key)
y = x.invoke_shell()
print("SSH connection established to %s" %  pan)
GET_SERIAL(y)
sys.exit()
