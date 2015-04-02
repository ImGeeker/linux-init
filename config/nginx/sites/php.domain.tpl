#-------------------------------------------
#php 站点 模板配置文件，将domain替换成相应的域名即可
#-------------------------------------------

server {
   listen       80;
   server_name  domain;
   root   /var/www/domain;
   index  index.html index.htm index.php;

   #charset koi8-r;

   access_log  logs/domain.access.log;

   #error_page  404              /404.html;

   # redirect server error pages to the static page /50x.html
   #
   error_page   500 502 503 504  /50x.html;
   location = /50x.html {
       root   html;
   }

   # proxy the PHP scripts to Apache listening on 127.0.0.1:80
   #
   #location ~ \.php$ {
   #    proxy_pass   http://127.0.0.1;
   #}

   location ~ /\. {
           deny all;
           access_log off;
           log_not_found off;
   }

   # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
   #


   location ~ \.php$ {
       fastcgi_buffers 2 256k;
       fastcgi_buffer_size 128K;
       fastcgi_busy_buffers_size 256K;
       fastcgi_temp_file_write_size 256k;
       fastcgi_connect_timeout 3000;
       fastcgi_send_timeout 3000;
       fastcgi_read_timeout 3000;
       fastcgi_pass   127.0.0.1:9000;
       fastcgi_index  index.php;
       #fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
       fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
       include        fastcgi_params;
   }


   # deny access to .htaccess files, if Apache's document root
   # concurs with nginx's one
   #
   location ~ /\.ht {
       deny  all;
   }

   location ~ /\.git {
       deny  all;
   }
}
