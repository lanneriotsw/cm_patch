#!/bin/env bash
echo "Start upgrading CM"
curl -JLO https://link.lannerinc.com/api/v1/cm/download?version=1.2.0
sudo apt -y remove cmservice
sudo apt -y --allow-downgrades install ./cmservice_1.2.0_amd64.deb
docker stop cmsfrontend
docker rm cmsfrontend
docker pull lanneriotsw/cms-frontend
docker run --name cmsfrontend --net host --restart unless-stopped -d lanneriotsw/cms-frontend
echo "Upgrade completed"
