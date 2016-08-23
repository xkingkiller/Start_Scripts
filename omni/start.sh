#!/bin/bash
#LAUNCHSTART="$(rospack find start_scripts)/common/run_launch.sh"
SET_MASTER="export ROS_MASTER_URI=http://192.168.3.4:11311"
SET_IP="export RO_IP=192.168.3.4"
LASER_TOPIC="/sick_lms141_scan"
LASER_MODEL="lms141"

#LASER_TOPIC="/sick_tim551_scan"
#LASER_MODEL="tim551"

GPS_TOPIC="/taimi/uwb_repub"
ODOM_TOPIC="/taimi/odom_repub"
MAP_PATH="passenge.yaml"


xfce4-terminal -T master -e "bash -iC 'echo start!; $SHELL'" \
	--tab -T loc -e "bash -ic 'sleep 3; cd $(rospack find start_scripts)/omni/localization; roslaunch loc_sick_gps.launch scan_topic:=$LASER_TOPIC gps_topic:=$GPS_TOPIC; $SHELL'" \
	--tab -T map -e "bash -ic 'sleep 1; cd $(rospack find start_scripts)/data/; rosrun map_server map_server $MAP_PATH; $SHELL'" \
	--tab -T nav -e "bash -ic 'sleep 4; cd $(rospack find start_scripts)/omni/navigation; roslaunch navigation_omni.launch odom_topic:=$ODOM_TOPIC laser_topic:=$LASER_TOPIC laser_model:=$LASER_MODEL; $SHELL'" \
	--tab -T rviz -e "bash -ic 'sleep 1; cd $(rospack find start_scripts)/common/rviz/; rviz -d nav.rviz; $SHELL'" \


