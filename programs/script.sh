#!/bin/bash

# Deployer
#   Private Key  APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs
#      View Key  AViewKey1iKKSsdnatHcm27goNC7SJxhqQrma1zkq91dfwBdxiADq
#       Address  aleo12ux3gdauck0v60westgcpqj7v8rrcr3v346e4jtq04q7kkt22czsh808v2

# Pass Holder
#   Private Key  APrivateKey1zkpDZLpPdRhc2xNgyhbgPB7LY2KCfk1Yakn1RVwtaAEQAqe
#      View Key  AViewKey1etkQbHePLByd9VqxLwey99nn6GHU8Xi13MT6y6MxYGpz
#       Address  aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw


echo "============Deploying==============="
snarkos developer deploy --private-key APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --query http://localhost:3030 --priority-fee 1 trueblind_issuer.aleo --broadcast http://localhost:3030/testnet3/transaction/broadcast --path ./trueblind_issuer/build/
sleep 5
snarkos developer deploy --private-key APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --query http://localhost:3030 --priority-fee 1 trueblind_main.aleo --broadcast http://localhost:3030/testnet3/transaction/broadcast --path ./trueblind_main/build/

echo "=============Balance==============="
curl http://localhost:3030/testnet3/program/credits.aleo/mapping/account/aleo12ux3gdauck0v60westgcpqj7v8rrcr3v346e4jtq04q7kkt22czsh808v2
echo -e "\n"

echo "==========Send credits to Account2==========="
snarkos developer execute --private-key APrivateKey1zkpBjpEgLo4arVUkQmcLdKQMiAKGaHAQVVwmF8HQby8vdYs --query http://localhost:3030 \
credits.aleo transfer_public "aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw" "50000000u64" \
--broadcast http://localhost:3030/testnet3/transaction/broadcast


echo "=============Issue Pass============="
snarkos developer execute --private-key APrivateKey1zkpDZLpPdRhc2xNgyhbgPB7LY2KCfk1Yakn1RVwtaAEQAqe --query http://localhost:3030 \
trueblind_issuer.aleo issue_pass "aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw" "1111111u128" "20u8" "1u8" \
--broadcast http://localhost:3030/testnet3/transaction/broadcast

sleep 5
echo "===========Scan for Pass==============="
snarkos developer scan --endpoint http://localhost:3030 -p APrivateKey1zkpDZLpPdRhc2xNgyhbgPB7LY2KCfk1Yakn1RVwtaAEQAqe --last 50

echo "==============Create new post==============="
snarkos developer execute --private-key APrivateKey1zkpDZLpPdRhc2xNgyhbgPB7LY2KCfk1Yakn1RVwtaAEQAqe --query http://localhost:3030 \
trueblind_main.aleo create_post "{cid1: 123u128, cid2: 123u128, cid3: 123u128}" "{  owner: aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw.private,  name: 1111111u128.private,  age: 20u8.private,  nationality: 1u8.private,  _nonce: 6456097367445658243339986038420342053679777357066623145546704307206142895783group.public}" \
--broadcast http://localhost:3030/testnet3/transaction/broadcast

sleep 5
echo "=============Check Post CID Mapping==============="
curl http://localhost:3030/testnet3/program/trueblind_main.aleo/mapping/post/0u128
echo -e "\n"

snarkos developer execute --private-key APrivateKey1zkpDZLpPdRhc2xNgyhbgPB7LY2KCfk1Yakn1RVwtaAEQAqe --query http://localhost:3030 \
trueblind_main.aleo make_comment "{cid1: 22222u128, cid2: 222u128, cid3: 222u128}" "{cid1: 333u128, cid2: 333u128, cid3: 333u128}" "{  owner: aleo1fjmx66zrmfxx288udrw93re4x9xvxkuszwuegmf78prt3shc2yrscf6shw.private,  name: 1111111u128.private,  age: 21u8.private,  nationality: 1u8.private,  _nonce: 6456097367445658243339986038420342053679777357066623145546704307206142895783group.public}" \
--broadcast http://localhost:3030/testnet3/transaction/broadcast

echo "=============Get Post CID Hash as Comments Mapping Key==========="
snarkos developer execute --private-key APrivateKey1zkpDZLpPdRhc2xNgyhbgPB7LY2KCfk1Yakn1RVwtaAEQAqe --query http://localhost:3030 \
trueblind_main.aleo hash_cid "{cid1: 22222u128, cid2: 222u128, cid3: 222u128}" \
--dry-run
echo -e "\n"

echo "=============Check Comment CID Mapping==============="
curl http://localhost:3030/testnet3/program/trueblind_main.aleo/mapping/comments/1291740641244552686073320084972790728354423795839154790404362830682964610904field
echo -e "\n"