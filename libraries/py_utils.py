import re


def get_reg_exp_match(pattern, string):
    match = re.search(pattern, string, re.IGNORECASE)
    title = match.group(1) if match else None
    return title
