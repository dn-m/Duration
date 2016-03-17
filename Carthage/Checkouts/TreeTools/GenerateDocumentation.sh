#!/bin/bash

jazzy \
  --clean \
  --author James Bean \
  --author_url http://jamesbean.info \
  --github_url https://github.com/dn-m/TreeTools \
  --module-version 0.1 \
  --module TreeTools \
  --root-url https://dn-m.github.io \
  --output ../site/TreeTools \
  --skip-undocumented \
  --hide-documentation-coverage \
  --theme fullwidth
