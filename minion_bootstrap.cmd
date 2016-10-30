echo master: salt >> c:\salt\conf\minion
echo 192.168.37.10 salt >> c:\windows\system32\drivers\etc\hosts
net stop salt-minion
net start salt-minion
