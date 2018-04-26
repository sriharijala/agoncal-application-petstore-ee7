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

echo alo si bai $WILDFLY_ADMIN_USER si $WILDFLY_ADMIN_PASSWORD

/opt/jboss/wildfly/bin/add-user.sh $WILDFLY_ADMIN_USER $WILDFLY_ADMIN_PASSWORD --silent
/opt/jboss/wildfly/bin/standalone.sh $1 $BIND_OPTS $2
