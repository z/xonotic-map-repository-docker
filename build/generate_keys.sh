#!/bin/bash

KEY_FILE=containers/web/id_rsa
cd $(dirname $0)
rm ${KEY_FILE}
rm ${KEY_FILE}.pub
rm containers/api/authorized_keys
ssh-keygen -f $KEY_FILE -t rsa -N ''
cat ${KEY_FILE}.pub > containers/api/authorized_keys