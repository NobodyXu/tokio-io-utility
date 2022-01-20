#!/bin/bash -ex

cargo test --all-features -- --nocapture

export RUSTFLAGS='-Zsanitizer=address'
cargo +nightly test --all-features async_read_utility::tests::test -- --nocapture
cargo +nightly test --all-features queue -- --nocapture

# Disable thread sanitizer for it often provides false positive.
#
#export RUSTFLAGS='-Zsanitizer=thread' 
#
#for _ in $(seq 1 10); do
#    cargo +nightly test \
#        -Z build-std \
#        --target $(uname -m)-unknown-linux-gnu \
#        --all-features queue::tests::test_par -- --nocapture
#done

unset RUSTFLAGS
export MIRIFLAGS="-Zmiri-disable-isolation"
exec cargo +nightly miri test \
    -Z build-std \
    --target $(uname -m)-unknown-linux-gnu \
    --all-features queue -- --nocapture
