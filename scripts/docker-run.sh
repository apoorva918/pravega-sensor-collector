#!/usr/bin/env bash
set -e

TITLE='pravegasensorcollector'

# ENVVARS=("PRAVEGA_SENSOR_COLLECTOR_LEAP1_CLASS=io.pravega.sensor.collector.leap.LeapDriver"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_API_URI=http://127.0.0.1:8083"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_USERNAME=admin"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_PASSWORD=mypassword"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_POLL_PERIOD_SEC=180"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_PERSISTENT_QUEUE_FILE=/tmp/leap1.db"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_PERSISTENT_QUEUE_CAPACITY_EVENTS=10000"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_SCOPE=examples"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_CREATE_SCOPE=true"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_STREAM=leap"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_ROUTING_KEY=routingkey1"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_EXACTLY_ONCE=true"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_PRAVEGA_CONTROLLER_URI=tcp://127.0.0.1:9090"
# "PRAVEGA_SENSOR_COLLECTOR_LEAP1_TRANSACTION_TIMEOUT_MINUTES=2.0" )

ENVVARS=(
"PRAVEGA_SENSOR_COLLECTOR_NET2_CLASS=io.pravega.sensor.collector.network.NetworkDriver"
"PRAVEGA_SENSOR_COLLECTOR_NET2_NETWORK_INTERFACE=lo"
"PRAVEGA_SENSOR_COLLECTOR_NET2_MEMORY_QUEUE_CAPACITY_ELEMENTS=10000"
"PRAVEGA_SENSOR_COLLECTOR_NET2_SAMPLES_PER_EVENT=100"
"PRAVEGA_SENSOR_COLLECTOR_NET2_SAMPLES_PER_SEC=100"
"PRAVEGA_SENSOR_COLLECTOR_NET2_PERSISTENT_QUEUE_FILE=/tmp/network-lo.db"
"PRAVEGA_SENSOR_COLLECTOR_NET2_PERSISTENT_QUEUE_CAPACITY_EVENTS=100"
"PRAVEGA_SENSOR_COLLECTOR_NET2_SCOPE=examples"
"PRAVEGA_SENSOR_COLLECTOR_NET2_CREATE_SCOPE=true"
"PRAVEGA_SENSOR_COLLECTOR_NET2_STREAM=network"
"PRAVEGA_SENSOR_COLLECTOR_NET2_ROUTING_KEY=routingkey1"
"PRAVEGA_SENSOR_COLLECTOR_NET2_EXACTLY_ONCE=false"
"PRAVEGA_SENSOR_COLLECTOR_NET2_PRAVEGA_CONTROLLER_URI=tcp://192.168.189.129:9090")

CONTAINER=${TITLE}

#delete container if already exists
# RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)
# if [ $? -ne 1 ]; then
#   /usr/bin/docker rm --force $CONTAINER
# fi

declare -a ENVVAR_STRING
for envvar in ${ENVVARS[@]} ; do
  ENVVAR_STRING+=("-e ${envvar}")
done

NAME_STRING="--name ${CONTAINER}"

OPTS="${ENVVAR_STRING[@]} $NAME_STRING"


DOCKER_REGISTRY='devops-repo.isus.emc.com:8116/nautilus'
APPVERSION='1.0.0'

# docker pull ${DOCKER_REGISTRY}/pravegasensorcollector:${APPVERSION} 
# docker tag ${DOCKER_REGISTRY}/pravegasensorcollector:${APPVERSION} pravegasensorcollector:${APPVERSION}
docker run --network="host" $OPTS ${DOCKER_REGISTRY}/pravegasensorcollector:${APPVERSION}
