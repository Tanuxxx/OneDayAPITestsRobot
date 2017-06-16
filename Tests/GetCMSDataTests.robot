*** Settings ***
Library  Library.ValidateJSONSchema
Resource  SessionVariables&Keywords.robot
Test Template  Get CMS Data Is Not Empty

*** Variables ***
${company_community}=  ${company_id}/${community_id}


*** Test Cases ***      URL                             ADDITIONAL_DATA
#Get audios              /api/v2/audio/get               ${company_id}
Get categories          /api/v2/category/masterlist     ${company_community}
#Get communities         /api/v2/community/list          ${company_id}
#Get company attributes  /api/v2/company/attribute       ${company_id}
#Get images              /api/v2/theme/imagesbycompany   ${company_id}
#Get moments             /api/v2/moment/list             ${company_community}
#Get stories             /api/v2/story/masterlist        ${company_community}
#Get themes              /api/v2/theme/list              ${company_id}


*** Keywords ***
Get CMS Data Is Not Empty
    [Arguments]  ${api_url}  ${additional_data}
#    [Arguments]  ${url}
#    ${url}=  convert to string  ${api_url}/${company_id}/${community_id}
    ${url}=  convert to string  ${api_url}/${additional_data}
    User Authenticates With Valid Credentials
    Request Data From CMS  ${url}
    Status Response Is Success
    Data List Is Not Empty

Request Data From CMS
    [Arguments]  ${url}
    ${get_categories_response}=  get request  server_session  ${url}  headers=${auth_user_headers}
    set test variable  ${get_categories_response}

Data List Is Not Empty
#    ${count_categories}=  get length  ${get_categories_response.json()}
#    should be true  ${count_categories}>0
     should not be empty  ${get_categories_response.json()}
     Validate Categories JSON Schema  ${get_categories_response.json()}

Status Response Is Success
    should be equal as strings  ${get_categories_response.status_code}  200

