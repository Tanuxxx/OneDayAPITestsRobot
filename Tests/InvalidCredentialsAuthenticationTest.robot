*** Settings ***
#Library  RequestsLibrary
#Library  Collections

Resource  SessionVariables&Keywords.robot

Test Template  Authentication With Invalid Credentials Should Fail


*** Variables ***
${VALID_USERNAME}  d@d.co
${VALID_PASSWORD}  qqqqqq

${SERVER}  http://cms-st.oneday.com

*** Test Cases ***    USERNAME           PASSWORD
Unexisting Username   d@d.com            ${VALID_PASSWORD}
Invalid Password      ${VALID_USERNAME}  qqqq
Empty Password        ${VALID_USERNAME}  ''
Empty Email           ''                 ${VALID_PASSWORD}
Empty Credentials     ''                 ''


*** Keywords ***
Authentication With Invalid Credentials Should Fail  [Arguments]  ${username}  ${password}
    Get user's credentials  ${username}  ${password}
    User Authenticates With Credentials  ${credentials}
    Autentication Should Fail

#Get user's credentials  [Arguments]  ${username}  ${password}
#    ${credentials} =  create list  ${username}  ${password}
#    set test variable  ${credentials}
#
#User Authenticates With Credentials  [Arguments]  ${credentials}
#    create session  server_session  ${SERVER}  auth=${credentials}
#    ${auth_resp} =  post request  server_session  /api/v2/authenticate
#    set test variable  ${auth_resp}
#
#Autentication Should Fail
#    should be equal as strings  ${auth_resp.status_code}  401

