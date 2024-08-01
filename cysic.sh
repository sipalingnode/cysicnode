echo -e "\033[0;35m"
echo "====================================================="
echo "                  AIRDROP ASC                        "
echo "====================================================="
echo -e '\e[35mNode :\e[35m' CYSIC
echo -e '\e[35mTelegram Channel :\e[35m' @airdropasc
echo -e '\e[35mTelegram Group :\e[35m' @autosultan_group
echo "====================================================="
echo -e "\e[0m"

sleep 5

CYSIC_PATH="$HOME/cysic-verifier"

apt update && apt upgrade -y
apt install curl wget jq make gcc nano -y

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -

sleep 2

sudo apt-get install nodejs -y

sleep 2

sudo apt-get install npm -y

sleep 2

npm install pm2@latest -g

sleep 2

rm -rf $CYSIC_PATH
mkdir -p $CYSIC_PATH
cd $CYSIC_PATH

curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/verifier_linux > $CYSIC_PATH/verifier
curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/libzkp.so > $CYSIC_PATH/libzkp.so
  
read -p "Submit your eth address: " CLAIM_REWARD_ADDRESS

cat <<EOF > $CYSIC_PATH/config.yaml
chain:
  endpoint: "testnet-node-1.prover.xyz:9090"
  chain_id: "cysicmint_9000-1"
  gas_coin: "cysic"
  gas_price: 10
claim_reward_address: "$CLAIM_REWARD_ADDRESS"

server:
  cysic_endpoint: "https://api-testnet.prover.xyz"
EOF

chmod +x $CYSIC_PATH/verifier

cat << EOF > $CYSIC_PATH/start.sh
#!/bin/bash
export LD_LIBRARY_PATH=.:~/miniconda3/lib:$LD_LIBRARY_PATH
export CHAIN_ID=534352
$CYSIC_PATH/verifier
EOF

chmod +x $CYSIC_PATH/start.sh

pm2 start $CYSIC_PATH/start.sh --name "cysic-verifier"

echo -e "\033[0;35m"
echo "Done.... cek your log node 'pm2 logs cysic-verifier' "
echo -e "\e[0m"
