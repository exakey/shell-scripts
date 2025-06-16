#!/usr/bin/env sh

for i in $(seq 1 5); do
        openssl rand -base64 20
done
