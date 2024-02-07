DEBIAN_VARFILE = debian.auto.pkrvars.hcl
SECRET_VARFILE = secret.debian.pkrvars.hcl

init:
	packer init .

validate-qemu:
	packer validate -var-file $(DEBIAN_VARFILE) -var-file $(SECRET_VARFILE) build-qemu.debian.pkr.hcl

build-qemu:
	packer build -on-error=ask -timestamp-ui -var-file $(DEBIAN_VARFILE) build-qemu.debian.pkr.hcl

validate-proxmox:
	packer validate -var-file $(DEBIAN_VARFILE) -var-file $(SECRET_VARFILE) build-proxmox.debian.pkr.hcl

build-proxmox:
	packer build -on-error=ask -timestamp-ui -var-file $(DEBIAN_VARFILE) -var-file $(SECRET_VARFILE) build-proxmox.debian.pkr.hcl
