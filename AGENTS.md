# AGENTS.md

## Cursor Cloud specific instructions

`Dart_LSP_Client` (package name `lsp_client`) is a **pure-Dart** Language Server
Protocol client — JSON-RPC 2.0 over stdio with `Content-Length` framing, zero
Flutter dependency. It is the standalone upstream of the `packages/lsp_client`
copy vendored inside the `krom` editor. Public API entry point: `LspClient`
(`lib/lsp_client.dart`) with lifecycle, text sync, diagnostics, completion,
hover, definition, references, rename, formatting, and symbols.

### Toolchain (already installed in the VM snapshot)

- Dart `3.12.2` (shipped with Flutter `3.44.5` at `~/flutter/bin`, on `PATH` via
  `~/.bashrc`). The package only needs `dart >=3.0.0` — no Flutter, no other
  system deps.

### Commands

- Dependencies: `dart pub get`.
- Lint: `dart analyze`.
- Test: `dart test`.

### End-to-end smoke test

The client can drive the real Dart language server bundled with the SDK. From a
throwaway project that depends on this package by path, this exercises the full
stack (spawn → `initialize` → `didOpen` → diagnostics/hover/symbols → `shutdown`):

```dart
final client = await LspClient.start(
  serverCommand: [Platform.resolvedExecutable, 'language-server', '--protocol=lsp'],
  rootUri: Uri.directory('/path/to/dart/project').toString(),
);
client.diagnostics.listen((p) => print(p.diagnostics));
await client.openDocument(uri: fileUri, languageId: 'dart', text: source);
final hover = await client.getHover(uri: fileUri, line: 1, character: 4);
await client.shutdown();
```

Opening a file that references an undefined symbol yields a published diagnostic;
`getHover` over a declaration returns its signature + doc comment.

### Non-obvious caveats

- Pre-existing test failure unrelated to the environment (do NOT "fix" as setup
  work): `dart test` reports 11/12 passing; "LspTransport framing encodes message
  with Content-Length header" fails because the test passes a `List<int>` to a
  `contains` matcher instead of an element. `dart analyze` is clean of errors
  (only `unused_*` warnings and `dangling_library_doc_comments` infos).
- `.gitignore` excludes `pubspec.lock` (it is a library), so `dart pub get` always
  re-resolves; that is expected and not a working-tree change to commit.
