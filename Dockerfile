FROM debian:11-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    musl-tools \
    musl-dev \
    musl \
    make \
    xz-utils \
    curl

ARG TARGET=aarch64-unknown-linux-musl

# Set up Zig
ENV ZIG_HOME=/usr/local/zig \
    PATH=/usr/local/zig:$PATH

ARG ZIG_TOOLCHAIN=zig-linux-aarch64-0.9.0-dev.1444+e2a2e6c14
RUN curl https://ziglang.org/builds/$ZIG_TOOLCHAIN.tar.xz | tar xJ && \
    mv $ZIG_TOOLCHAIN/ $ZIG_HOME && \
    chmod +x $ZIG_HOME/zig

# Set up Rust
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

ARG RUST_TOOLCHAIN=nightly
RUN curl https://sh.rustup.rs -sSf | sh -s -- \
    --profile minimal --default-toolchain "$RUST_TOOLCHAIN" -y && \
    rustup target add $TARGET && \
    rustup default $RUST_TOOLCHAIN-$TARGET

# Set up Cargo/Zig interop
COPY tools/$TARGET/zig $ZIG_HOME/
COPY tools/$TARGET/cargo $CARGO_HOME/

WORKDIR /project

COPY src src/
COPY Cargo.toml .
COPY Cargo.lock .
