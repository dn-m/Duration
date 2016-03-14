#!/bin/bash

jazzy \
  --clean \
  --author James Bean \
  --author_url http://jamesbean.info \
  --github_url https://github.com/dn-m/IntervalTools \
  --module-version 0.2 \
  --module IntervalTools \
  --root-url https://dn-m.github.io \
  --output ../site/IntervalTools \
  --skip-undocumented \
  --hide-documentation-coverage \
  --theme fullwidth
