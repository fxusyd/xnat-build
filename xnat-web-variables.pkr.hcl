variable "xnat_version" {
  default = "1.8.5"
  type = string
}
variable "xnat_root" {
  default = "/data/xnat"
  type = string
}
variable "xnat_home" {
  default = "/data/xnat/home"
  type = string
}
variable "xnat_plugins" {
  default = "/data/xnat/home/plugins"
  type = string
}
variable "xnat_plugins_list" {
  default = [
    "container-service-3.2.0.jar",
    "ldap-auth-plugin-1.1.0.jar",
    "ohif-viewer-3.3.0.jar",
    "openid-auth-plugin-1.2.0-SNAPSHOT.jar",
    "xsync-plugin-all-1.4.0.1.jar",
    "batch-launch-0.6.0.jar"
  ]
  type = list(string)
}
variable "run_as_uid" {
  default = "0"
  type = string
}
variable "docker_image" {
  default = "tomcat:9.0.62-jdk8-openjdk-bullseye"
  type = string
}
variable "repository" {
  # Do not change default - required for CI/CD pipeline
  default = "localhost:32000"
  type = string
}
