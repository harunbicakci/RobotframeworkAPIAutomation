*** Settings ***
Resource   ../Constants/validations.robot
Library     RequestsLibrary
Library     Collections

*** Test Cases ***
Create User TestCase
    [Tags]    createUser
    post create user
    validate status code is 201
    validate response body contains username and books

Generate Token TestCase
    [Tags]    generateToken
    post generate token
    validate status code is 200
    validate response body contains token and expires

Get User Account TestCase
    [Tags]    getAccount
    get user account