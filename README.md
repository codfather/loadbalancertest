This process uses Digital Ocean Ubuntu 14.04 VM's, so you will need a free Digital Ocean account to start.
https://www.digitalocean.com/

This also assumes this will be run on an OSX or Linux machine - untested on Windows,though it would work perfectly in a Linux VM using Virtualbox on Windows.You will need a machine with access to the Internet.

The ruby scripts have been configured to use the version installed on this laptop - you will need to change those to where ever you ruby version and gems are installed.It is the first line of the Ruby scripts. 

1) You will need to obtain a Digital Ocean Oauth ID and set that as an environment variable for your shell and make sure it is exported so all programs can use it
ie Oauth_key=digital-ocean-oauth-key-here  

2) You will need to download and install the Digital Ocean API ruby gem to allow connections (version used droplet_kit (1.2.1), also gems optparse, awesome_print and json are needed if not already installed.

3) You will need to set up an SSH key pair and import that into your Digital Ocean account for passwordless logins to the root account - which is default for Digital Ocean

4) You will need to add the private key to your ssh keychain for automatic connections - using ssh-add <private-key-name>

Once this is setup and you can launch a test VM and log in to test all is working. You can test the ruby scripts are working by typing the following.

./createdroplet.rb -n testvm

then 

./lstdroplets.rb - to get the IP address of the newly created VM

then

ssh root@ip-address-from-above

Once all is tested and working you can run the script below to bring up the load balanced infrastructure.

You just need to type in ./sainsburytest.sh on an OSX or Linux machine command line.

The process will output some parts of the process as it goes.

The IP address of the web server will be printed at the end of the process install script, and that will be the address to point your browser at to check all is working. Due to the different times taken to instantiate VM's at different times of the day, it is IMPORTANT to wait a short while if the first test does not load. The software could still be being installed.

Once you have successfully run the test, you can delete all the VM's either using the Digital Ocean Gui, or using my deldroplet.rb all command - included for this task.

NB
If you have any questions or issues please contact me on nick@holevy.co.uk or Skype: swcodfather

Firefox and Safari work as designed and Round Robin LoadBalancing is working fine with them.

However,in testing I have noticed that Google Chrome appears to cache or at least associate with the first host it hits - which could well be a cache setting.
