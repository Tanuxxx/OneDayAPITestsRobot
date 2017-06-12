*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***
${VALID_USERNAME}  d@d.co
${VALID_PASSWORD}  qqqqqq

${INVALID_USERNAME}  d@d.com
${INVALID_PASSWORD}  qqqqqq

${company_id}  24
${community_id}  595

${SERVER}  http://cms-st.oneday.com

*** Test Cases ***
User should be able authenticate with valid credentials
    [Documentation]  Client can authenticate using valid credentials and basic authentication
    [Tags]  APIAuthentication
#    Given User's valid credentials
#    When User Authenticates With Credentials  ${credentials}
    When User Authenticates With Valid Credentials
    Then Authentication Should Have Succeded


#User shouldn't be able to authenticate with invalid credentials
#    Given User's invalid credentials
#    When User Authenticates With Credentials  ${credentials}
#    Then Autentication Should Fail


Get categories
#    Given User's valid credentials
#    And User Authenticates With Credentials  ${credentials}
    Given User Authenticates With Valid Credentials
    And Get user's authentication headers
#    When Request Categories From CMS  ${company_id}  ${community_id}
    When Request Categories From CMS  24  595
    Then Categories List Is Not Empty


*** Keywords ***
#User's valid credentials
#    Get user's credentials  ${VALID_USERNAME}  ${VALID_PASSWORD}

#User's invalid credentials
#    Get user's credentials  ${INVALID_USERNAME}  ${INVALID_PASSWORD}
User Authenticates With Valid Credentials
    Get user's credentials  ${valid_username}  ${valid_password}
    User Authenticates With Credentials  ${credentials}


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

Get user's authentication headers
    ${auth_user_headers}=  create dictionary  Token=${auth_resp.headers['Token']}  TokenExpiry=${auth_resp.headers['TokenExpiry']}  Access-Control-Expose-Headers=${auth_resp.headers['Access-Control-Expose-Headers']}
    set test variable  ${auth_user_headers}

Request Categories From CMS
    [Arguments]  ${company_id}  ${community_id}
    ${get_categories_response}=  get request  server_session  /api/v2/category/masterlist/${company_id}/${community_id}  headers=${auth_user_headers}
    set test variable  ${get_categories_response}

Categories List Is Not Empty
#    ${count_categories}=  get length  ${get_categories_response.json()}
#    should be true  ${count_categories}>0
    should not be empty  ${get_categories_response.json()}