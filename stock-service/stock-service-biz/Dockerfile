FROM passzhang/java:8-jdk-alpine
LABEL maintainer www.test.com
ENV JAVA_ARGS="-Dfile.encoding=UTF8 -Duser.timezone=GMT+08"
COPY ./target/stock-service-biz.jar ./
COPY pinpoint /pinpoint
EXPOSE 8030
CMD java -jar -javaagent:/pinpoint/pinpoint-bootstrap-1.8.5.jar -Dpinpoint.agentId=$(echo $HOSTNAME | awk -F- '{print "stock-"$NF}') -Dpinpoint.applicationName=ms-stock $JAVA_ARGS $JAVA_OPTS /stock-service-biz.jar
