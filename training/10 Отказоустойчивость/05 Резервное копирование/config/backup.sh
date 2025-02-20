#!/bin/bash

rsync -avh --progress  --delete --checksum  /home/maks /tmp/backup > /tmp/backup/1.log 
if [ $? -eq 0 ]; then
        echo "$(date) - Backup - SUCCESSFULLY" >> /var/log/neto_hw/hw.log
else
        echo "$(date) - Backup - FAILED" >> /var/log/neto_hw/hw.log
fi