CATALINA_OPTS="-Xms512m -Xmx4g -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:+UseConcMarkSweepGC -XX:-OmitStackTraceInFastThrow ${CATALINA_OPTS} -Dxnat.home=${XNAT_HOME}"
