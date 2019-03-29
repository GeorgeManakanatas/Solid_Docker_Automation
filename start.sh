#!/bin/bash
# should be run with sudo privileges

if ! command -v ansible >/dev/null; then
	echo "Installing Ansible dependencies and Git."
	if command -v yum >/dev/null; then
			sudo yum update -y
			sudo yum install git -y
			sudo yum install ansible -y
	elif command -v dnf >/dev/null; then
			sudo dnf update -y
			sudo dnf install git -y
			sudo dnf install ansible -y
	elif command -v apt-get >/dev/null; then
			sudo apt-get update -y
			sudo apt-get install git -y
			sudo apt-get install software-properties-common -y
			sudo apt-add-repository ppa:ansible/ansible -y
			sudo apt-get update -y
			sudo apt-get install ansible -y
	else
			echo "neither yum, dnf or apt-get found!"
			exit 1
	fi
fi

echo "Running playbook."
ansible-playbook -K MainPlaybook.yml

echo "Starting GUI."
./GuiSolidScript.sh

