FROM jboss/wildfly:12.0.0.Final
USER root

ADD docker/org /opt/jboss/wildfly/modules/system/layers/base/org
ADD docker/entrypoint.sh /opt/jboss/wildfly/bin/

COPY docker/standalone-full-ha-k8s.xml  /opt/jboss/wildfly/standalone/configuration/
COPY docker/jmx_prometheus_javaagent-0.3.2.jar  /opt/jboss/wildfly/bin/
COPY docker/prometheus_exporter_config.yaml  /opt/jboss/wildfly/standalone/configuration/

ADD target/applicationPetstore.war /opt/jboss/wildfly/standalone/deployments/

ENTRYPOINT ["/opt/jboss/wildfly/bin/entrypoint.sh"]

EXPOSE 7600
