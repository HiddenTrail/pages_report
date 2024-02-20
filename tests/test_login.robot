*** Settings ***
Documentation     A test suite for testing login.

Resource          ${CURDIR}${/}..${/}resources${/}common.robot

Test Setup        Open Browser Page
Test Teardown     Close All Browsers


*** Test Cases ***
Test Valid Login
    [Tags]    valid_login
    Login As User
    Verify Login Successful

Test Invalid Login
    [Tags]    invalid_login
    Login As User    username=locked_out_user    password=secret_sauce
    Verify Login Failed
