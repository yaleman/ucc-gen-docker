# ucc-gen-docker

A simple Dockerfile for running the [Splunk UCC Framework](https://splunk.github.io/addonfactory-ucc-generator/) in a container.

## Building with another version of the package

If you're testing another version, you can run it like this:

```bash
docker build -t ucc-gen-docker . \
    --build-arg="UCC_PACKAGE=git+https://github.com/yaleman/addonfactory-ucc-generator@openapi-schema-fix-multi-input"
```

Or as a make command:

```shell
UCC_PACKAGE='git+https://github.com/yaleman/addonfactory-ucc-generator@openapi-schema-fix-multi-input' \
make build
```
