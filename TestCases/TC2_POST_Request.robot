*** Settings ***
Resource   ../Constants/validations.robot
Library     RequestsLibrary
Library     Collections

*** Test Cases ***
Create User TestCase
    [Tags]    createUser
    post create user
    status should be    201
    validate response body contains username and books

Generate Token TestCase
    [Tags]    generateToken
    set header and body for generate token
    post generate token
    status should be    200
    log to console    ${response.json()}
#    validate response body contains token and expires





Get User Account TestCase
    [Tags]    getAccount
    get user account
    status should be    200