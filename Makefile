# The only purpose of this Makefile is to build all containers in order;
# it relies on layer caching to prevent complete rebuilds every time. To
# force a full rebuild, use `make base; make`

# Common workloads for Theia and Jupyter
COMMON_WORKLOADS = python

# Here we can add additional per-interface workloads
THEIA_WORKLOADS = bcftools $(COMMON_WORKLOADS)
JUPYTER_WORKLOADS = $(COMMON_WORKLOADS)
RSTUDIO_WORKLOADS = r

# Generate the union
WORKLOADS = $(sort $(THEIA_WORKLOADS) $(JUPYTER_WORKLOADS) $(RSTUDIO_WORKLOADS))

THEIA_BUILDS = $(addprefix theia-, $(THEIA_WORKLOADS))
JUPYTER_BUILDS = $(addprefix jupyter-, $(JUPYTER_WORKLOADS))
RSTUDIO_BUILDS = $(addprefix rstudio-, $(RSTUDIO_WORKLOADS))

include .env

ifndef REGISTRY
$(error REGISTRY is not set, see .env)
endif

.PHONY: all publish theia-jupyter-base rstudio-base centos7-base $(THEIA_BUILDS) $(JUPYTER_BUILDS) $(RSTUDIO_BUILDS) $(WORKLOADS)

all: $(THEIA_BUILDS) $(JUPYTER_BUILDS) $(RSTUDIO_BUILDS)

# Publish configmaps to the accord namespace in the cluster
publish:
	kubectl apply -f configmaps/

# Push container images to $REGISTRY
push:
	./push-images.sh $(THEIA_BUILDS) $(JUPYTER_BUILDS) $(RSTUDIO_BUILDS)

$(THEIA_BUILDS): theia-jupyter-base $(THEIA_WORKLOADS)
	podman build -f Dockerfile.theia -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) --build-arg WORKLOAD=$(patsubst theia-%,%,$@) .
	./generate-configmap.sh centos7-base theia $(patsubst theia-%,%,$@) 3000

$(JUPYTER_BUILDS): theia-jupyter-base $(JUPYTER_WORKLOADS)
	podman build -f Dockerfile.jupyter -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) --build-arg WORKLOAD=$(patsubst jupyter-%,%,$@) .
	./generate-configmap.sh centos7-base jupyter $(patsubst jupyter-%,%,$@) 8888

$(RSTUDIO_BUILDS): rstudio-base $(RSTUDIO_WORKLOADS)
	podman build -f Dockerfile.rstudio -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) --build-arg WORKLOAD=$(patsubst rstudio-%,%,$@) .
	./generate-configmap.sh centos7-base rstudio $(patsubst rstudio-%,%,$@) 8787

$(WORKLOADS): theia-jupyter-base
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

theia-jupyter-base: centos7-base
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

rstudio-base: centos7-base
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

centos7-base:
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

base:
	podman build --no-cache -f centos7-base/Dockerfile -t $(REGISTRY)/accord/centos7-base:latest --build-arg REGISTRY=$(REGISTRY) centos7-base

prune:
	podman container prune -f
