#!/bin/env bash
echo "Starting upgrade CM from v1.1.0 to v1.1.1"
curl -JLO https://link.lannerinc.com/api/v1/cm/download?version=1.1.1
sudo apt -y remove cmservice
sudo apt -y install ./cmservice_1.1.1_amd64.deb
docker stop cmsfrontend
docker rm cmsfrontend
docker rmi lanneriotsw/cms-frontend
docker run --name cmsfrontend --net host --restart unless-stopped -d lanneriotsw/cms-frontend
echo "Complete"
