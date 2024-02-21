*** Settings ***
Documentation     A test suite for testing inventory and shopping cart functionalities.

Resource          ${CURDIR}${/}..${/}resources${/}common.robot

Test Setup        Run Keywords
...               Open Browser Page    AND    Login As User
Test Teardown     Close All Browsers


*** Test Cases ***
Test Adding A Backpack to Cart
    [Tags]             cart    backpack
    Click Add To Cart    backpack
    Click Shopping Cart
    Verify Item Clicked To Shopping Cart    backpack
    Verify Shopping Cart Content    Backpack
