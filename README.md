# XNAT build

```console
# Download pre-requisite files
$ make

# Build all images
$ packer build .

# Build an individual image
$ packer build -only docker.xnat-web .

# Build all docker images
$ packer build -only docker.* .

# Build the xnat-web docker image with an overridden uid
$ packer build -var "run_as_uid=997" -only docker.xnat-web .
```
