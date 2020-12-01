all : .state_xnat-web-lxd .state_xnat-web-docker

xnat_web_ver = 1.7.6
XNAT := xnat.json setenv.sh xnat-web-1.7.6.war openid-auth-plugin-1.0.0.jar xnat-ldap-auth-plugin-1.0.0.jar

.PHONY : prep-docker
prep-docker: xnat-web-1.7.6.war

.state_xnat-web-lxd : $(XNAT) .state_tomcat-lxd xnat-pipeline-engine xnat-conf.properties
	packer build -only=lxd xnat.json
	touch .state_xnat-web-lxd

.state_xnat-web-docker : $(XNAT)
	packer build -only=docker xnat.json
	touch .state_xnat-web-docker

.state_tomcat-lxd : apache-tomcat-7.0.103.tar.gz apache-tomcat.json tomcat.service
	packer build -only=lxd apache-tomcat.json
	touch .state_tomcat-lxd

xnat-web-1.7.6.war :
	curl -L -o./xnat-web-$(xnat_web_ver).war https://api.bitbucket.org/2.0/repositories/xnatdev/xnat-web/downloads/xnat-web-$(xnat_web_ver).war

xnat-pipeline-engine :
	git clone https://www.github.com/nrgXnat/xnat-pipeline-engine.git

openid-auth-plugin-1.0.0.jar :
	wget -P./ 'http://dev.redboxresearchdata.com.au/nexus/service/local/repositories/snapshots/content/au/edu/qcif/xnat/openid/openid-auth-plugin/1.0.0-SNAPSHOT/openid-auth-plugin-1.0.0-20190409.122010-10.jar'
	ln -s openid-auth-plugin-1.0.0-20190409.122010-10.jar openid-auth-plugin-1.0.0.jar
xnat-ldap-auth-plugin-1.0.0.jar :
	wget -P./ 'https://bitbucket.org/xnatx/ldap-auth-plugin/downloads/xnat-ldap-auth-plugin-1.0.0.jar'

apache-tomcat-7.0.103.tar.gz :
	curl -L -o./apache-tomcat-7.0.103.tar.gz https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.103/bin/apache-tomcat-7.0.103.tar.gz

.PHONY : clean
clean :
	rm -f xnat-web-1.7.6.war
	rm -f openid-auth-plugin-1.0.0.jar
	rm -f xnat-ldap-auth-plugin-1.0.0.jar
	rm -f apache-tomcat-7.0.103.tar.gz
	rm -rf xnat-pipeline-engine
	rm -f .state_*
