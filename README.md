# kong-ma-plugin
Mutual authentication Plugin for kong

This plugin will verify the thumbprint sent in the client certificate during the SSL handshake.
For this to work, you need to either:

1. Add another nginx server block which sets the "ssl_verify_client" to an applicaple value
2. set the "ssl_verify_client" in the main kong server block.


For example, in the kong default section:
```nginx
server {
    server_name kong;
    listen 0.0.0.0:8000 reuseport backlog=16384;
    listen 0.0.0.0:8443 ssl http2 reuseport backlog=16384;

    error_page 400 404 408 411 412 413 414 417 494 /kong_error_handler;
    error_page 500 502 503 504                     /kong_error_handler;

    access_log /dev/stdout;
    error_log  /dev/stderr notice;

    ssl_certificate     /usr/local/kong/ssl/kong-default.crt;
    ssl_certificate_key /usr/local/kong/ssl/kong-default.key;
    ssl_client_certificate /usr/local/kong/ssl/ca.pem;
    # Use optional to also allow non MA calls
    # Pay attention that some browsers might popup the client to present a certificate
    ssl_verify_client optional;
    ssl_verify_depth 3;



    ssl_session_cache   shared:SSL:10m;
    ssl_certificate_by_lua_block {
        Kong.ssl_certificate()
    }
```


For example, adding another nginx-ma.conf:
```nginx
server {
    server_name kong-ma;
    listen 0.0.0.0:9000 reuseport backlog=16384;
    listen 0.0.0.0:9443 ssl http2 reuseport backlog=16384;

    error_page 400 404 408 411 412 413 414 417 494 /kong_error_handler;
    error_page 500 502 503 504                     /kong_error_handler;

    access_log /dev/stdout;
    error_log  /dev/stderr notice;

    ssl_certificate     /usr/local/kong/ssl/kong-default.crt;
    ssl_certificate_key /usr/local/kong/ssl/kong-default.key;
    ssl_client_certificate /usr/local/kong/ssl/ca.pem;
    # Use optional or  to also allow non MA calls
    ssl_verify_client optional;
    ssl_verify_depth 3;



    ssl_session_cache   shared:SSL:10m;
    ssl_certificate_by_lua_block {
        Kong.ssl_certificate()
    }
```
