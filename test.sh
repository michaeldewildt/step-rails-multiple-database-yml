#!/bin/bash

WERCKER_POSTGRESQL_HOST=localhost
WERCKER_STEP_ROOT=.
WERCKER_RAILS_MULTIPLE_DATABASE_YML_ADDITIONAL_DATABASES=apple,orange,grape

function debug() {
  echo $1
}
function info() {
  echo $1
}
function warn() {
  echo $1
}
function fail() {
  echo $1
}

rm -rf ./config
mkdir ./config

source ./run.sh

if ! test -f ./config/database.yml ; then
  echo "config/database.yml does not exist"
  echo "Test failed"
  exit 1
fi

if [ `ls config/ | wc -l | sed "s/ //g"` -ne 4 ] ; then
  echo "There is no 4 file"
  echo "Test failed"
  exit 1
fi

grep 'apple' config/apple_database.yml > /dev/null 2>&1

if [ $? -ne 0 ] ; then
  echo "content of config/apple_database.yml isn't correct"
  echo "Test failed"
  exit 1
fi

rm -r ./config

echo "Test passed"
