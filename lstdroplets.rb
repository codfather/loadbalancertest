#!/Users/nickhadd/.rvm/rubies/ruby-2.1.0/bin/ruby

require 'droplet_kit'
require 'json'
require 'awesome_print'
token=ENV['Oauth_key']
client = DropletKit::Client.new(access_token: token)
# assign all the droplets created to the object nick 
nick3 = client.droplets.all()
if nick3.count == 0 then
	puts "No droplets created so exiting the program - nothing to do ;-) "
	exit
end

nick2 = client.droplets.all.each
flag = "on"
while flag == "on" do 
        nick = client.droplets.all()
	nick.each do |droplet|
	  flag = "off"
	  #puts droplet.name
	  #The @ sysmbol changes the scope of the variable to global
	  @name = droplet.name
	  if droplet.status == "new" then
		  flag = "on"
	  end
	end
   if flag == "on" then
	#puts "Waiting for new droplets to become active"
	print "Waiting for new droplets to become active\r"
	sleep 10 
   end
end
nick = client.droplets.all()
nick.each do |droplet|
	if droplet.status == "active" then
	  ap "Name #{droplet.name} - ID #{droplet.id} - IP #{droplet.public_ip} - #{droplet.status}"
	end
   end
exit

