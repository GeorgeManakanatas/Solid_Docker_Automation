# Solid_Docker_Automation

## Description

Bash and Ansible combination that installs all the software needed to create docker containers with Solid servers running self signed certificates.

## Goal

To automate the process and make it user friendly. The ansible playbook should: 
* Update the machine 
* Install 
  * node 
  * python
  * docker
* Clone the Solid server repository
* Make the modifications to allow self signed certificates
* Create an image that will be used for the containers
* Run the bash script responsible for providing the GUI

## Installation

For the time being it only works on Ubuntu and Ubuntu server. Centos / RHEL / Fedora compatibility is in the works

If the machine has git then get the repository with the following command:
```
git clone https://github.com/GeorgeManakanatas/Solid_Docker_Automation.git
```
First go into the roles get_solid and build_solid_image and change the paths to ones that work for your machine. Then run the start.sh bash script. 
If the scripts are not executable then fist:
```
sudo chmod +x start.sh
sudo chmod +x GuiSolidScript.sh
```
Then run the start.sh script. This will take a while especially when updating the OS and building the image but only on the first run. Be patient and unless you see an error let it do it's thing.
 
## Usage

Once the installation is complete there should be a GUI window with a list of options. You can now check that the docker image has been created and the containers on the machine (there should be none). When creating a container from the available image you will be prompted to provide a port and a name. The containers must each have their unique port and names, no overlapping is possible.

Once the contaier is built and started open a browser and ingoring the https://localhost:8443/ that you may see in the console go to https://localhost:insert_port_number_here/. You will be warned of an unsafe site but go to advanced options and instruct the browser to ignore this. Then you should be at the Solid homepage where you can register normally. 

## License

See the [LICENSE](LICENSE) file for details.
