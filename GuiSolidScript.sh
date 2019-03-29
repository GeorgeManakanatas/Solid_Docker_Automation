#!/bin/bash
################
# general info #
################

# This script assumes an Ubuntu OS with git and docker installed. Will probably
# also work with Centos and any Linux distribution that has zenity  and sed.

# Direct interaction with the rest services as described in the api is possible
# but is a bit trickyer with things inthe container because the changes in the
# ports need to be taken in to account but a postman collection of quick script
# should be easily manageable

# The authentication client for solid can be found here:
# https://solid.github.io/solid-auth-client/

########################
# supporting functions #
########################

# notification function
notification(){
  # will display a notification with given text
  zenity --notification --window-icon="info" --text="$1" --timeout=2
}
# remove container
remove_container(){
  # popup for the user to give the name of the container to be removed
  container=$(zenity --entry --title="Remove Container" --text="Container to remove" );
  # and then proceeds to stop the container and remove it
  sudo docker container stop $container
  sudo docker container rm $container
}
# remove image
remove_image(){
  # popup for the user to give the name of the image to be removed
  image=$(zenity --entry --title="Remove Image" --text="Image to remove" );
  # and then proceeds to remove iamge
  sudo docker image rm $image
}
# start container
start_container(){
  # popup for user to give the name of the container to be started and starts it
  container=$(zenity --entry --title="Start Container" --text="Container to start" );
  sudo docker container start $container
}
# stop container
# presents popup for user to give the name of the container to be stoped and stops it
stop_container(){
  container=$(zenity --entry --title="Stop Container" --text="Container to stop" );
  sudo docker container stop $container
}
# build image
build_solid_server_image(){
  ansible-playbook -K MainPlaybook.yml --tags "get_solid"
  ansible-playbook -K MainPlaybook.yml --tags "solid_image"
}
# create container

create_container(){
  # popup to give a port on the host machine to bind the 8443 default of the container
  port=$(zenity --entry --title="Container" --text="Port to assign 8443 to" );
  # popup for the name of the container to be created
  name=$(zenity --entry --title="Container" --text="Name of the container" );
  sudo docker run -p $port:8443 --name $name node_solid_server
}

###################################
# containers window main function #
###################################ls

# window with all the options available to the user
# (while possible to select 2 at the same time this is best avoided)
start_containers(){
  #zenity containers configuration
  containersTitle="	Containers	"
  containersPrompt="Make your selection"
  containersWindowHeight=400
  #
  response=$(zenity --height="$containersWindowHeight" --list --checklist \
  	--title="$containersTitle" --column="" --column="$containersPrompt" \
    False "Build Image" \
    False "Show Images" \
    False "Remove Image" \
    False "Show containers" \
    False "Create container" \
  	False "Start Container" \
    False "Stop Container" \
    False "Remove Container" \
  	--separator=':');

  # check for no selection
  if [ -z "$response" ] ; then
 	#spd-say "No selection exiting"
 	exit
  fi

  IFS=":" ; for word in $response ; do
 	case $word in
    	"Stop Container")
      	stop_container
      	notification "Container stoped" ;;
    	"Start Container")
      	start_container
      	notification "Container started" ;;
    	"Build Image")
      	build_solid_server_image
      	notification "Image built" ;;
    	"Create container")
      	create_container
      	notification "Container created" ;;
      "Show Images")
        sudo docker images ;;
      "Remove Image")
      	remove_image
        notification "Image removed" ;;
    	"Show containers")
      	sudo docker ps -a ;;
    	"Remove Container")
      	remove_container
      	notification "Container removed" ;;
 	esac
  done
}
# loop ensuring that containers window function restarts once task is finished
while true; do
  start_containers
done
