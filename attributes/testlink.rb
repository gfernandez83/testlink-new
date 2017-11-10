# for creation of the directories that will be mapped to the volume of the docker containers
default['spiral']['testlinkdata']['data'] = '/testlink/data'
default['spiral']['testlinkdata']['mariadb'] = '/testlink/mariadb'

# configuration account for mariadb
default[:spiral][:testlink][:mariadbuser] = 'root'
default[:spiral][:testlink][:mariadbpass] = nil

# configuration account for testlink
default[:spiral][:testlink][:testlinkuser] = 'user'
default[:spiral][:testlink][:testlinkpass] = nil 
default[:spiral][:testlink][:testlinkmail] = 'user@example.com'
default[:spiral][:testlink][:smtphost] = 'smtp.gmail.com'
default[:spiral][:testlink][:smtpport] = '587'
default[:spiral][:testlink][:smtpuser] = 'youremail@example.com'
default[:spiral][:testlink][:smtppass] = nil
default[:spiral][:testlink][:smtpconn] = 'tls'

# directories needed for the backup of testlink configuration
default['backup']['testlink']['log'] = '/opt/backup/log'
default['backup']['testlink']['list'] = '/opt/backup/s3list' 
default['backup']['testlink']['files'] = '/opt/backup/backup_files'
