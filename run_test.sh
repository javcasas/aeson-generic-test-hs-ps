#!/bin/bash
stack build
stack exec aeson-test-exe > frontend/src/Main.js
pushd .
cd frontend
PATH=node_modules/.bin/:$PATH
pulp build
pulp run
popd
