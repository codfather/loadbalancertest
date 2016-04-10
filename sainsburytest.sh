#!/bin/bash
rm app-servers web-servers 
# Instantiate cloud instances using Ruby scripts
./createdroplet.rb -n app
./createdroplet.rb -n app2
./createdroplet.rb -n web
echo "Waiting for VM's to fully start"
sleep 30
./lstdroplets.rb
./lstdroplets.rb | grep app | awk '{print $8}' >> app-servers
./lstdroplets.rb | grep web | awk '{print $8}' >> web-servers
sleep 5
echo "Installing code to the new servers"
count=1
for i in `cat app-servers`
do
        IP[$count]=${i}
	scp -o StrictHostKeyChecking=no app-install.sh root@$i:~ 
	scp -o StrictHostKeyChecking=no app-chef-code.tar root@$i:~
	scp -o StrictHostKeyChecking=no go-code.go root@$i:~
	ssh -o StrictHostKeyChecking=no root@$i -C "chmod +x /root/app-install.sh ; /root/app-install.sh > install-log 2>1&"
       	#ssh -o StrictHostKeyChecking=no root@$i
	((count+=1))
done
cat <<EOF > load-balancer.conf 
upstream myapp1 {
    least_conn;
    server ${IP[1]}:8484;
    server ${IP[2]}:8484;
     }

server {
     listen 80;
 
     location / {
      proxy_pass http://myapp1;
        }
}

EOF
for i in `cat web-servers`
do
	scp -o StrictHostKeyChecking=no web-install.sh root@$i:~ 
	scp -o StrictHostKeyChecking=no web-chef-code.tar root@$i:~
	scp -o StrictHostKeyChecking=no load-balancer.conf root@$i:~
	ssh -o StrictHostKeyChecking=no root@$i -C "chmod +x /root/web-install.sh ; /root/web-install.sh > install-log 2>1&"
       	#ssh -o StrictHostKeyChecking=no root@$i
done
echo "Waiting for Web server code to launch and set up Load Balancer"
echo "This can take up to a minute at slow times on the service - so please be patient"
sleep 60
echo "**************************************"
echo "IP address of web server to test `cat web-servers`"
echo "**************************************"
