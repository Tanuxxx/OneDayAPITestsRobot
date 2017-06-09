*** Settings ***
Library  RequestsLibrary
Library  Collections


*** Variables ***
${VALID_USERNAME}  d@d.co
${VALID_PASSWORD}  qqqqqq

${INVALID_USERNAME}  d@d.com
${INVALID_PASSWORD}  qqqqqq

${SERVER}  http://cms-st.oneday.com

*** Test Cases ***
User should be able authenticate with valid credentials
    [Documentation]  Client can authenticate using valid credentials and basic authentication
    [Tags]  APIAuthentication
    Given User's valid credentials
#    ${auth_resp_token}  ${auth_resp.headers['Token']}
#    ${auth_resp_token_expiry}  ${auth_resp.headers['TokenExpiry']}
#    ${auth_resp_access_control}  ${auth_resp.headers['Access-Control-Expose-Headers']}
    When User Authenticates With Credentials  ${credentials}
    Then Authentication Should Have Succeded


User shouldn't be able to authenticate with invalid credentials
#    Given User's credentials  ${INVALID_USERNAME}  ${INVALID_PASSWORD}
    Given User's invalid credentials
    When User Authenticates With Credentials  ${credentials}
    Then Autentication Should Fail


*** Keywords ***
User's valid credentials
    Get user's credentials  ${VALID_USERNAME}  ${VALID_PASSWORD}

User's invalid credentials
    Get user's credentials  ${INVALID_USERNAME}  ${INVALID_PASSWORD}

Get user's credentials
    [Arguments]  ${username}  ${password}
    ${credentials} =  create list  ${username}  ${password}
    set test variable  ${credentials}

User Authenticates With Credentials
    [Arguments]  ${credentials}
    create session  server_session  ${SERVER}  auth=${credentials}
    ${auth_resp} =  post request  server_session  /api/v2/authenticate
    set test variable  ${auth_resp}

Authentication Should Have Succeded
    should be equal as strings  ${auth_resp.status_code}  200
    should be equal as strings  ${auth_resp.json()}  Authorized

Autentication Should Fail
    should be equal as strings  ${auth_resp.status_code}  401
