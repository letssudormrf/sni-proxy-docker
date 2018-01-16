#!/bin/bash

SNI=($SNI)
SERVER=${SERVER:-'*'}
PORT=${PORT:-"443"}

if [ ! -d sniproxy ]; then
mkdir sniproxy
touch sniproxy/sniproxy.conf
cat > sniproxy/sniproxy.conf << EOF
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
	sed -i "16s/^/.* $SERVER:$PORT\n/" sniproxy/sniproxy.conf
fi

for i in ${SNI[@]};
do
	sed -i "16s/^/$i $SERVER:$PORT\n/" sniproxy/sniproxy.conf
done
fi

/usr/sbin/sniproxy -c sniproxy/sniproxy.conf -f
