FROM jboss/wildfly
USER root

ADD docker/jgroups /opt/jboss/wildfly/modules/system/layers/base/org/jgroups/
ADD docker/entrypoint.sh /opt/jboss/wildfly/bin/
COPY docker/standalone-full-ha-k8s.xml  /opt/jboss/wildfly/standalone/configuration/

ADD target/applicationPetstore.war /opt/jboss/wildfly/standalone/deployments/

ENTRYPOINT ["/opt/jboss/wildfly/bin/entrypoint.sh"]

EXPOSE 7600
