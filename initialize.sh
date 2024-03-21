#!/bin/bash


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
NODE_INSTALLED=false
PYTHON_INSTALLED=false

robot_tests_folder=$SCRIPT_DIR/tests
robot_resources_folder=$SCRIPT_DIR/resources
robot_libraries_folder=$SCRIPT_DIR/libraries
robot_environments_folder=$SCRIPT_DIR/environments
robot_results_folder=$SCRIPT_DIR/results


cd $SCRIPT_DIR

# Create folders if they don't exist
# This is only fro when starting from the scratch
mkdir -p $robot_tests_folder
mkdir -p $robot_resources_folder
mkdir -p $robot_libraries_folder
mkdir -p $robot_results_folder
# ------------------------------

# Check if Python is installed and store the value in PYTHON_INSTALLED
if [ -x "$(command -v python3)" ]; then
    PYTHON_INSTALLED=true
fi

# Check if Node.js is installed and store the value in NODE_INSTALLED
if [ -x "$(command -v node)" ]; then
    NODE_INSTALLED=true
fi

# Check if using windows or linux
if [[ "$OSTYPE" == "msys" ]]; then
    # Windows
    # If Python is not installed, install it
    if [ $PYTHON_INSTALLED = false ]; then
        choco install python -y && \
        refreshenv && \
        python -m pip install -U pip
    fi
    # Set the path to the virtual environment
    username=$(whoami)
    python_virtual_env_path=C/users/$username/.virtualenvs/pages_report/Scripts
    # If node is not installed, install it
    if [ $NODE_INSTALLED = false ]; then
        choco install nodejs -y && \
        refreshenv
    fi
else
    # Linux
    # If Python is not installed, install it
    if [ $PYTHON_INSTALLED = false ]; then
        yes | brew install python3
    fi
    python_virtual_env_path=~/.virtualenvs/pages_report/bin
    # If node is not installed, install it
    if [ $NODE_INSTALLED = false ]; then
        yes | brew install node
    fi
fi

# Check if the virtual environment exists. If not, create it
if [ ! -d $python_virtual_env_path ]; then
    echo "Creating virtual environment"
    python3 -m venv $python_virtual_env_path
fi

# Check if virtual environment is activated. If not, activate it
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Activating virtual environment"
    source "$python_virtual_env_path/activate"
fi

# Install required python packages
pip install -r requirements.txt

rfbrowser clean-node
rfbrowser init
