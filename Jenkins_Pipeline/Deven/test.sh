#!/bin/bash 

# Works ✅
function test() {
    pod \
    repo \
    list 
}

# test


cmd="pod repo list"
echo "cmd : ${cmd}"
source $cmd