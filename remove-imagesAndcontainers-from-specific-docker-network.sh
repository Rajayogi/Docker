#!/bin/sh
echo "Start"
result=$(docker inspect --format="{{.Config.Image}}" $(docker ps -q --filter "network =mynetwork"))
echo $result
docker stop $(docker ps -q --filter "network =mynetwork")
if [ $? -eq 0 ]; then
  echo "Stopped all containers"
else
  echo "failed to stop containers"
  exit
fi
docker rm $(docker ps -aq --filter "network =mynetwork")
if [ $? -eq 0 ]; then
  echo "removed all containers"
else
  echo "failed to remove containers"
  exit
fi
docker rmi $result
if [ $? -eq 0 ]; then
  echo "removed all images"
else
  echo "failed to remove images"
  exit
fi
echo "End"
