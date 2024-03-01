*** Settings ***
Documentation    A resource file with reusable keywords for the inventory page.

Resource         common.robot


*** Variables ***
${ADD_TO_CART_PATH}    \#add-to-cart-sauce-labs
${REMOVE_ITEM_PATH}    \#remove-sauce-labs
${SHOPPING_CART}       \#shopping_cart_container


*** Keywords ***
Click Add To Cart
    [Arguments]    ${item_name}
    Click    ${ADD_TO_CART_PATH}-${item_name}

Click Shopping Cart
    Click    ${SHOPPING_CART}

Verify Item Clicked To Shopping Cart
    [Arguments]    ${item_name}
    Wait For Elements State    ${REMOVE_ITEM_PATH}-${item_name}    visible

Verify Shopping Cart Content
    [Arguments]    ${item_name}
    Wait For Elements State    //div[@class="inventory_item_name" and contains(text(), '${item_name}')]    visible
