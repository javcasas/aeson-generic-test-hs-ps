#!/bin/bash
stack build
stack exec aeson-test-exe > frontend/src/Main.exe
pushd .
cd frontend
pulp build
pulp run
popd
