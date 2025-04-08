# AUTOMATIC CONNECTION TO A VPN SERVER AND CONNECTION MANAGEMENT

## Description
This repository contains the script to create an automatic vpn connection to a OpenVPN server using a .ovpn file. Also it start and stop the VPN connection accordingly with the internet access status.

## USAGE
Add execution permission to files
```bash
sudo chmod 777 install.sh
sudo chmod 777 internet_checker.sh
```

Then run the instalation file changing file_path with your .ovpn filepath
```bash
./install.sh file_path
```

Internet checker service will be run using PM2 service. To check Interner_checker logs, execute:
```bash
pm2 log internetChecker
```

Enjoy
