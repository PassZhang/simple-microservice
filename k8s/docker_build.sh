#!/bin/bash

docker_registry=192.168.25.228:8088
#kubectl create secret docker-registry registry-pull-secret --docker-server=$docker_registry --docker-username=admin --docker-password=Harbor12345 --docker-email=admin@ctnrs.com -n ms

#service_list="gateway-service order-service product-service stock-service portal-service"
service_list="eureka-service"
service_list=${1:-${service_list}}
work_dir=$(dirname $PWD)
current_dir=$PWD

cd $work_dir
mvn clean package -Dmaven.test.skip=true

for service in $service_list; do
   cd $work_dir/$service
   if ls |grep biz &>/dev/null; then
      cd ${service}-biz
   fi
   service=${service%-*}
   image_name=$docker_registry/library/${service}:$(date +%F-%H-%M-%S)
   docker build -t ${image_name} .
   docker push ${image_name} 
#   sed -i -r "s#(image: )(.*)#\1$image_name#" ${current_dir}/${service}.yaml
#   kubectl apply -f ${current_dir}/${service}.yaml
done
