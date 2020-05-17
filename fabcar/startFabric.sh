#!/bin/bash

set -e

# start timestamp
starttime=$(date +%s)
CC_SRC_LANGUAGE=${1:-"go"}
CC_SRC_LANGUAGE=`echo "$CC_SRC_LANGUAGE" | tr [:upper:] [:lower:]`
if [ "$CC_SRC_LANGUAGE" != "go" -a "$CC_SRC_LANGUAGE" != "golang" ] ; then
	echo The chaincode language ${CC_SRC_LANGUAGE} is not supported by this script
 	echo Supported chaincode languages is: go
 	exit 1
fi

# launch network; create channel and join peer to channel
pushd ./test-network
./network.sh down
./network.sh up createChannel -ca -s couchdb
./network.sh deployCC -l ${CC_SRC_LANGUAGE}
popd

cat <<EOF
Total setup execution time : $(($(date +%s) - starttime)) secs ...
EOF
