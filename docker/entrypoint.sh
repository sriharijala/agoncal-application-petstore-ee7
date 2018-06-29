#!/bin/bash
BIND=$(hostname -i)
BIND_OPTS="-Djboss.bind.address.management=0.0.0.0 -Djboss.bind.address.private=0.0.0.0 -Djgroups.join_timeout=1000 -Djgroups.bind_addr=$BIND -Djboss.bind.address=$BIND"

if [ -z $WILDFLY_ADMIN_USER ];
then
  WILDFLY_ADMIN_USER="admin"
fi

if [ -z $WILDFLY_ADMIN_PASSWORD ];
then
  WILDFLY_ADMIN_PASSWORD="wildfly"
fi

if [ -z $JAVA_MEM_OPTS ];
then
  $JAVA_MEM_OPTS="-Xms64m -Xmx512m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m"
fi


/opt/jboss/wildfly/bin/add-user.sh $WILDFLY_ADMIN_USER $WILDFLY_ADMIN_PASSWORD --silent

export JAVA_OPTS="$JAVA_MEM_OPTS -Djboss.modules.system.pkgs=org.jboss.byteman,org.wildfly.common,org.jboss.modules,org.jboss.logmanager -Djava.util.logging.manager=org.jboss.logmanager.LogManager -Xbootclasspath/p:/opt/jboss/wildfly/modules/system/layers/base/org/jboss/logmanager/main/jboss-logmanager-2.0.9.Final.jar:/opt/jboss/wildfly/modules/system/layers/base/org/wildfly/common/main/wildfly-common-1.3.0.Final.jar -javaagent:/opt/jboss/wildfly/bin/jmx_prometheus_javaagent-0.3.2.jar=9090:/opt/jboss/wildfly/standalone/configuration/prometheus_exporter_config.yaml -server -Djava.net.preferIPv4Stack=true -Djava.awt.headless=true"

/opt/jboss/wildfly/bin/standalone.sh $1 $BIND_OPTS $2
