#!/bin/bash

gcloud compute instances create reddit-full\
  --image-family reddit-full \
  --tags puma-server \
  --zone=europe-west1-d \
  --restart-on-failure
