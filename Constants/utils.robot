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

post generate token
    ${requestTokenBody}=    create dictionary   userName=${userName}    password=${password}
    ${requestTokenHeader}=  create dictionary    Content-Type=${ApplicationJSON}
    ${response}=    POST    ${BASE_URL_BOOKSTORE}${GENERATE_TOKEN_ENDPOINT}     ${requestTokenBody}     ${requestTokenHeader}
#    ${status_code}=  set suite variable    ${response.status_code}
#    log to console    The Status Code is --> ${status_code}

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
validate status code is 200
#    ${status_code}=    convert to string    ${response.status_code}
#    log to console    Status Code - response.status_code --> ${response.status_code}
#    log to console    Status Code - status_code --> ${status_code}
#    should be equal    ${status_code}       200
    status should be    200

validate status code is 201
    set global variable    ${status_code}    ${response.status_code}
    log to console    Status Code - response.status_code --> ${response.status_code}
    log to console    Status Code - status_code --> ${status_code}
    should be equal    ${status_code}       201

validate status code is 400
    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}       400

validate status code is 401
    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}       401

validate status code is 404
    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}       404

validate status code is 406
    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}       406

validate response body contains username and books
    set global variable   ${res_body}    ${response.content}

    should contain    ${res_body}       ${userName}
    should contain    ${res_body}       books

validate response body contains token and expires
    ${res_body}=    convert to string    ${response.content}
    should contain    ${res_body}       token
    should contain    ${res_body}       expires
