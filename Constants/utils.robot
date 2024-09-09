*** Settings ***
Resource    constants.robot
Library     RequestsLibrary
Library     Collections

*** Keywords ***

post create user
#    create session    mySession     ${BASE_URL_BOOKSTORE}

#   create dictionary    creates mapping key and value format
    ${body}=    create dictionary    userName=${userName}    password=${password}
    ${header}=  create dictionary    Content_Type=${ApplicationJSON}

#   to pass the body and header
    ${response}=    POST    ${BASE_URL_BOOKSTORE}${CREATE_NEW_ACCOUNT_ENDPOINT}      ${body}    ${header}
    ${status_code}  set variable    ${response.status_code}
    set suite variable      ${status_code}

    log to console    The Status Code is --> ${status_code}
    log to console    The Response Content is --> ${response.content}
    log to console    The Response Header is --> ${response.headers}

    log to console    The Response.JSON() method is --> ${response.json()}
    Log List    ${response.json()}

#   extract userID from response --> ${response.json()}[userID]
    ${userIDFromResponse}=    convert to string    ${response.json()}[userID]
    log to console    The User ID from the response is --> ${userIDFromResponse}

set header and body for generate token
    ${requestTokenBody}=    create dictionary   userName=${userName}    password=${password}
    ${requestTokenHeader}=  create dictionary    Content-Type=${ApplicationJSON}
    ${response}=    POST    ${BASE_URL_BOOKSTORE}${GENERATE_TOKEN_ENDPOINT}     ${requestTokenBody}     ${requestTokenHeader}


post generate token
#    ${response}=    POST    ${BASE_URL_BOOKSTORE}${GENERATE_TOKEN_ENDPOINT}     ${requestTokenBody}     ${requestTokenHeader}
#    ${status_code}=  set suite variable    ${response.status_code}
#    log to console    The Status Code is --> ${status_code}

#----------------------------------------------------------------------------------------------------------------------
    ${responseVariable}=    set variable    ${response.json()}
    log to console    UTILS --> responseVariable is --> ${responseVariable}

#----------------------------------------------------------------------------------------------------------------------
    ${token1}=   convert to string   ${response.json()}[token]
    log to console    token1 variable is --> ${token1}

    ${token}=   convert to string   ${response.json()}[token]
    log to console    token variable in the Constants is --> ${token}

    ${tokenExpiry}=     convert to string    ${response.json()}[expires]
    log to console    token expiry date and time is --> ${tokenExpiry}

get user account
    ${response}=    GET     ${BASE_URL_BOOKSTORE}${GET_ACCOUNT_INFO_ENDPOINT}
    ${responseToString}=    convert to string    ${response.json()}
    log to console    The GET USER response.content method is --> ${response.content}
    log to console    The GET USER responseToString.content method is --> ${responseToString.content}
    log to console    The GET USER response.json() method is --> ${response.json()}

#    VALIDATIONS
validate response body contains username and books
    set global variable   ${res_body}    ${response.content}

    should contain    ${res_body}       ${userName}
    should contain    ${res_body}       books

validate response body contains token and expires
    log to console    UTILS --> responseVariable is --> ${responseVariable}
#    ${res_body}=    convert to string    ${response.content}
    should contain    ${responseVariable}       token
    should contain    ${responseVariable}       expires
