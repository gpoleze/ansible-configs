#!/bin/bash

echo "Stopping the pihole container"
docker stop pihole

echo "Removing the pihole container"
docker rm pihole