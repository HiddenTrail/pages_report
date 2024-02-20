*** Settings ***
Documentation    A resource file with reusable keywords for the login page.

Resource         common.robot


*** Variables ***
${USERNAME_FIELD}    \#user-name
${PASSWORD_FIELD}    \#password
${LOGIN_BUTTON}      \#login-button
${SHOPPING_CART}     \#shopping_cart_container
${LOGIN_ERROR}       //h3[@data-test="error"]


*** Keywords ***
Login As User
    [Documentation]    Logs in as a a user. Default is standard user.
    ...                This Keyword groups page-object keywords together to form a higher-level keyword.
    [Arguments]        ${username}=${STANDARD_USER}    ${password}=${STANDARD_PASSWORD}
    Fill Username      ${username}
    Fill Password      ${password}
    Click Login

Fill Username
    [Arguments]    ${username}
    Fill Text      ${USERNAME_FIELD}    ${username}

Fill Password
    [Arguments]    ${password}
    Fill Text      ${PASSWORD_FIELD}    ${password}

Click Login
    Click    ${LOGIN_BUTTON}

Verify Login Successful
    Wait For Elements State    ${SHOPPING_CART}    visible

Verify Login Failed
    Wait For Elements State    ${LOGIN_ERROR}      visible
    Wait For Elements State    ${SHOPPING_CART}    detached
