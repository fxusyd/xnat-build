xnat_version = 1.8.2
xnat_ver_17 = 1.7.6
plugin_container_service_ver = 3.0.0
plugin_ldap_auth_ver = 1.1.0
plugin_openid_auth_ver = 1.0.2
plugin_ohif-viewer_ver = 3.0.1

xnat_war = xnat-web-$(xnat_version).war
xnat_url = https://bitbucket.org/xnatdev/xnat-web/downloads/$(xnat_war)
xnat_war_17 = xnat-web-$(xnat_ver_17).war
xnat_url_17 = https://bitbucket.org/xnatdev/xnat-web/downloads/$(xnat_war_17)
plugin_container_service_jar = container-service-$(plugin_container_service_ver)-fat.jar
plugin_container_service_url = https://bitbucket.org/xnatdev/container-service/downloads/container-service-$(plugin_container_service_ver)-fat.jar
plugin_ldap_auth_jar = ldap-auth-plugin-$(plugin_ldap_auth_ver).jar
plugin_ldap_auth_url = https://bitbucket.org/xnatx/ldap-auth-plugin/downloads/ldap-auth-plugin-1.1.0.jar
plugin_openid_auth_jar = openid-auth-plugin-$(plugin_openid_auth_ver).jar
plugin_openid_auth_url = https://github.com/Australian-Imaging-Service/xnat-openid-auth-plugin/releases/download/$(plugin_openid_auth_ver)/xnat-openid-auth-plugin-all-$(plugin_openid_auth_ver).jar
#plugin_openid_auth_url = http://dev.redboxresearchdata.com.au/nexus/service/local/repositories/snapshots/content/au/edu/qcif/xnat/openid/openid-auth-plugin/$(plugin_openid_auth_ver)-SNAPSHOT/openid-auth-plugin-$(plugin_openid_auth_ver)-20190409.122010-10.jar
plugin_ohif-viewer_jar = ohif-viewer-$(plugin_ohif-viewer_ver)-XNAT-1.8.0.jar
plugin_ohif-viewer_url = https://bitbucket.org/icrimaginginformatics/ohif-viewer-xnat-plugin/downloads/ohif-viewer-$(plugin_ohif-viewer_ver)-XNAT-1.8.0.jar

plugins_17 = $(plugin_container_service_jar) $(plugin_ldap_auth_jar) $(plugin_openid_auth_jar)
plugins = $(plugin_container_service_jar) $(plugin_ldap_auth_jar) $(plugin_openid_auth_jar) $(plugin_ohif-viewer_jar)

all : $(xnat_war) $(xnat_war_17)

$(xnat_war) : $(plugins)
	wget --no-verbose -O $(xnat_war) $(xnat_url)

$(xnat_war_17) : $(plugins_17)
	wget --no-verbose -O $(xnat_war_17) $(xnat_url_17)

$(plugin_container_service_jar) :
	wget --no-verbose -O $(plugin_container_service_jar) $(plugin_container_service_url)

$(plugin_ldap_auth_jar) :
	wget --no-verbose -O $(plugin_ldap_auth_jar) $(plugin_ldap_auth_url)

$(plugin_openid_auth_jar) :
	wget --no-verbose -O $(plugin_openid_auth_jar) $(plugin_openid_auth_url)

$(plugin_ohif-viewer_jar) :
	wget --no-verbose -O $(plugin_ohif-viewer_jar) $(plugin_ohif-viewer_url)

.PHONY : clean
clean :
	rm -f $(xnat_war)
	rm -f $(xnat_war_17)
	rm -f $(plugins)
	rm -f $(plugins_17)

