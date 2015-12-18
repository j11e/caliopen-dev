#!/usr/bin/env bash

# Load local variables
if [ -f caliopen.env ]; then
    echo "Loading env from caliopen.env"
    source caliopen.env
fi

# All backends components
CALIOPEN_COMPONENTS="base base.user base.message api.base api.user api.message api messaging smtp web cli web-client-ng"

# Default values that can be overidden in a cassandra.env file
DEFAULT_BASE_URL="https://github.com/CaliOpen"
DEFAULT_LOCAL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"


# Set BASE_URL LOCAL_DIR
[[ -z "${BASE_URL}" ]] && BASE_URL="${DEFAULT_BASE_URL}"
[[ -z "${LOCAL_DIR}" ]] && LOCAL_DIR="${DEFAULT_LOCAL_DIR}"

CALIOPEN_DIR="${LOCAL_DIR}"

export BASE_URL CALIOPEN_DIR CALIOPEN_COMPONENTS
