*** Settings ***
Resource  SessionVariables&Keywords.robot

*** Variables ***

*** Test Cases ***
Authentication with valid credentials should pass
    [Documentation]  Client can authenticate using valid credentials and basic authentication
    [Tags]  APIAuthentication
#    Given User's valid credentials
    Given Get user's credentials  ${VALID_USERNAME}  ${VALID_PASSWORD}
    When User Authenticates With Credentials  ${credentials}
    Then Authentication Should Have Succeded


*** Keywords ***
Authentication Should Have Succeded
    should be equal as strings  ${auth_resp.status_code}  200
    should be equal as strings  ${auth_resp.json()}  Authorized