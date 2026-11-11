#!/bin/bash

read -p "Install lfs? (y/n) " -n 1 -r
echo   

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing..."
    sleep 5
    echo "partitoning"
    sleep 10
    echo "Resolving opsec dependencies or something"
    sleep 11
    echo "compiling el kernel"
    sleep 20
    echo "chrooting"
    sleep 2
    sleep 11
    echo "installing gnu emacs grub and subscribing your credit card for fsf"
    sleep 5
    echo "failed because fuck you"

    
else
    echo "aighto tighto"
    exit 1
fi
