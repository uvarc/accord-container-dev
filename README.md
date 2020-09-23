# ACCORD Container Dev

This repository holds Dockerfiles and build scripts for user containers for ACCORD.

ACCORD containers:
* Are run behind an authenticating http(s) proxy
* Run as a specific user (e.g. UID 12345)
* Have an http listening port with no authentication
  * This should be taken care of by the authencticating proxy or another in-between proxy
