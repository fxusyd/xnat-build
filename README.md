# XNAT build

```console
# Download the pre-requisite files
$ make

# Build all images
$ packer build xnat.pkr.hcl

# Build an individual image
$ packer build -only docker.xnat17 xnat.pkr.hcl
```

Reference:
* https://bitbucket.org/xnatdev/container-service/downloads/
