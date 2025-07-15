#!/bin/bash
# generate all bindings
set -e
cargo test export_bindings

# generate an index.ts
for f in bindings/*.ts ; do
  filename="${f#bindings/}"
  basename="${filename%.ts}"
  echo "export * from './models/$basename';"
done > ../src/lib/models.ts

mv -f bindings/*.ts ../src/lib/models/