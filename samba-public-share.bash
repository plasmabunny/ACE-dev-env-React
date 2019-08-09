    #!/bin/bash

    echo "Configuring Samba Server for host-guest file exchange."
    sudo apt-get update
    sudo apt-get install -y samba
    
    sudo chmod 2770 /home/vagrant/

    # Defining home share, all directives following this line are part of that share.
    # They are in echo statements because I am appending configuration information
    # to the Samba configuration file.
    echo '[home]'   | sudo tee --append /etc/samba/smb.conf
    echo '   comment = Samba Share on acedevbox'       | sudo tee --append /etc/samba/smb.conf
    
    # Set the path for the home share
    echo '   path = /home/vagrant' | sudo tee --append /etc/samba/smb.conf

    # Ensure the share can be written to.  This only sets share permissions, the underlying file system has
    # its own permissions that can get in the way.
    echo '   read only = no'   | sudo tee --append /etc/samba/smb.conf

    # Ensure that the share can be browsed through
    echo '   browsable = yes'  | sudo tee --append /etc/samba/smb.conf

    # Ensure the share can be written to
    echo '   writable = yes'   | sudo tee --append /etc/samba/smb.conf

    # Allow guest account access to the share
    echo '   guest ok = yes'   | sudo tee --append /etc/samba/smb.conf

    # When logging in as a guest, treat the accessor as the user vagrant.
    # This is horribly insecure, but it makes it nice and easy for the
    # end user to access the share and write to it.
    echo '   guest account = vagrant'   | sudo tee --append /etc/samba/smb.conf

    # When a bad user account is provided, they will be logged in as a guest
    echo '   map to guest = bad user'   | sudo tee --append /etc/samba/smb.conf

    # When files are created via the samba server, they will have the vagrant user as owner
    echo '   force user = vagrant'   | sudo tee --append /etc/samba/smb.conf

    echo Setting SMB password for user 'vagrant'
    sudo printf "vagrant\nvagrant\n" | smbpasswd -a vagrant

    echo Setting folder permissions and restarting service.
    sudo setfacl -R -m "u:nobody:rwx" /home/vagrant
    sudo systemctl restart smbd nmbd