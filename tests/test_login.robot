*** Settings ***
Documentation     A test suite for testing login.

Resource          ${CURDIR}${/}..${/}resources${/}common.robot

Test Setup        Open Browser Page
Test Teardown     Close All Browsers


*** Variables ***
${INVALID_USERNAME}    locked_out_user
${INVALID_PASSWORD}    secret_sauce


*** Test Cases ***
Test Valid Login
    [Tags]    valid_login
    Login As User
    Verify Login Successful

Test Invalid Login
    [Tags]    invalid_login
    Login As User    username=${INVALID_USERNAME}    password=${INVALID_PASSWORD}
    Verify Login Failed
