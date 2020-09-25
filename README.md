# ACCORD Container Dev

This repository holds Dockerfiles and build scripts for user containers for ACCORD.

ACCORD containers:
* Are run behind an authenticating http(s) proxy
* Run as a specific user (e.g. UID 12345)
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
  * `/home/homedir` mounts the user's home directory, and is the value of the `$HOME` environment value
  * `/home/project` mounts the project's shared data
  * `/home/scratch` mounts the project's high-performance scratch space (if any)

## Container Build Structure

To maximize container storage efficiency, the majority of containers will be built on a common base; the layers will look like:

* OS base, e.g. `centos7-base`; this layer includes everything common to all subsequent layers, and should create any addition user and group accounts that will be needed by further layers
* Interface base, e.g. `theia-jupyter-base` and `rstudio-base`; these layers create a user interface over the OS base
* Workload layer, e.g. `bcftools`; this layer allows a variety user workloads, with `bcftools` being an arbitrary choice for the first workload
* Interface layer, e.g. `theia`; this final, thin wrapper layer:
  * Sets any `ENV` values required by the interface
  * `EXPOSE`'s the interface http port
  * Sets the container's `ENTRYPOINT` and `WORKDIR`

Initially, a design was considered where the workload was applied directly to the OS base, then the interface was layered on top. There were two primary reasons to apply the interface first, then the workload:
1. Worker node storage efficiency: if the 500MB-1G interface layer were applied last, it would increase the storage requirement for each node by that amount for each unique workload
2. Job submission environment consistency: if a user develops a job in a container with a given interface - say, theia or jupyter - they may incorporate `nodejs` or `python` (required by the interface) in the job; thus, to insure user jobs run in an environment identical to where it was developed, we apply the interface layer last and run jobs in the same container

> NOTE: 

## Templates for `passwd` and `group`

So that ACCORD containers can run with the UID and GID of the connecting user, the `passwd` and `group` file are mounted from a configmap on container launch, based on templates. In generating the configmap for the particular variant, the generator first checks for a workload-specific file in the workload directory; failing that, it uses the template from the OS base. This means that any users or groups required by interface base images need to be created and present in the OS base image.
