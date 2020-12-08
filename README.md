# ACCORD Container Dev

This repository holds Dockerfiles and build scripts for user containers for ACCORD.

ACCORD containers:
* Are run behind an authenticating http(s) proxy
* Run as a specific user (e.g. UID 12345)/group/supplemental group
* Have an http listening port with no authentication
  * This should be taken care of by the authencticating proxy or another inline proxy

## Container Variations

All containers are composed of two basic parts:
* An interface, currently one of "theia", "jupyter", or "rstudio"
* One of a library of workloads, currently "python", "bcftools" and "r"

The full name of a container variant is "\<interface\>-\<workload\>", e.g. "theia-python".

## Conventions

* Every container uses `user` for the username, and `project` for the primary group. The actual **UID** and **GID** are set at runtime.
* All mount-points are under `/home`:
  * `/home/user` mounts the user's home directory, and is the value of the `$HOME` environment value
  * `/home/project` mounts the project's shared data
  * `/home/scratch` mounts the project's high-performance scratch space (if any)

## Directory Structure

* The top-level `centos8-base`, `theia-jupyter-base` and `rstudio-base` directories container the build contexts for the corresponding base container builds.
* The directories under `userpods/` correspond to unique workload containers built from one of either `theia-jupyter-base` or `rstudio-base`.

## Container Structure

To maximize container storage efficiency, the majority of containers will be built on common base containers; the layers will look like:

* OS base, e.g. `centos8-base`; this layer includes everything common to all subsequent layers, and should create any addition user and group accounts that will be needed by further layers
* Interface bases, e.g. `theia-jupyter-base` and `rstudio-base`; these layers add user interfaces over the OS base
* Workload layer, e.g. `theia-bcftools` or `jupyter-python`; this layer adds a variety of user workloads, with `bcftools` being an arbitrary choice for the first added workload
  * NOTE: it's handy to start creating a Worload image by starting with one of the `Dockerfile-XXX.template` files

> Note that the three base containers are generally always built on the [quay.io](https://quay.io/accord) infrastructure, but workloads can be easily built locally. See [Developer Info](#developer-scripts-and-info) below.

Initially, a design was considered where the workload was applied directly to the OS base, then the interface was layered on top. There were two primary reasons to apply the interface first, then the workload:
1. Worker node storage efficiency: if the 500MB-1G interface layer were applied last, it would increase the storage requirement for each node by that amount for each unique workload
2. Job submission environment consistency: if a user develops a job in a container with a given interface - say, theia or jupyter - they may incorporate `nodejs` or `python` (required by the interface) in the job; thus, to insure user jobs run in an environment identical to where it was developed, we apply the interface layer last and run jobs in the same container

## Developer Scripts and Info

* `quay-build-trigger.sh` is a simple script using `curl` to trigger a container build on [quay.io](https://quay.io/accord). To use it you'll need to also clone the [accord-quay-webhooks](https://github.com/uvarc/accord-quay-webhooks) repository, and link `.env` to the environment file found there.
* `podman-publish.sh` is for developers using `podman` to build and push workload images. `$REGISTRY` should be set to the (ideally local) registry to push images to.

## Templates for `passwd` and `group`

So that ACCORD containers can run with the UID and GID of the connecting user, the `passwd` and `group` file are mounted from a configmap on container launch, based on templates. In generating the configmap for the particular variant, the generator first checks for a workload-specific file in the workload directory; failing that, it uses the template from the OS base. This means that any users or groups required by interface base images need to be created and present in the OS base image.
