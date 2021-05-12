# XNAT build

```console
# Download pre-requisite files
$ make

# Build all images
$ packer build xnat-web.pkr.hcl

# Build an individual image
$ packer build -only docker.xnat17 xnat-web.pkr.hcl

# Build all docker images
$ packer build -only docker.* xnat-web.pkr.hcl
```

Reference:
* https://bitbucket.org/xnatdev/container-service/downloads/
