# sni-proxy-docker

Quick Start
-----------

For docker run command.

    docker run -d -p 443:8443/tcp --name sni-proxy-docker letssudormrf/sni-proxy-docker

Keep the Docker container running automatically after starting, add **--restart always**.

    docker run --restart always -d -p 443:8443/tcp --name sni-proxy-docker letssudormrf/sni-proxy-docker

For specified multi-domain, use -e SNI="(.*.|)example.com (.*.|)example.com.org".

    docker run --restart always -d -p 443:8443/tcp -e SNI="(.*.|)example.com (.*.|)example.com.org" --name sni-proxy-docker letssudormrf/sni-proxy-docker
