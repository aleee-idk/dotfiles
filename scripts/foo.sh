#!/bin/bash

pid="$(pidof -x $(basename $0) -o $$)"
if [[ $? -eq 0 ]]; then
    echo "another instance running"
    kill $pid
else
    echo "First run"
fi



while true; do
    sleep 1s
done
