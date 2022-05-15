xnat_version = 1.8.4.1
plugin_container_service_ver = 3.1.1
plugin_ldap_auth_ver = 1.1.0
plugin_ohif_viewer_ver = 3.2.0
plugin_openid_auth_ver = 1.0.2
plugin_xsync_ver = 1.4.0.1
plugin_batch_launch_ver = 0.5.0

xnat_war = xnat-web-$(xnat_version).war
# xnat_url = https://github.com/Australian-Imaging-Service/xnat-web/releases/download/release-$(xnat_version)-ais/$(xnat_war)
xnat_url = https://bitbucket.org/xnatdev/xnat-web/downloads/$(xnat_war)

plugin_container_service_jar = container-service-$(plugin_container_service_ver).jar
plugin_container_service_url = https://bitbucket.org/xnatdev/container-service/downloads/container-service-$(plugin_container_service_ver)-fat.jar

plugin_ldap_auth_jar = ldap-auth-plugin-$(plugin_ldap_auth_ver).jar
plugin_ldap_auth_url = https://bitbucket.org/xnatx/ldap-auth-plugin/downloads/$(plugin_ldap_auth_jar)

plugin_ohif_viewer_jar = ohif-viewer-$(plugin_ohif_viewer_ver).jar
plugin_ohif_viewer_url = https://bitbucket.org/icrimaginginformatics/ohif-viewer-xnat-plugin/downloads/ohif-viewer-$(plugin_ohif_viewer_ver)-XNAT-1.8.0.jar

plugin_openid_auth_jar = openid-auth-plugin-$(plugin_openid_auth_ver).jar
plugin_openid_auth_url = https://github.com/Australian-Imaging-Service/xnat-openid-auth-plugin/releases/download/$(plugin_openid_auth_ver)/xnat-openid-auth-plugin-all-$(plugin_openid_auth_ver).jar

plugin_xsync_jar = xsync-plugin-all-$(plugin_xsync_ver).jar
plugin_xsync_url = https://bitbucket.org/xnatdev/xsync/downloads/$(plugin_xsync_jar)

plugin_batch_launch_jar = batch-launch-plugin-$(plugin_batch_launch_ver).jar
plugin_batch_launch_url = https://bitbucket.org/xnatx/xnatx-batch-launch-plugin/downloads/$(plugin_batch_launch_jar)

plugins = $(plugin_container_service_jar) $(plugin_ldap_auth_jar) $(plugin_openid_auth_jar) $(plugin_ohif_viewer_jar) $(plugin_xsync_jar) $(plugin_batch_launch_jar)

$(xnat_war) : $(plugins)
	wget --no-verbose -O $(xnat_war) $(xnat_url)

$(plugin_container_service_jar) :
	wget --no-verbose -O $(plugin_container_service_jar) $(plugin_container_service_url)

$(plugin_ldap_auth_jar) :
	wget --no-verbose -O $(plugin_ldap_auth_jar) $(plugin_ldap_auth_url)

$(plugin_openid_auth_jar) :
	wget --no-verbose -O $(plugin_openid_auth_jar) $(plugin_openid_auth_url)

$(plugin_ohif_viewer_jar) :
	wget --no-verbose -O $(plugin_ohif_viewer_jar) $(plugin_ohif_viewer_url)

$(plugin_xsync_jar) :
	wget --no-verbose -O $(plugin_xsync_jar) $(plugin_xsync_url)

$(plugin_batch_launch_jar) :
	wget --no-verbose -O $(plugin_batch_launch_jar) $(plugin_batch_launch_url)

.PHONY : clean
clean :
	rm -f $(xnat_war)
	rm -f $(plugins)
