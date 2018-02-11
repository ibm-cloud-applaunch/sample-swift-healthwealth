#!/bin/bash
#
# Copyright 2018 IBM Corp. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the “License”);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an “AS IS” BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# load configuration variables
source local.env

function usage() {
  echo "Usage: $0 [--install,--uninstall,--recycle,--env]"
}

function install() {
  echo "Installing..."
  echo "Creating database..."
  curl $CLOUDANT_URL/$PACKAGE_NAME -X PUT
  
  echo "Inserting database design documents..."
  # # ignore "document already exists error"
  curl -s -X POST -H 'Content-Type: application/json' -d @cloudant-docs/doctors.json $CLOUDANT_URL/$PACKAGE_NAME | grep -v conflict
  curl -s -X POST -H 'Content-Type: application/json' -d @cloudant-docs/getimages.json $CLOUDANT_URL/$PACKAGE_NAME | grep -v conflict

}

function update() {
  echo "updating..."
  uninstall
  install
}

function uninstall() {
  echo "Deleting database..."
  curl $CLOUDANT_URL/$PACKAGE_NAME -X DELETE
}

function showenv() {
  echo "PACKAGE_NAME=$PACKAGE_NAME"
  echo "CLOUDANT_URL=$CLOUDANT_URL"
}

case "$1" in
"--install" )
install
;;
"--uninstall" )
uninstall
;;
"--update" )
update
;;
"--env" )
showenv
;;
* )
usage
;;
esac
