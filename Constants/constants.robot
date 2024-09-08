*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL_BOOKSTORE}     https://bookstore.toolsqa.com
${CREATE_NEW_ACCOUNT_ENDPOINT}      /Account/v1/User
${GENERATE_TOKEN_ENDPOINT}      /Account/v1/GenerateToken
${DELETE_ACCOUNT_ENDPOINT}      /Account/v1/user/${userIDFromResponse}
${GET_ACCOUNT_INFO_ENDPOINT}    /Account/v1/user/${userIDFromResponse}

${ApplicationJSON}      application/json
${response}
${status_code}
${response.status_code}
${res_body}

${userName}     edavids30
${password}     Edgar@132
${userIDFromResponse}
${token}