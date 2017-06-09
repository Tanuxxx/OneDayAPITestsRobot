*** Settings ***
Documentation    Suite description
Resource  Authentication.robot

*** Test Cases ***
Get categories
    Given User's valid credentials
    And User Authenticates With Credentials  ${credentials}
#    When Request Categories From CMS
#    Then Categories Are Not Empty


*** Keywords ***
