#!/bin/sh

for i in */Dockerfile ; do ct=$(echo $i|cut -f1 -d'/'); echo "### BULDING $ct ###"; docker build -t tcaxias/$ct $ct ; done
for i in */*/Dockerfile ; do ct=$(echo $i|cut -f1-2 -d'/'); echo "### BULDING $ct ###"; docker build -t tcaxias/$(echo $ct|sed 's#/#:#') $ct ; done
