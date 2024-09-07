*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     http://restapi.demoqa.com
${GET_END_URL}  /utilities/weather/city/
${testCityDelhi}    Delhi
${expectedCode200}  200
${contentType}  Content-Type
${applicationJson}  application/json

*** Test Cases ***
Get_weatherInfo
    create session  mySession   ${BASE_URL}
#    response will contain status code, header and body
    ${response}=    get request    mySession    ${get_end_url}${testCityDelhi}

#    log to console    ${response.statusCode}
#    log to console    ${response.content}
#    log to console    ${response.headers}

#    Validations --> we need to convert the response status code into String format
    ${actualResponseStatusCodeString}=      convert to string    ${response.statusCode}
    should be equal    ${actualResponseStatusCodeString}       ${expectedCode200}
    log to console    Actual Status Code is --> ${actualResponseStatusCodeString}

    ${responseBodyString}=    convert to string    ${response.content}
    should contain    ${responseBodyString}   ${testCityDelhi}
    log to console    Actual Response Body is --> ${responseBodyString}

    ${responseHeaderContentTypeValue}=    get from dictionary    ${response.headers}    ${contentType}
    should be equal    ${responseHeaderContentTypeValue}    ${applicationJson}
    log to console    Actual Response Header Content-Type is -->  ${responseHeaderContentTypeValue}

#     debug
