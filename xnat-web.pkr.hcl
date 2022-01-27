# xnat-build/xnat-web.pkr.hcl
# variables: xnat-build/xnat-web-variables.pkr.hcl
# pre-req.: make
#
build {
  provisioner "shell" {
    inline = [
      "mkdir -p ${var.xnat_root}/{archive,build,cache,fileStore,ftp,inbox,pipeline,prearchive}",
      "mkdir -p ${var.xnat_home}/{config/auth,logs,plugins,themes,work}",
      "chown -R ${var.run_as_uid}:${var.run_as_uid} ${var.xnat_root} ${var.xnat_home}",
    ]
    inline_shebang = "/bin/bash -e"
  }

  provisioner "file" {
    destination = "${var.xnat_plugins}/"
    sources = var.xnat_plugins_list
  }

  provisioner "file" {
    destination = "/tmp/"
    sources = [
      "xnat-web-${var.xnat_version}.war",
      "packer_files"
    ]
    only = ["docker.xnat-web"]
  }

  provisioner "file" {
    destination = "${var.xnat_home}/config/"
    sources = [
      "xnat-conf.properties"
    ]
  }

  provisioner "file" {
    destination = "/"
    sources = [
      "docker-entrypoint.sh",
      "docker-entrypoint.d"
    ]
    only = [ "docker.xnat-web" ]
  }

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get -y install postgresql-client",
      "rm -rf $${CATALINA_HOME}/webapps/*",
      "unzip -o -d $${CATALINA_HOME}/webapps/ROOT /tmp/xnat-web-*.war",
      "sed -i 's/ch.qos.logback.core.rolling.RollingFileAppender/ch.qos.logback.core.ConsoleAppender/' $${CATALINA_HOME}/webapps/ROOT/WEB-INF/classes/logback.xml",
      "cp /tmp/packer_files/setenv.sh $${CATALINA_HOME}/bin/setenv.sh && chmod 0555 $${CATALINA_HOME}/bin/setenv.sh",
      "find ${var.xnat_home}/config ${var.xnat_plugins} -type d -exec chmod 0755 {} \\; && find ${var.xnat_plugins} -type f -exec chmod 0644 {} \\;",
      # Set local account as owner of XNAT config, plugins and Tomcat directories
      "chown -R ${var.run_as_uid}:${var.run_as_uid} ${var.xnat_home}/config ${var.xnat_plugins} $${CATALINA_HOME}",
      "[ -f /docker-entrypoint.sh ] && chmod 0755 /docker-entrypoint.sh",
      "[ -d /docker-entrypoint.d ] && find /docker-entrypoint.d -type d -exec chmod 0755 {} \\; && find /docker-entrypoint.d -type f -exec chmod 0644 {} \\; && chown -R ${var.run_as_uid}:${var.run_as_uid} /docker-entrypoint.d",
      "rm -rf /tmp/*",
      "rm -rf /var/lib/apt/lists/*"
    ]
  }

  post-processors {
    # Do not remove
    # repository and ci tag required for CICD pipeline
    # used for development; microk8s registery
    post-processor "docker-tag" {
      repository =  "localhost:32000/${source.name}"
      tags = ["${var.xnat_version}","ci"]
      only = ["docker.xnat-web"]
    }
    post-processor "docker-push" {
      only = ["docker.xnat-web"]
    }
  }

  sources = [
    "source.docker.xnat-web"
  ]
}

source "docker" "xnat-web" {
  changes = [
    "CMD [\"bin/catalina.sh\",\"run\"]",
    "ENTRYPOINT [\"/docker-entrypoint.sh\"]",
    "ENV XNAT_HOME=${var.xnat_home}",
    "LABEL maintainer=\"Dean Taylor <dean.taylor@uwa.edu.au>\"",
    "LABEL org.opencontainers.image.source https://github.com/australian-imaging-service/xnat-build",
    "USER ${var.run_as_uid}"
  ]
  commit = true
  image = var.docker_image
}
