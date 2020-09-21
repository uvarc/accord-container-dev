# The only purpose of this Makefile is to build all containers in order;
# it relies on layer caching to prevent complete rebuilds every time. To
# force a full rebuild, use `make base; make`
WORKLOADS = bcftools test-workload
THEIA_BUILDS = $(addprefix theia-, $(WORKLOADS))

include .env

ifndef REGISTRY
$(error REGISTRY is not set, see .env)
endif

.PHONY: all theia-full centos7-base $(THEIA_BUILDS) $(WORKLOADS)

all: $(THEIA_BUILDS)

$(THEIA_BUILDS): theia-full $(WORKLOADS)
	podman build -f Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) --build-arg WORKLOAD=$(patsubst theia-%,%,$@) .

$(WORKLOADS): centos7-base
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

theia-full: centos7-base
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

centos7-base:
	podman build -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

base:
	podman build --no-cache -f $@/Dockerfile -t $(REGISTRY)/accord/$@:latest --build-arg REGISTRY=$(REGISTRY) $@

prune:
	podman container prune -f
