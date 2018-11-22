*** Settings ***
Test Setup        Setup TCP server and client
Test Teardown     Teardown rammbock and increment port numbers
Default Tags      Regression
Resource          Protocols.robot

*** Test cases ***
TCP Client sends binary to server
    [Tags]  jybot
    Client sends binary    foo
    ${message}=    Server receives binary
    Should be equal    ${message}    foo

TCP Server sends binary to client
    [Tags]  pybot
    Server sends binary    foo
    ${message}=    Client receives binary
    Should be equal    ${message}    foo

Multiple UDP clients
    [Tags]     pybot
    [Setup]    Start two udp clients
    Start udp server    ${SERVER}    ${SERVER PORT}    name=ExampleServer
    Connect two clients    ${SERVER PORT}    ${SERVER PORT}
    Two clients send foo and bar
    Server 'ExampleServer' should get 'foo' from '${CLIENT}':'${CLIENT 1 PORT}'
    Server 'ExampleServer' should get 'bar' from '${CLIENT}':'${CLIENT 2 PORT}'

Multiple UDP servers
    [Setup]    Start two udp clients
    Start udp server    ${SERVER}    ${SERVER PORT}    name=Server_1
    Start udp server    ${SERVER}    ${SERVER PORT 2}    name=Server_2
    Connect two clients    ${SERVER PORT}    ${SERVER PORT 2}
    Two clients send foo and bar
    Server 'Server_1' should get 'foo' from '${CLIENT}':'${CLIENT 1 PORT}'
    Server 'Server_2' should get 'bar' from '${CLIENT}':'${CLIENT 2 PORT}'

Multiple TCP clients
    [Tags]  jybot
    [Setup]    Start two tcp clients
    Start tcp server    ${SERVER}    ${SERVER PORT}    name=ExampleServer
    Connect two clients and accept connections
    Two clients send foo and bar
    'Connection_1' on 'ExampleServer' should get 'foo' from '${CLIENT}':'${CLIENT 1 PORT}'
    'Connection_2' on 'ExampleServer' should get 'bar' from '${CLIENT}':'${CLIENT 2 PORT}'

Multiple TCP servers
    [Tags]  pybot
    [Setup]    Start two tcp clients
    Start tcp server    ${SERVER}    ${SERVER PORT}    name=Server_1
    Start tcp server    ${SERVER}    ${SERVER PORT 2}    name=Server_2
    Connect two clients and accept connections    Server_1    ${SERVER PORT}    Server_2    ${SERVER PORT 2}
    Two clients send foo and bar
    Server 'Server_1' should get 'foo' from '${CLIENT}':'${CLIENT 1 PORT}'
    Server 'Server_2' should get 'bar' from '${CLIENT}':'${CLIENT 2 PORT}'

