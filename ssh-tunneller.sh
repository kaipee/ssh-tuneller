#!/bin/bash

# Clear the screen
clear

# Prompt for local port
echo "Enter a local port number to listen on (default 50080) and press [ENTER]"
read localport

# Assign default value if nothing submitted
if [[ -z "$localport" ]]; then
	localport=50080
fi

printf '%s\n' '-------------------------------'
printf "LISTENING ON LOCAL PORT : $localport\n"
printf '%s\n\n' '-------------------------------'

# Prompt for remote SSH port
echo "Enter port number of remote SSH server (default 22) and press [ENTER]"
read remoteport

# Assign default if nothing submitted
if [[ -z "$remoteport" ]]; then
	remoteport=22
fi

printf '%s\n' '-------------------------------'
printf "FORWARDING TO REMOTE PORT : $remoteport\n"
printf '%s\n\n' '-------------------------------'

# Prompt for USER@SERVER SSH connection details
function server {
	echo "Please enter SSH connection details in format USER@SERVER"
	read sshserver
}

# Re-prompt if no input
while [[ -z "$sshserver" ]]
do
	server
done

# Provide some guidance on configuring SOCKS5 in Firefox
cat << EOF

Once logged into your SSH server, set up a SOCKS5 proxy

###################
# Firefox example #
###################
Preferences > Network Proxy
Manual Proxy Configuration
Socks Host Type (SOCKS 5)
Socks Host : 127.0.0.1
Socks Port : $localport
##################

Executing SSH command : 'ssh -D $localport -p $remoteport $sshserver'

Connecting................

EOF

ssh -D "$localport" -p "$remoteport" "$sshserver"
