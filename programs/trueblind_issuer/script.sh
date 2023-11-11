# curl http://localhost:3030/testnet3/program/credits.aleo/mapping/account/aleo158m35rhjzjaejtxhgkrrlu222qlzs706fnkgzlxuyua2wf94qgzs8twkv5

# snarkos developer execute --private-key APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --query http://localhost:3030 \
# credits.aleo transfer_public "aleo158m35rhjzjaejtxhgkrrlu222qlzs706fnkgzlxuyua2wf94qgzs8twkv5" "10000000u64" \
# --broadcast http://localhost:3030/testnet3/transaction/broadcast

# snarkos developer execute --private-key APrivateKey1zkp8qFB2dFjiag8zwL7ntqoxHnK6WjrEbJ4Ubv7A9H8v2H9 --query http://localhost:3030 \
# trueblind_issuer.aleo issue_pass "aleo12ux3gdauck0v60westgcpqj7v8rrcr3v346e4jtq04q7kkt22czsh808v2" "1u8" \
# --broadcast http://localhost:3030/testnet3/transaction/broadcast

# snarkos developer scan --endpoint http://localhost:3030 -p APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --last 100

snarkos developer execute --private-key APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --query http://localhost:3030 \
trueblind_main1.aleo create_post "12312u128" "{owner: aleo12ux3gdauck0v60westgcpqj7v8rrcr3v346e4jtq04q7kkt22czsh808v2.private,  nationality: 1u8.private,  _nonce: 7907199623440547124236820357007106905149925813494723661914192483174248098279group.public}" \
--broadcast http://localhost:3030/testnet3/transaction/broadcast

# snarkos developer deploy --private-key APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --query http://localhost:3030 --priority-fee 1 trueblind_main1.aleo --broadcast http://localhost:3030/testnet3/transaction/broadcast --path ./build/