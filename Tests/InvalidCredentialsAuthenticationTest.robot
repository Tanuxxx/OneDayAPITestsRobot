*** Settings ***
Resource  SessionVariables&Keywords.robot

Test Template  Authentication With Invalid Credentials Should Fail


*** Variables ***

*** Test Cases ***    USERNAME           PASSWORD
Unexisting Username   d@d.com            ${VALID_PASSWORD}
Invalid Password      ${VALID_USERNAME}  qqqq
Empty Password        ${VALID_USERNAME}  ${EMPTY}
Empty Email           ${EMPTY}           ${VALID_PASSWORD}
Empty Credentials     ${EMPTY}           ${EMPTY}


*** Keywords ***
Authentication With Invalid Credentials Should Fail  [Arguments]  ${username}  ${password}
    Get user's credentials  ${username}  ${password}
    User Authenticates With Credentials  ${credentials}
    Autentication Should Fail

Autentication Should Fail
    should be equal as strings  ${auth_resp.status_code}  401

