*** Settings ***
Resource   ../Constants/validations.robot
Library     RequestsLibrary
Library     Collections

*** Variables ***
${userID}
${token1}

*** Test Cases ***
Create Valid User TestCase
    [Tags]    Regression
    ${body}=    create dictionary    userName=${userName}    password=${password}
    ${header}=  create dictionary    Content_Type=${ApplicationJSON}
    ${response}=    POST    ${BASE_URL_BOOKSTORE}${CREATE_NEW_ACCOUNT_ENDPOINT}      ${body}    ${header}
    status should be    201
    log to console   1st test case response.json() --> ${response.json()}
    ${responseVariable1}    set variable    ${response.json()}
    log to console    UserId from Response.JSON() is--> ${response.json()}[userID]
    set global variable    ${userID}    ${response.json()}[userID]
    log to console    TEST1 - UserID global variable is --> ${userID}

Generate Token For New UserID
    [Tags]    Regression
    ${requestTokenBody}=    create dictionary   userName=${userName}    password=${password}
    ${requestTokenHeader}=  create dictionary    Content-Type=${ApplicationJSON}
    ${response}=    POST    ${BASE_URL_BOOKSTORE}${GENERATE_TOKEN_ENDPOINT}     ${requestTokenBody}     ${requestTokenHeader}
    ${token1}=   convert to string   ${response.json()}[token]
#    log to console    token1 variable is --> ${token1}
    dictionary should contain key    ${response.json()}     token
    dictionary should contain key    ${response.json()}     expires
    log to console    TEST2 - UserID global variable is --> ${userID}

Get User Status
    [Tags]    Regression
    ${response}=   GET    ${BASE_URL_BOOKSTORE}${CREATE_NEW_ACCOUNT_ENDPOINT}    params=UUID=${userID}
    status should be    200

#---------------------------------------------------------------------------------------------------------

#Bookstore Books
Add Books to Account
    [Tags]    addBooks
    ${body}=    create dictionary    userID=${userID}   collectionOfIsbns.isbn=${book_git_pocket_guide}
    ${header}=  create dictionary    Content-Type=${ApplicationJSON}
    ${response}=    POST    ${BASE_URL_BOOKSTORE}${POST_BOOKS}      ${body}     ${header}
    status should be    201
    log to console    ${response}