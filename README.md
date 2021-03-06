# psimp

This is an attempt to extract PureScript's CoreImp AST for dynamically typed imperative languages.

It is based on a past [coreimp work](https://github.com/purescript/purescript/tree/core-imp/src/Language/PureScript/CoreImp)

The design concept is to provide a simpler [AST](./src/CoreImp/AST.purs) rather than performance considerations.

Transpile target languages:

- Lua
- Dart
- JavaScript

## Requirements

- spago
- purescript
- node ✅v14.4.0
- lua ✅v5.3.5
- dart ✅v2.8.4

## Code Generation

Generate [example](./example) modules' `corefn.json` files.

```
spago -x example.dhall build --purs-args "-g corefn"
```

### Lua

Generate Lua files to `./outlua`

```
spago -x spago_lua.dhall run
```

Copy FFI files (manually for now) from [pslua-ffi](https://github.com/opyapeus/pslua-ffi)

```
cp -r [clonedir]/pslua-ffi/effect/* ./outlua
cp -r [clonedir]/pslua-ffi/console/* ./outlua
cp -r [clonedir]/pslua-ffi/prelude/* ./outlua
```

Run

```
LUA_PATH=outlua/?.lua lua main.lua
```

### Dart

Generate Dart files to `./outdart`

```
spago -x spago_dart.dhall run
```

Copy FFI files (manually for now) from [psdart-ffi](https://github.com/opyapeus/psdart-ffi)

```
cp -r [clonedir]/psdart-ffi/effect/* ./outdart
cp -r [clonedir]/psdart-ffi/console/* ./outdart
cp -r [clonedir]/psdart-ffi/prelude/* ./outdart
```

Run

```
dart main.dart
```

### JavaScript

Generate JavaScript files to `./outjs` (FFI files copied from `./output`)

```
spago -x spago_js.dhall run
```

Run

```
node main.js
```

## Memo

It is not cut out as a library for now, but is a monorepo to modify and check the model easily.
