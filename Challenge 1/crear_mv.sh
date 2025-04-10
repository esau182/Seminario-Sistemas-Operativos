#!/bin/bash

# Verificar que se pasen los argumentos
if [ "$#" -ne 8 ]; then
    echo "Uso: $0 <VM_NAME> <OS_TYPE> <CPUS> <RAM_GB> <VRAM_GB> <HDD_GB> <SATA_CTL_NAME> <IDE_CTL_NAME>"
    exit 1
fi

# Asignar argumentos a variables
VM_NAME="$1"
OS_TYPE="$2"
CPUS="$3"
RAM_GB="$4"
VRAM_GB="$5"
HDD_GB="$6"
SATA_CTL="$7"
IDE_CTL="$8"

# Convertir RAM, VRAM y HDD de GB a MB
RAM_MB=$(echo "$RAM_GB * 1024" | bc | cut -d. -f1)
VRAM_MB=$(echo "$VRAM_GB * 1024" | bc | cut -d. -f1)
HDD_MB=$(echo "$HDD_GB * 1024" | bc | cut -d. -f1)

echo "Creando la máquina virtual '$VM_NAME' con OS tipo '$OS_TYPE'..."
VBoxManage createvm --name "$VM_NAME" --ostype "$OS_TYPE" --register

echo "Configurando CPU, RAM y VRAM..."
VBoxManage modifyvm "$VM_NAME" --cpus "$CPUS" --memory "$RAM_MB" --vram "$VRAM_MB"

# Definir la ruta del directorio de la VM
VM_DIR="$HOME/VirtualBox VMs/$VM_NAME"
HDD_PATH="$VM_DIR/${VM_NAME}.vdi"
# Crear el disco duro virtual
echo "Creando disco duro virtual de $HDD_GB GB ($HDD_MB MB) en '$HDD_PATH'..."
VBoxManage createmedium disk --filename "$HDD_PATH" --size "$HDD_MB" --format VDI

# Crear y configurar el controlador SATA y asociar el disco duro virtual
echo "Creando y configurando el controlador SATA '$SATA_CTL'..."
VBoxManage storagectl "$VM_NAME" --name "$SATA_CTL" --add sata --controller IntelAhci --bootable on
echo "Asociando el disco duro virtual al controlador SATA..."
VBoxManage storageattach "$VM_NAME" --storagectl "$SATA_CTL" --port 0 --device 0 --type hdd --medium "$HDD_PATH"

# Crear y configurar el controlador IDE y asociar un CD/DVD vacío
echo "Creando y configurando el controlador IDE '$IDE_CTL'..."
VBoxManage storagectl "$VM_NAME" --name "$IDE_CTL" --add ide --controller PIIX4 --bootable on
echo "Asociando una unidad de CD/DVD vacía al controlador IDE..."
VBoxManage storageattach "$VM_NAME" --storagectl "$IDE_CTL" --port 0 --device 0 --type dvddrive --medium emptydrive

# Configuracion final de la maquina virtual
echo "Configuración final de la máquina virtual '$VM_NAME':"
VBoxManage showvminfo "$VM_NAME"