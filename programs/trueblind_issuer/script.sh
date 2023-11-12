# Deployer
#   Private Key  APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs
#      View Key  AViewKey1iKKSsdnatHcm27goNC7SJxhqQrma1zkq91dfwBdxiADq
#       Address  aleo12ux3gdauck0v60westgcpqj7v8rrcr3v346e4jtq04q7kkt22czsh808v2

# curl http://localhost:3030/testnet3/program/credits.aleo/mapping/account/aleo158m35rhjzjaejtxhgkrrlu222qlzs706fnkgzlxuyua2wf94qgzs8twkv5

# snarkos developer execute --private-key APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --query http://localhost:3030 \
# credits.aleo transfer_public "aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw" "10000000u64" \
# --broadcast http://localhost:3030/testnet3/transaction/broadcast

# snarkos developer execute --private-key APrivateKey1zkpDZLpPdRhc2xNgyhbgPB7LY2KCfk1Yakn1RVwtaAEQAqe --query http://localhost:3030 \
# trueblind_issuer.aleo issue_pass "aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw" "1u8" \
# --broadcast http://localhost:3030/testnet3/transaction/broadcast

# snarkos developer execute --private-key APrivateKey1zkpDZLpPdRhc2xNgyhbgPB7LY2KCfk1Yakn1RVwtaAEQAqe --query http://localhost:3030 \
# trueblind_main.aleo create_post "{cid1: 123u128, cid2: 123u128}" "{  owner: aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw.private,  nationality: 1u8.private,  _nonce: 1564614991281123962695223059637551685382856085360622053844895040496964281484group.public}" \
# --broadcast http://localhost:3030/testnet3/transaction/broadcast

# snarkos developer scan --endpoint http://localhost:3030 -p APrivateKey1zkpDZLpPdRhc2xNgyhbgPB7LY2KCfk1Yakn1RVwtaAEQAqe --last 100

# snarkos developer execute --private-key APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --query http://localhost:3030 \
# trueblind_main1.aleo create_post "12312u128" "{owner: aleo12ux3gdauck0v60westgcpqj7v8rrcr3v346e4jtq04q7kkt22czsh808v2.private,  nationality: 1u8.private,  _nonce: 7907199623440547124236820357007106905149925813494723661914192483174248098279group.public}" \
# --broadcast http://localhost:3030/testnet3/transaction/broadcast

# snarkos developer deploy --private-key APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --query http://localhost:3030 --priority-fee 1 trueblind_issuer.aleo --broadcast http://localhost:3030/testnet3/transaction/broadcast --path ./build/
# snarkos developer deploy --private-key APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --query http://localhost:3030 --priority-fee 1 trueblind_main.aleo --broadcast http://localhost:3030/testnet3/transaction/broadcast --path ./build/