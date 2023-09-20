# Project Overview

This project is dedicated to research on performance degradation caused by file fragmentation. The codebase is branched from NVMeVirt and extends its capabilities. The primary enhancement allows for writing to any die location based on information received from the kernel, rather than writing to a fixed die position as done previously.

## Modified Files

### conv_ftl.c, conv_ftl.h
- Modified to allocate dies based on information during writes.

### nvme.h
- Added additional fields to the NVMe Command structure.

### ssd.c, ssd.h
- Introduced die-specific information.
