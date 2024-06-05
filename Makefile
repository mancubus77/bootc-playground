### https://www.redhat.com/en/blog/image-mode-red-hat-enterprise-linux-quick-start-guide

TAG_BASE ?= base

build-base:
	podman build -f Containerfile.base -t quay.io/mancubus77/bootc:${TAG_BASE}

build-app:
	podman build -f Containerfile.app -t quay.io/mancubus77/bootc:app_v0

build-qcow:
	sudo podman run --rm -it --privileged -v .:/output -v /home/fedora/bootc/config.json:/config.json --pull newer registry.redhat.io/rhel9/bootc-image-builder:9.4 --type qcow2 --config /config.json quay.io/mancubus77/bootc:app_v0

run-vm:
	virt-install \
 	--name lamp-bootc \
 	--memory 4096 \
 	--vcpus 2 \
 	--disk qcow2/disk.qcow2 \
 	--import \
 	--os-variant rhel9.4
