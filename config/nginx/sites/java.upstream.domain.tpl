#-------------------------------------------
#java 站点 负载模板配置文件，将_DOMAIN_替换成相应的域名,_PORT_ 替换成对应的端口
#-------------------------------------------

upstream read_imhuzi_net {
     server _IP_:_PORT_
}

server{
   listen 80;
   server_name _DOMAIN_ www._DOMAIN_;
   root   html;
   index  index.html index.htm;

   location / {
      #proxy settings
      proxy_pass http://read_imhuzi_net;
      proxy_redirect  off;
      proxy_set_header    Host            $host;
      proxy_set_header    X-Real-IP       $remote_addr;
      proxy_set_header    X-Forwarded-for $proxy_add_x_forwarded_for; 
      proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
      proxy_max_temp_file_size 0;
      proxy_connect_timeout      90;
      proxy_send_timeout         90;
      proxy_read_timeout         90;
      proxy_buffer_size          4k;
      proxy_buffers              4 32k;
      proxy_busy_buffers_size    64k;
      proxy_temp_file_write_size 64k;
   }
}
