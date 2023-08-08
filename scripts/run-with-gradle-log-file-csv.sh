#!/usr/bin/env bash
#
# Copyright (c) Dell Inc., or its subsidiaries. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
set -ex

export CREATE_SCOPE=false
export ROUTING_KEY=${HOSTNAME}
export ENABLE_PRAVEGA=true
# export ENABLE_SENSOR_COLLECTOR=false
export pravega_client_auth_method=Bearer
export pravega_client_auth_loadDynamic=true
export KEYCLOAK_SERVICE_ACCOUNT_FILE="C:\Users\apoorva_shivpuriya\Documents\pravega_sensor_collector\WindowsService\PSCFiles\keycloak.json"
export JAVA_OPTS="-Xmx2048m"
export LOG_FILE_INGEST_ENABLE=true

export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_CLASS=io.pravega.sensor.collector.file.LogFileIngestService
export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_FILE_SPEC="C:\Users\apoorva_shivpuriya\Documents\pravega_sensor_collector\WindowsService\Parquet_Files\CSV_IBA"
export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_DELETE_COMPLETED_FILES=false
export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_DATABASE_FILE="C:\Users\apoorva_shivpuriya\Documents\pravega_sensor_collector\WindowsService\PSCFiles\datafile.db"
# export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_EVENT_TEMPLATE="{\"RemoteAddr\":\"$(hostname)\"}"
export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_SAMPLES_PER_EVENT=200
export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_PRAVEGA_CONTROLLER_URI=tls://pravega-controller.niners.em.sdp.hop.lab.emc.com:443
export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_SCOPE=project1
export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_CREATE_SCOPE=false
export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_STREAM=stream1
export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_ROUTING_KEY=$(hostname)
export PRAVEGA_SENSOR_COLLECTOR_ACCEL1_TRANSACTION_TIMEOUT_MINUTES=2.0



./gradlew --no-daemon run
