# Testlink

## Getting Started
This cookbook is created using chef-solo. This automatically fires up testlink system using docker. Two docker containers will be created for testlink and mariadb.

### Prerequisites
Required packages will be installed using the testlink recipe which are the following:
1. docker.io
2. docker-compose
3. python-pip
4. awscli (used for backing up configuration to s3)

## How does it work?
### Run list
solo.json
```
{ 
  "run_list": [ "recipe[testlink]" ] 
}
```

solo.rb
```
root = File.absolute_path(File.dirname(__FILE__))

file_cache_path "/root/chef-solo"
cookbook_path "/root/chef-solo/cookbooks"
```

### Running Chef
```
chef-solo -c solo.rb -j solo.json
```
After the installation has completed. The cookbook will place required templates to be used for setting up the containers. Docker compose contains all the necessary parameters; these are fetched from the attribute section of the cookbook. You may just replace it accordingly. Will further discuss the templates later on.
The cookbook also configure files and script needed for the configuration backup of testlink. You'll just need to add the script on your crontab. Due to sensitivity, I have removed the script content but in case you need it, you may just refer to https://github.com/jjcpagtakhan/backup_creation, it basically does the same. Just need some more adjustment in terms of file locations.

### docker-compose.yaml
The contains configuration for testlink and mariadb. Both images used are created by Bitnami.

#### mariadb
If you would take a look at docker hub for bitnami/mariadb, you see the docker file will be ran using USER 1001 which can cause conflict on systems that has or has no USER 1001. To avoid such instances, root was declared to run the container and override the setting on the docker file. Volume was also mounted so it is easier to manage, update and inspect mariadb files but as for security, the permission was limited to root only.

#### testlink
Teslink runs the same with mariadb, volume was also mounted and all necessary configurations were added. If you plan to only use this as for development or testing then you may skip providing accounts. It will use the default which is user/bitnami. I suggest to fill these up instead of changing user details from your database. SMTP can also be used; no need to install postfix or sendmail since mail configuration is already configured in PHP. Just add details for host, port, user, password, email, etc. It should work. You may test it by doing password reset on your testlink account once the system is up.

## Running testlink
Reach your testlink thru your IP. Test login, create new account, or if no account was created, login using user/bitnami.

## Suggestions
Always use stable image versions; latest ones may still contain bugs. Or if you are keen then create your own image.

## Acknowledgement
This has been referenced from https://github.com/TestLinkOpenSourceTRMS/testlink-code/tree/testlink_1_9/.
