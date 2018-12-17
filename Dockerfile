FROM  ekidd/rust-musl-builder as builder

WORKDIR /home/rust/iron_api_test

ENV USER=rust

RUN sudo chown -R rust:rust .

RUN cargo init

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

RUN cargo fetch

RUN cargo build --release

COPY . .

RUN rm target/x86_64-unknown-linux-musl/release/deps/iron_api_test*

RUN cargo build --release

FROM scratch

WORKDIR /usr/src/iron_api_test

COPY --from=builder /home/rust/iron_api_test/target/x86_64-unknown-linux-musl/release/iron_api_test .

EXPOSE 3000

ENTRYPOINT ["./iron_api_test"]
