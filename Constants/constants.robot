*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL_BOOKSTORE}     https://bookstore.toolsqa.com
${CREATE_NEW_ACCOUNT_ENDPOINT}      /Account/v1/User
${GENERATE_TOKEN_ENDPOINT}      /Account/v1/GenerateToken
${DELETE_ACCOUNT_ENDPOINT}      /Account/v1/User/${userIDFromResponse}
${GET_ACCOUNT_INFO_ENDPOINT}    /Account/v1/User/${userIDFromResponse}
${POST_BOOKS}       /Bookstore/v1/Books

${ApplicationJSON}      application/json
${response}
${status_code}
${response.status_code}
${res_body}
${responseVariable}

${userName}     edavids47
${password}     Edgar@132
${userIDFromResponse}
${token}

${book_git_pocket_guide}    9781449325862
${book_learning_javascript_design}  9781449331818
${book_designing_evolvable_web}  9781449337711
${book_speaking_javascript}     9781449365035
${book_speaking_java}     9781449311111
${book_speaking_python}     9781449311112