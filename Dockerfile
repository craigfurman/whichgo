FROM ubuntu:trusty

RUN apt-get update && apt-get install -y git gcc libc6-dev
