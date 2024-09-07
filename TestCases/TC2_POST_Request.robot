*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL_BOOKSTORE}     https://bookstore.toolsqa.com
${CREATE_NEW_ACCOUNT_ENDPOINT}      /Account/v1/User
${userName}     edavids11
${password}     Edgar@132

*** Test Cases ***
Put_CustomerRegistration
#    create session    mySession     ${BASE_URL_BOOKSTORE}

#   create dictionary    creates mapping key and value format
    ${body}=    create dictionary    userName=${userName}    password=${password}
    ${header}=  create dictionary    Content_Type=application/json

#    to pass the body and header use "data=" and "=headers"
    ${response}=    POST    ${BASE_URL_BOOKSTORE}${CREATE_NEW_ACCOUNT_ENDPOINT}      ${body}    ${header}

    log to console    The Status Code is --> ${response.status_code}
    log to console    The Response Content is --> ${response.content}
    log to console    The Response Header is --> ${response.headers}


#    VALIDATIONS

    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}       201

    ${res_body}=    convert to string    ${response.content}
    should contain    ${res_body}       ${userName}
    should contain    ${res_body}       books