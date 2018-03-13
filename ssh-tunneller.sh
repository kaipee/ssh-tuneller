#!/bin/bash

# Clear the screen
clear

# Prompt for local port
echo "Enter a local port number to listen on (default 50080) and press [ENTER]"
read localport

# Assign default value if nothing submitted
if [[ -z "$localport" ]]; then
	localport=50080
	echo -e "WILL LISTEN ON DEFAULT LOCAL PORT : 50080\n\n"
else
	echo -e "WILL LISTEN ON LOCAL PORT : $localport\n\n"
fi

# Prompt for remote SSH port
echo "Enter port number of remote SSH server (default 22) and press [ENTER]"
read remoteport

# Assign default if nothing submitted
if [[ -z "$remoteport" ]]; then
	remoteport=22
	echo -e "WILL FORWARD TO DEFAULT REMOTE PORT : 22\n\n"
else
	echo -e "WILL FORWARD TO REMOTE PORT : $remoteport\n\n"
fi

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

Once logged into your SSH server, set up a SOCKS5 proxy in Firefox:
PREFERENCES > NETWORK PROXY
MANUAL PROXY CONFIGURATION
SOCKS HOST (SOCKS 5)
SOCKS HOST : 127.0.0.1
SOCKS PORT : $localport

Executing
ssh -D $localport -p $remoteport $sshserver

Connecting...
.............
.............




EOF

ssh -D "$localport" -p "$remoteport" "$sshserver"
