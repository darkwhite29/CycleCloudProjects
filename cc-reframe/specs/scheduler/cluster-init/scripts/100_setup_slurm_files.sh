#!/bin/bash

set -x

# Copy slurm files to the correct location
PROLOGUE_DIR="/sched/prologue"
mkdir -p $PROLOGUE_DIR
cp -R ${CYCLECLOUD_SPEC_PATH}/files/slurm/* ${PROLOGUE_DIR}/.
cp  ${CYCLECLOUD_SPEC_PATH}/files/common.sh ${PROLOGUE_DIR}/.
cp  ${CYCLECLOUD_SPEC_PATH}/files/check_reframe_report.py ${PROLOGUE_DIR}/.
chmod 755 ${PROLOGUE_DIR}/*

# Configure Slurm prologue
echo "Prolog=${PROLOGUE_DIR}/run_reframe_prologue.sh" >> /sched/slurm.conf
# Disable Slurm autoscaling
echo "SuspendExcParts=-1" >> /sched/slurm.conf

# Restart slurmctld to make changes to Slurm take effect
systemctl restart slurmctld
