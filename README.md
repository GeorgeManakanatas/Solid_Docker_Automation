# Solid_Docker_Automation

Bash and Ansible combination that installs all the software needed to create docker containers with Solid servers running self signed certificates.

## Goal

The goal is to automate the above process and make it user friendly. This ansible playbook when run should: 
* Update the machine 
* Install 
  * node 
  * python
  * docker
* Clone the Solid server repository
* Make the modifications to allow self signed certificates
* Create an image that will be used for the containers
* Run the bash script responsible for providing the GUI

## Folder contents

```

./
├── GuiSolidScript.sh
├── LICENSE
├── MainPlaybook.yml
├── README.md
├── roles
│   ├── build_solid_image
│   ├── docker
│   ├── general
│   ├── get_solid
│   ├── nodejs
│   ├── python
│   └── README.md
└── start.sh

7 directories, 6 files

```

### Prerequisites

For the time being it only works on Ubuntu and Ubuntu server.
You must have sudo privileges in the host machine. 

Centos / RHEL / Fedora compatibility for this playbook is a goal but as of now is present in only some of the roles.

## Getting Started

If the machine has git then get the repository with the following command:
```
git clone https://github.com/GeorgeManakanatas/Solid_Docker_Automation.git
```
Otherwise download a zip from github and unpack it in a Directory of your choosing. 

### Installing

First go into the defaults folders of the get_solid and build_solid_image roles and change the paths in the main.yml files to ones that work for your machine.

```
cd Solid_Docker_Automation/
nano roles/get_solid/defaults/main.yml
nano roles/build_solid_image/defaults/main.yml
```

Then check the contents of config.json-default and Dockerfile in the files folder of the get_solid role to ensure that they have the appropriate chenges to build and image that will run with only one user and a self signed certificate respectivelly.
```
nano roles/get_solid/files/config.json-default
nano roles/get_solid/files/Dockerfile
```

Check that the two bash scripts in the root directory are executable
```
ls -l
```
The permissions of the two files should end with an x. For example: -rwxrwxr-x  or -rwxr-xr-x

If the start.sh and GuiSolidScript.sh scripts are not executable then fist make them
```
sudo chmod +x start.sh
sudo chmod +x GuiSolidScript.sh
```

Then run the start.sh script. This will take a while especially when updating the OS and building the image but only on the first run. Be patient and unless you see an error let it do it's thing.

## Deployment

Once the installation is complete there should be a GUI window with a list of options. You can now check that the docker image has been created and the containers on the machine (there should be none). When creating a container from the available image you will be prompted to provide a port and a name. The containers must each have their unique port and names, no overlapping is possible.

Once the contaier is built and started open a browser and ingoring the https://localhost:8443/ that you may see in the console go to https://localhost:insert_port_number_here/. You will be warned of an unsafe site but go to advanced options and instruct the browser to ignore this. Then you should be at the Solid homepage where you can register normally.

For future use there is no need to run the playbook again and the GUI can be accessed directly by running the GUI script
```
./GuiSolidScript.sh
``` 

## Running the tests

At this time there are no tests. Future plans are to use Travis CI to test the roles.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the tags on this repository [here](https://github.com/your/project/tags).

## Authors

* **George Manakanatas** - [GeorgeManakanatas](https://github.com/GeorgeManakanatas)

## License

See the [LICENSE](LICENSE) file for details.

## Acknowledgments

* **Billie Thompson** - *Initial work on the great readme template used as the basis for this.* - [PurpleBooth](https://github.com/PurpleBooth)
* **Team Solid** - *To the present team at Solid as well as it's alumni for being awsome* - [Solid](https://solid.mit.edu/)

