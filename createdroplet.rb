#!/Users/nickhadd/.rvm/rubies/ruby-2.1.0/bin/ruby
# This script allows us to create new droplets
#require 'rubygems'
#require 'bundler/setup'
#json --version
require 'droplet_kit'
require 'optparse'
require 'awesome_print'
dropname = ""
def usage()
	puts "You must enter the following options"
	puts "Firstly the name of the Droplet - optional -n used for single droplet creation"
	puts "then the OS of the droplet -o - optional defaults to ubuntu-14-04-x64"
	puts "then the number of droplets to create -c "
	puts "EX: createdroplet.rb test Centos-6-5-x64 "
	return true
end
if ARGV.empty? then
	usage
	exit
end
# The options below are the default if nothing is supplied
options = {name: nil,ostype: 'ubuntu-14-04-x64',number: 1}
OptionParser.new do |opt|
	opt.on( '-n','--name  DROPNAME','Droplet Name') {|name|options[:name] = name} 
	opt.on( '-o','--ostype  DROPNAME','different os type') {|ostype|options[:ostype] = ostype}
	opt.on( '-c','--number  DROPNAME','Number of Droplets ') {|number|options[:number] = number}
end.parse!

#if options[:ostype].nil? then
	# set the default OS VM image to use - this one supports ansible
#	$doimage = 'ubuntu-14-04-x64'
#else
#	$doimage = options[:ostype]
#end

def create_droplet(name,image)
	token=ENV['Oauth_key']
	client = DropletKit::Client.new(access_token: token)
	# The last part of the object created below is the ssh_key ID array, very important to access the VM ;-)
	droplet = DropletKit::Droplet.new(name: name, region: 'lon1', size: '512mb', image: image ,ssh_keys: [745098])
	# just shows the current settings
	#ap droplet
	client.droplets.create(droplet)
	return true
end

numdrops = options[:number].to_i
#print "#{options[:name]}, #{options[:number]}"


1.upto(numdrops) do |i|
	#if options[:name].nil? then
	#	count = 1

	dropname = options[:name]
        $int = options[:name]
	while dropname == nil do
			puts "You must specify a host name for each droplet"
			print "Enter you new droplet name ->: "
			dropname = gets.chomp
			$int = dropname	
	end
		dropname = $int+i.to_s
		print "creating #{dropname}, with #{options[:ostype]}, #{i} \n"
		create_droplet dropname, options[:ostype]
	#else
	#	dropname = options[:name]
	#	create_droplet 1,dropname
#else
#	dropname = ARGV[0]
	#end
	#numdrops = numdrops - 1
end
#print "Enter you new droplet name ->: "
#dropname = gets.chomp


