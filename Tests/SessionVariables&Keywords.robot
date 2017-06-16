*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***
${VALID_USERNAME}  d@d.co
${VALID_PASSWORD}  qqqqqq

${company_id}  24
${community_id}  595

${SERVER}  http://cms-st.oneday.com

*** Keywords ***
User Authenticates With Valid Credentials
    Get user's credentials  ${valid_username}  ${valid_password}
    User Authenticates With Credentials  ${credentials}
    ${auth_user_headers}=  create dictionary  Token=${auth_resp.headers['Token']}  TokenExpiry=${auth_resp.headers['TokenExpiry']}  Access-Control-Expose-Headers=${auth_resp.headers['Access-Control-Expose-Headers']}
    set test variable  ${auth_user_headers}

Get user's credentials
    [Arguments]  ${username}  ${password}
    ${credentials} =  create list  ${username}  ${password}
    set test variable  ${credentials}

User Authenticates With Credentials
    [Arguments]  ${credentials}
    create session  server_session  ${SERVER}  auth=${credentials}
    ${auth_resp} =  post request  server_session  /api/v2/authenticate
    set test variable  ${auth_resp}

