#!/Users/nickhadd/.rvm/rubies/ruby-2.1.0/bin/ruby
#
print "The current running droplets\n"
print "*******************************************\n"
system("ruby /Users/nickhadd/bin/Digtal_Ocean_Ruby_Scripts/lstdroplets.rb")
print "*******************************************\n"
require 'droplet_kit'
token=ENV['Oauth_key']
client = DropletKit::Client.new(access_token: token)
#puts defined? $client
#
#puts "Enter the droplet ID to Delete"
#dropid = gets.chomp
$doobjs = client.droplets.all()
# Had to use .count to test as their was no empty method provided from the above call

def check_for_any_droplets(var2)
        value = true
	if var2.count == 0 then
	# IF there are no droplets - there is nothing to do so exit
	value = false	
	end
    return value
end
unless (check_for_any_droplets $doobjs) 
	puts "No droplets defined"
	exit  
end

if ARGV.empty? 
	puts "You must give me the ID of the droplet to delete - or all to delete all droplets"
	dropid = ""
else 	
	dropid = ARGV[0]
end
if ARGV[0] == "all" then
        print "This will delete everyone of your droplets are you sure Y or N ->"
	delall = $stdin.gets.chomp
	if ['n', 'N'].include?(delall) 
		puts "cancelling this request to save the droplets"
		exit
	end 
	if ['y', 'Y'].include?(delall) 	
	   dodrops = client.droplets.all()
           dodrops.each do |droplet|
	       puts "Deleteing Droplet #{droplet.id}"
	       client.droplets.delete(id: droplet.id)
	   end
	else
		puts "Not a correct answer - exiting to avoid incorrect deletion"
		exit
	end
       exit
end


while dropid == "" do
	puts "Need to enter an ID or all to Delete or x to exit"
	dropid = $stdin.gets.chomp
	if ['all', 'All'].include?(dropid)
	   dodrops = client.droplets.all()
           dodrops.each do |droplet|
	       puts "Deleteing Droplet #{droplet.id}"
	       client.droplets.delete(id: droplet.id)
	   end
	end

	if ['x', 'X'].include?(dropid)
	   exit
	end
	if dropid != "" 
		client.droplets.delete(id: dropid)
	end
end
