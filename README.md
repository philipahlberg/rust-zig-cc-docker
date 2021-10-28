# rust-zig-cc-docker

The image takes three arguments:
- `TARGET`: A target triple (in Rust format) (default: `x86_64-unknown-linux-gnu`).
    - The Dockerfile supports `{aarch64, x86_64}-unknown-linux-{gnu,musl}`.
- `ZIG_TOOLCHAIN`: The Zig version to use (default: `zig-linux-aarch64-0.9.0-dev.1444+e2a2e6c14`)
- `RUST_TOOLCHAIN`: The Rust version to use (default: `nightly`)

To build the image:

```
docker build --tag <name> --build-arg TARGET=<target>  .
```
