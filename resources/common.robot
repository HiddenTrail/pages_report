*** Settings ***
Documentation    Common variables and keywords for all tests

Library          ${CURDIR}${/}..${/}libraries${/}py_utils.py
Library          Browser    jsextension=${CURDIR}${/}..${/}libraries${/}robotJsKeywords.js

Resource         login_page.robot
Resource         inventory_page.robot


*** Variables ***
${BROWSER}                chromium
${HEADLESS}               False
${VIEWPORT}               {'width': 1920, 'height': 1080}
${ADDITIONAL_ARGS}        ['--ignore-certificate-errors','--ignore-certificate-errors-spki-list']
${IGNORE_HTTPS_ERRORS}    True
${SLOWMO}                 0:00:00

${BASE_URL}               https://www.saucedemo.com/
${TIMEOUT}                30s

${STANDARD_USER}          standard_user
${STANDARD_PASSWORD}      secret_sauce


*** Keywords ***
Open Browser Page
    [Arguments]     ${url}=${BASE_URL}
    IF    '${BROWSER}'=='webkit'
        ${ADDITIONAL_ARGS}=    Set Variable    ${None}
    END
    New Browser
    ...    browser=${BROWSER}
    ...    headless=${HEADLESS}
    ...    args=${ADDITIONAL_ARGS}
    ...    slowMo=${SLOWMO}
    New Context    viewport=${VIEWPORT}    ignoreHTTPSErrors=${IGNORE_HTTPS_ERRORS}
    New Page       ${url}
    Set Browser Timeout    ${TIMEOUT}

Close All Browsers
    Close Browser    ALL

