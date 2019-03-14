#!/bin/sh
docker rmi -f $(docker images -f "dangling=true" -q)
docker rmi opentheso --force