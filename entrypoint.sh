#!/bin/bash

SNI=($SNI)
SERVER=${SERVER:-'*'}
PORT=${PORT:-"443"}

mkdir -p /tmp/sniproxy/
touch /tmp/sniproxy/sniproxy.conf
cat > /tmp/sniproxy/sniproxy.conf << EOF
pidfile /tmp/sniproxy/sniproxy.pid

error_log {
        filename /tmp/sniproxy/error.log
        priority notice
}

listener 0.0.0.0 8443 {
        proto tls
        access_log {
                filename /tmp/sniproxy/access.log
        }
}

table {
}
EOF

if [ "$SNI" == "" ];then
	sed -i "16s/^/.* $SERVER:$PORT\n/" /tmp/sniproxy/sniproxy.conf
fi

for i in ${SNI[@]};
do
	sed -i "16s/^/$i $SERVER:$PORT\n/" /tmp/sniproxy/sniproxy.conf
done

/usr/sbin/sniproxy -c /tmp/sniproxy/sniproxy.conf -f
