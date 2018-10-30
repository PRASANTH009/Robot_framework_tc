*** Settings ***
 Library  Process

*** Test cases ***
 Example
   Run process  ifconfig  -a  eth0
   Run process  netstat  –tlpn |  grep  80  
