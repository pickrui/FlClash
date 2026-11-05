These public, test-only CA/server certificates and the server private key are
used solely by loopback HTTPS regression tests and are never used in builds.
The server certificate names api.test and expires in September 2027; regenerate
this fixture with a test CA before that date. Keep its validity at 365 days to
remain compatible with platform TLS certificate validation. The CA expires in
September 2036. No CA private key is retained.
