#!/bin/bash

#Get the PCI-Address of network card (Caution: This works ONLY with ONE NIC)
PCI=`/usr/bin/lspci | /bin/egrep -i 'network|ethernet' | /usr/bin/cut -d' ' -f1`
PCIPATH=`/usr/bin/find /sys -name *\${PCI} | /bin/egrep -i *pci0000*`

#echo "PCI    =$PCI"
#echo "PCIPATH=$PCIPATH"
#ls -la $PCIPATH

/usr/bin/logger -t "ResetNIC" "Resetting PCI NIC ${PCIPATH}"

#Reset the PCI Device completely (like Power-ON/Off)
echo "echo 1 >${PCIPATH}/reset"
echo 1 >${PCIPATH}/reset
