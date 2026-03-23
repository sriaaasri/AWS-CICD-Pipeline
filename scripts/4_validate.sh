#!/bin/bash

echo "Validating application status."

if [[ -n $(pgrep java) ]]; then
        echo "Application started successfully"
else
     echo "Application not Started"
fi

