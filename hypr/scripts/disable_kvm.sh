#!/bin/bash
# Deshabilitar módulos KVM

sudo modprobe -r kvm_intel
sudo modprobe -r kvm
