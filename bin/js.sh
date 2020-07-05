#!/usr/bin/env bash

# It seems that purs-0.13.8 doesn't recompile corefn.json files
rm output/CodeGen.JS/corefn.json
rm output/CodeGen.JS.AST/corefn.json
rm output/CodeGen.JS.Common/corefn.json
rm output/CodeGen.JS.Printer/corefn.json

spago -x spago_js.dhall build --purs-args "-g corefn"
spago -x spago_js.dhall run

rm -fr compiledjs
mv outjs compiledjs

node -e "require('./compiledjs/Main').main()"
