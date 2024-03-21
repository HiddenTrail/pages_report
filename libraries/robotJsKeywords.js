

async function SelectOptionFromList(page, selector, type, option, logger) {
    logger(`Selecting option ${option} by ${type} from ${selector}`)
    const selectOption = {
        [type]: option
    }
    return await page.selectOption(selector, selectOption);
}

exports.__esModule = true;

SelectOptionFromList.rfdoc = `Selects option from dropdown list.
Use this keyword when BrowserLibray's own keyword does not work.
Takes three arguments:
1. selector
2. option type: 'labe', 'index', 'value'
3. option (by option type)`;
exports.SelectOptionFromList = SelectOptionFromList;
