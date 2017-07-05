#!/bin/bash
APP_NAME='developer-tools'
clear &&
echo "=== install ${APP_NAME} ===" &&
install -t ${prefix}/bin src/*
clear &&
echo "=== ${APP_NAME} is successfully installed to ${prefix} ==="
