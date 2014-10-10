#!/bin/bash
function with_retry {
  local attempts=0
  local max_attempts=5
  local timeout=3

  while [[ $attempts < $max_attempts ]]; do
    "$@"

    if [[ $? == 0 ]]; then
      break
    fi

    sleep $timeout
    attempts=$((attempts + 1))
  done
}
