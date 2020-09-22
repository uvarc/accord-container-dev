# The only purpose of this Makefile is to build all containers in order;
# it relies on layer caching to prevent complete rebuilds every time. To
# force a full rebuild, use `make base; make`

# Common workloads for Theia and Jupyter
COMMON_WORKLOADS = test-workload python

# Here we can add additional per-interface workloads
THEIA_WORKLOADS = bcftools $(COMMON_WORKLOADS)
JUPYTER_WORKLOADS = $(COMMON_WORKLOADS)

# Generate the union
WORKLOADS = $(sort $(THEIA_WORKLOADS) $(JUPYTER_WORKLOADS))

THEIA_BUILDS = $(addprefix theia-, $(THEIA_WORKLOADS))
JUPYTER_BUILDS = $(addprefix jupyter-, $(JUPYTER_WORKLOADS))

include .env

ifndef REGISTRY
$(error REGISTRY is not set, see .env)
endif

.PHONY: all theia-full jupyterlab centos7-base $(THEIA_BUILDS) $(THEIA_WORKLOADS) $(JUPYTER_WORKLOADS)

all: $(THEIA_BUILDS) $(JUPYTER_BUILDS)

$(THEIA_BUILDS): theia-full $(THEIA_WORKLOADS)
	podman build -f Dockerfile.theia -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) --build-arg WORKLOAD=$(patsubst theia-%,%,$@) .

$(JUPYTER_BUILDS): jupyterlab $(JUPYTER_WORKLOADS)
	podman build -f Dockerfile.jupyter -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) --build-arg WORKLOAD=$(patsubst jupyter-%,%,$@) .

$(WORKLOADS): centos7-base
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

theia-full: centos7-base
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

jupyterlab: centos7-base
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

centos7-base:
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

base:
	podman build --no-cache -f centos7-base/Dockerfile -t $(REGISTRY)/accord/centos7-base:latest --build-arg REGISTRY=$(REGISTRY) centos7-base

prune:
	podman container prune -f
