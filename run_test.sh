#!/bin/bash
stack build
stack exec aeson-test-exe > frontend/src/Main.js
pushd .
cd frontend
pulp build
pulp run
popd
