#!/bin/bash
set -eo pipefail

DATE=$(date +"%Y-%m-%d_%H-%M")
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
variable_file="./environments/default_env.py"
browser="chromium"
docker=false
robot_container_name="robotfw"
tests_path="."
tests_tag=""
preserve_results=true
headless=False
robot_command=""
log_level="INFO"

cd ${SCRIPT_DIR}

function run_robot() {
    robot \
        --variablefile ${variable_file} \
        --variable BROWSER:${browser} \
        --skip skip \
        --pythonpath ${SCRIPT_DIR} \
        --variable HEADLESS:${headless} \
        ${tests_tag} \
        --loglevel=${log_level} \
        --listener allure_robotframework:results/${DATE}/allure \
        -d results/${DATE} \
        -x outputxunit.xml \
        -o TestRun.xml \
        -l TestRun.html \
        -r TestReport.html \
        ${tests_path}
}

while getopts "d:b:t:pil:h" opt; do
  case $opt in
    d)
        tests_path="$OPTARG"
        ;;
    b)
        browser="$OPTARG"
        ;;
    t)
        tests_tag="--include $OPTARG"
        ;;
    p)
        preserve_results=false
        ;;
    i)
        headless=True
        ;;
    l)
        log_level="$OPTARG"
        ;;
    \?)
        echo "Invalid Option -${OPTARG}" >&2
        exit 1
        ;;
    :)
        echo "Option ${OPTARG} requires an argument" >&2
        exit 1
        ;;
    h|*)
        echo "Usage: run_tests.sh [-d <tests_path>] [-b <browser>] [-t <tests_tag>] [-p] [-i] [-l <log_level>]"
        echo "Options:"
        echo "  -d <tests_path>    Path to the tests to run. Default: ."
        echo "  -b <browser>       Browser to run the tests on. Default: chromium"
        echo "  -t <tests_tag>     Tag to run the tests with. Default: ''"
        echo "  -p                 Preserve results folder. Default: true"
        echo "  -i                 Run tests in headless mode. Default: false"
        echo "  -l <log_level>     Log level for the tests. Default: INFO"
        echo "  -h                 Show this help message"
        exit 0
        ;;
  esac
done

# Delete results folder if preserve_results is false
if ! $preserve_results ; then
    echo "Deleting results folder"
    rm -rf results
fi

run_robot
