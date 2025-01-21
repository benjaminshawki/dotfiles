```sh
~ > workspace/csc10/platformdesigner_tutorial/lights.qpf                                  
                                                                                          
~ > builtin cd -- /home/benjamin/workspace/csc10/platformdesigner_tutorial                
                                                                                          
~/workspace/csc10/platformdesigner_tutorial > ll                                          
total 1.5M
drwxr-xr-x 8 benjamin wheel 4.0K Nov 15 14:02 .
drwxr-xr-x 4 benjamin wheel 4.0K Nov 15 13:11 ..
drwxr-xr-x 3 benjamin wheel 4.0K Nov 15 12:34 app_software
-rw-r--r-- 1 benjamin wheel 4.7K Nov 12 11:21 c5_pin_model_dump.txt
drwxr-xr-x 3 benjamin wheel  16K Nov 15 14:01 db
drwxr-xr-x 3 benjamin wheel 4.0K Nov 12 11:20 incremental_db
-rw-r--r-- 1 benjamin wheel 1.3K Nov 15 14:02 lights_backup.qsf
-rw-r--r-- 1 benjamin wheel 1.3K Nov 12 10:06 lights.qpf
-rw-r--r-- 1 benjamin wheel  68K Nov 15 14:04 lights.qsf
-rw-r--r-- 1 benjamin wheel  68K Nov 12 11:19 lights.qsf.bak
-rw-r--r-- 1 benjamin wheel  729 Nov 12 11:15 lights.vhd
drwxr-xr-x 3 benjamin wheel 4.0K Nov 15 14:04 nios_system
-rw-r--r-- 1 benjamin wheel  190 Nov 12 11:12 nios_system_bb.v
-rw-r--r-- 1 benjamin wheel 3.5K Nov 12 11:12 nios_system.bsf
-rw-r--r-- 1 benjamin wheel  403 Nov 12 11:12 nios_system.cmp
-rw-r--r-- 1 benjamin wheel  309 Nov 12 11:12 nios_system_inst.v
-rw-r--r-- 1 benjamin wheel  732 Nov 12 11:12 nios_system_inst.vhd
-rw-r--r-- 1 benjamin wheel  39K Nov 15 14:03 nios_system.qsys
-rw-r--r-- 1 benjamin wheel 228K Nov 15 14:04 nios_system.sopcinfo
drwxr-xr-x 2 benjamin wheel 4.0K Nov 12 11:21 output_files
drwxr-xr-x 2 benjamin wheel 4.0K Nov 12 11:12 .qsys_edit
-rw-r--r-- 1 benjamin wheel  395 Nov 12 11:08 unsaved.cmp
-rw-r--r-- 1 benjamin wheel  10K Nov 12 11:08 unsaved_generation.rpt
-rw-r--r-- 1 benjamin wheel  83K Nov 12 11:08 unsaved.html
-rw-r--r-- 1 benjamin wheel  39K Nov 12 10:52 unsaved.qsys
-rw-r--r-- 1 benjamin wheel 228K Nov 12 11:08 unsaved.sopcinfo
-rw-r--r-- 1 benjamin wheel 607K Nov 12 11:08 unsaved.xml
                                                                                          
~/workspace/csc10/platformdesigner_tutorial > nios2-elf-gcc -o lights.elf main.c -T linker.ld -m32


~/workspace/csc10/platformdesigner_tutorial > ll
total 1.5M
drwxr-xr-x 8 benjamin wheel 4.0K Nov 15 14:02 .
drwxr-xr-x 4 benjamin wheel 4.0K Nov 15 13:11 ..
drwxr-xr-x 3 benjamin wheel 4.0K Nov 15 12:34 app_software
-rw-r--r-- 1 benjamin wheel 4.7K Nov 12 11:21 c5_pin_model_dump.txt
drwxr-xr-x 3 benjamin wheel  16K Nov 15 14:01 db
drwxr-xr-x 3 benjamin wheel 4.0K Nov 12 11:20 incremental_db
-rw-r--r-- 1 benjamin wheel 1.3K Nov 15 14:02 lights_backup.qsf
-rw-r--r-- 1 benjamin wheel 1.3K Nov 12 10:06 lights.qpf
-rw-r--r-- 1 benjamin wheel  68K Nov 15 14:04 lights.qsf
-rw-r--r-- 1 benjamin wheel  68K Nov 12 11:19 lights.qsf.bak
-rw-r--r-- 1 benjamin wheel  729 Nov 12 11:15 lights.vhd
drwxr-xr-x 3 benjamin wheel 4.0K Nov 15 14:04 nios_system
-rw-r--r-- 1 benjamin wheel  190 Nov 12 11:12 nios_system_bb.v
-rw-r--r-- 1 benjamin wheel 3.5K Nov 12 11:12 nios_system.bsf
-rw-r--r-- 1 benjamin wheel  403 Nov 12 11:12 nios_system.cmp
-rw-r--r-- 1 benjamin wheel  309 Nov 12 11:12 nios_system_inst.v
-rw-r--r-- 1 benjamin wheel  732 Nov 12 11:12 nios_system_inst.vhd
-rw-r--r-- 1 benjamin wheel  39K Nov 15 14:03 nios_system.qsys
-rw-r--r-- 1 benjamin wheel 228K Nov 15 14:04 nios_system.sopcinfo
drwxr-xr-x 2 benjamin wheel 4.0K Nov 12 11:21 output_files
drwxr-xr-x 2 benjamin wheel 4.0K Nov 12 11:12 .qsys_edit
-rw-r--r-- 1 benjamin wheel  395 Nov 12 11:08 unsaved.cmp
-rw-r--r-- 1 benjamin wheel  10K Nov 12 11:08 unsaved_generation.rpt
-rw-r--r-- 1 benjamin wheel  83K Nov 12 11:08 unsaved.html
-rw-r--r-- 1 benjamin wheel  39K Nov 12 10:52 unsaved.qsys
-rw-r--r-- 1 benjamin wheel 228K Nov 12 11:08 unsaved.sopcinfo
-rw-r--r-- 1 benjamin wheel 607K Nov 12 11:08 unsaved.xml

~/workspace/csc10/platformdesigner_tutorial > cd app_software

~/workspace/csc10/platformdesigner_tutorial/app_software > ll
total 28K
drwxr-xr-x 3 benjamin wheel 4.0K Nov 15 12:34 .
drwxr-xr-x 8 benjamin wheel 4.0K Nov 15 14:02 ..
drwxr-xr-x 3 benjamin wheel 4.0K Nov 15 12:34 amp
-rw-r--r-- 1 benjamin wheel  126 Nov 12 11:29 lights.c
-rw-r--r-- 1 benjamin wheel 1.2K Nov 15 13:08 lights_example.amp
-rw-r--r-- 1 benjamin wheel  171 Nov 12 11:25 lights.s
-rw-r--r-- 1 benjamin wheel 1.5K Nov 15 13:08 makefile

~/workspace/csc10/platformdesigner_tutorial/app_software > make

~/workspace/csc10/platformdesigner_tutorial/app_software > /opt/intelFPGA/23.1/quartus/bin64/quartus_pgm -c "DE-SoC [1-2]" --auto
Info: *******************************************************************
Info: Running Quartus Prime Programmer
    Info: Version 23.1std.0 Build 991 11/28/2023 SC Lite Edition
    Info: Copyright (C) 2023  Intel Corporation. All rights reserved.
    Info: Your use of Intel Corporation's design tools, logic functions
    Info: and other software and tools, and any partner logic
    Info: functions, and any output files from any of the foregoing
    Info: (including device programming or simulation files), and any
    Info: associated documentation or information are expressly subject
    Info: to the terms and conditions of the Intel Program License
    Info: Subscription Agreement, the Intel Quartus Prime License Agreement,
    Info: the Intel FPGA IP License Agreement, or other applicable license
    Info: agreement, including, without limitation, that your use is for
    Info: the sole purpose of programming logic devices manufactured by
    Info: Intel and sold by Intel or its authorized distributors.  Please
    Info: refer to the applicable agreement for further details, at
    Info: https://fpgasoftware.intel.com/eula.
    Info: Processing started: Fri Nov 15 14:11:10 2024
Info: Command: quartus_pgm -c "DE-SoC [1-2]" --auto
Info (213045): Using programming cable "DE-SoC [1-2]"
1) DE-SoC [1-2]
  4BA00477   SOCVHPS
  02D120DD   5CSE(BA5|MA5)/5CSTFD5D5/..

Info: Quartus Prime Programmer was successful. 0 errors, 0 warnings
    Info: Peak virtual memory: 272 megabytes
    Info: Processing ended: Fri Nov 15 14:11:10 2024
    Info: Elapsed time: 00:00:00
    Info: Total CPU time (on all processors): 00:00:00

~/workspace/csc10/platformdesigner_tutorial/app_software > make compile
make: *** No rule to make target 'compile'.  Stop.

~/workspace/csc10/platformdesigner_tutorial/app_software > cat Makefile

cat: Makefile: No such file or directory

~/workspace/csc10/platformdesigner_tutorial/app_software > cat makefile
# Created by the Intel FPGA Monitor Program
# DO NOT MODIFY

############################################
# Global Defines
DEFINE_COMMA    := ,

############################################
# Compilation Targets

# Programs
AS              := nios2-elf-as
CC              := nios2-elf-gcc
LD              := nios2-elf-ld
OC              := nios2-elf-objcopy
RM              := rm -f

# Flags
USERCCFLAGS     := -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile
ARCHASFLAGS     := --gstabs -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/sdk/inc/"
ARCHCCFLAGS     := -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u
ARCHLDFLAGS     := --defsym nasys_stack_top=0x1000 --defsym nasys_program_mem=0x0 --defsym nasys_data_mem=0x0
ARCHLDSCRIPT    := --script="/opt/intelFPGA/23.1/University_Program/Monitor_Program/build/nios_as_build.ld"
ASFLAGS         := $(ARCHASFLAGS)
CCFLAGS         := -Wall -c $(USERCCFLAGS) $(ARCHCCFLAGS)
LDFLAGS         := $(ARCHLDFLAGS) $(ARCHLDSCRIPT) -e _start -u _start
OCFLAGS         := -O srec

# Files
HDRS            :=
SRCS            := lights.s
OBJS            := $(patsubst %, %.o, $(SRCS))

# Targets
COMPILE: lights.srec

lights.srec: lights.elf
        $(RM) $@
        $(OC) $(OCFLAGS) $< $@

lights.elf: $(OBJS)
        $(RM) $@
        $(LD) $(LDFLAGS) $(OBJS) -o $@

%.c.o: %.c $(HDRS)
        $(RM) $@
        $(CC) $(CCFLAGS) $< -o $@

%.s.o: %.s $(HDRS)
        $(RM) $@
        $(AS) $(ASFLAGS) $< -o $@

CLEAN:
        $(RM) lights.srec lights.elf $(OBJS)


~/workspace/csc10/platformdesigner_tutorial/app_software > make COMPILE

rm -f lights.s.o
nios2-elf-as --gstabs -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/sdk/inc/" lights.s -o lights.s.o
/bin/sh: line 1: nios2-elf-as: command not found
make: *** [makefile:51: lights.s.o] Error 127

~/workspace/csc10/platformdesigner_tutorial/app_software > make CLEAN
rm -f lights.srec lights.elf  lights.s.o

~/workspace/csc10/platformdesigner_tutorial/app_software > make COMPILE
rm -f lights.s.o
nios2-elf-as --gstabs -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/sdk/inc/" lights.s -o lights.s.o
/bin/sh: line 1: nios2-elf-as: command not found
make: *** [makefile:51: lights.s.o] Error 127

~/workspace/csc10/platformdesigner_tutorial/app_software > source /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh

env_var_delete:4: bad substitution

~/workspace/csc10/platformdesigner_tutorial/app_software > nios2-elf-as --version


~/workspace/csc10/platformdesigner_tutorial/app_software > source /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh
env_var_delete:4: bad substitution

~/workspace/csc10/platformdesigner_tutorial/app_software > /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh
------------------------------------------------
Altera Nios2 Command Shell

Version 23.1, Build 991
------------------------------------------------
[benjamin@envy app_software]$ nios2-elf-as --version
GNU assembler (GNU Binutils) 2.39.50
Copyright (C) 2022 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or later.
This program has absolutely no warranty.
This assembler was configured for a target of `nios2-elf'.
[benjamin@envy app_software]$ make compile
make: *** No rule to make target 'compile'.  Stop.
[benjamin@envy app_software]$ ^C
[benjamin@envy app_software]$
exit

~/workspace/csc10/platformdesigner_tutorial/app_software > make CLEAN

rm -f lights.srec lights.elf  lights.s.o

~/workspace/csc10/platformdesigner_tutorial/app_software > make COMPILE

rm -f lights.s.o
nios2-elf-as --gstabs -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/sdk/inc/" lights.s -o lights.s.o
/bin/sh: line 1: nios2-elf-as: command not found
make: *** [makefile:51: lights.s.o] Error 127

~/workspace/csc10/platformdesigner_tutorial/app_software > cat makefile
# Created by the Intel FPGA Monitor Program
# DO NOT MODIFY

############################################
# Global Defines
DEFINE_COMMA    := ,

############################################
# Compilation Targets

# Programs
AS              := nios2-elf-as
CC              := nios2-elf-gcc
LD              := nios2-elf-ld
OC              := nios2-elf-objcopy
RM              := rm -f

# Flags
USERCCFLAGS     := -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile
ARCHASFLAGS     := --gstabs -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/sdk/inc/"
ARCHCCFLAGS     := -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u
ARCHLDFLAGS     := --defsym nasys_stack_top=0x1000 --defsym nasys_program_mem=0x0 --defsym nasys_data_mem=0x0
ARCHLDSCRIPT    := --script="/opt/intelFPGA/23.1/University_Program/Monitor_Program/build/nios_as_build.ld"
ASFLAGS         := $(ARCHASFLAGS)
CCFLAGS         := -Wall -c $(USERCCFLAGS) $(ARCHCCFLAGS)
LDFLAGS         := $(ARCHLDFLAGS) $(ARCHLDSCRIPT) -e _start -u _start
OCFLAGS         := -O srec

# Files
HDRS            :=
SRCS            := lights.s
OBJS            := $(patsubst %, %.o, $(SRCS))

# Targets
COMPILE: lights.srec

lights.srec: lights.elf
        $(RM) $@
        $(OC) $(OCFLAGS) $< $@

lights.elf: $(OBJS)
        $(RM) $@
        $(LD) $(LDFLAGS) $(OBJS) -o $@

%.c.o: %.c $(HDRS)
        $(RM) $@
        $(CC) $(CCFLAGS) $< -o $@

%.s.o: %.s $(HDRS)
        $(RM) $@
        $(AS) $(ASFLAGS) $< -o $@

CLEAN:
        $(RM) lights.srec lights.elf $(OBJS)


~/workspace/csc10/platformdesigner_tutorial/app_software > source /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh

env_var_delete:4: bad substitution

~/workspace/csc10/platformdesigner_tutorial/app_software > cat

~/workspace/csc10/platformdesigner_tutorial/app_software > cat /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh

#!/bin/bash
############################################################
#                                                          #
# Nios2 Software Build Tools (SBT) Command Shell           #
#                                                          #
# Execute this script to setup an environment for          #
# using the Nios2eds Software Build Tools (SBT)            #
#                                                          #
# This shell uses nios2-elf-gcc                            #
#                                                          #
#                                                          #
# Copyright (c) 2019 Intel Corporation                     #
# All Rights Reserved.                                     #
#                                                          #
############################################################

############################################################
#
# Get the Root ACDS directory
#

# Don't delimit on whitespace so that dirname is happy with
# spaces in paths
IFS=

uname=$(uname -r)
if [[ $uname =~ "Microsoft" ]]
then
    if [ -z $(which wsl 2> /dev/null) ]; then
        echo "Command 'wsl' not found.  Please install with:"
                echo "    sudo apt install wsl"
    fi
        if [ -z $(which make 2> /dev/null) ]; then
        echo "Command 'make' not found.  Please install with:"
                echo "    sudo apt install make"
    fi
        if [ -z $(which dos2unix 2> /dev/null) ]; then
        echo "Command 'dos2unix' not found.  Please install with:"
                echo "    sudo apt install dos2unix"
    fi
        if [ -z $(which wsl 2> /dev/null) ] || [ -z $(which make 2> /dev/null) ] || [ -z $(which dos2unix 2> /dev/null) ]; then
                exit 1
    fi
fi

_this_nios2_command_shell_script=$(cd ${0%[\\/]*} && echo $(pwd 2>/dev/null)/${0##*/})
_ACDS_ROOT=$(dirname $(dirname ${_this_nios2_command_shell_script}))
unset _this_nios2_command_shell_script

if [ ! -d "${_ACDS_ROOT}/nios2eds" ]; then
    echo "${_ACDS_ROOT}/nios2eds not found. Invalid or corrupt ACDS Install" 1>&2
    exit 1
fi

if [ -z "${QUARTUS_ROOTDIR_OVERRIDE}" ]; then
    if [ ! -d "${_ACDS_ROOT}/quartus" ]; then
        echo "${_ACDS_ROOT}/quartus not found. Invalid or corrupt ACDS Install" 1>&2
        exit 1
    fi
fi

############################################################

############################################################
#
# Convenience bash functions for setting up the environment
#

env_var_delete () {
    local var=${2:-PATH}
    local value
    local IFS=':'
    for i in ${!var} ; do
        if [ "$i" != "$1" ] ; then
            value=${value:+$value:}$i
        fi
    done
    export $var="$value"
}

env_var_prepend () {
    env_var_delete $1 $2
    local var=${2:-PATH}
    export $var="$1${!var:+:${!var}}"
}

env_var_append () {
    env_var_delete $1 $2
    local var=${2:-PATH}
    export $var="${!var:+${!var}:}$1"
}
############################################################


############################################################
#
# Setup Quartus II
#

if [ -n "${QUARTUS_ROOTDIR_OVERRIDE}" ]; then
    QUARTUS_ROOTDIR=${QUARTUS_ROOTDIR_OVERRIDE}
else
    QUARTUS_ROOTDIR=${_ACDS_ROOT}/quartus
fi

env_var_prepend "${QUARTUS_ROOTDIR}/sopc_builder/bin"

if [ -d "${QUARTUS_ROOTDIR}/bin64" ]; then
        if [ -d "${QUARTUS_ROOTDIR}/bin32" ]; then
                env_var_prepend "${QUARTUS_ROOTDIR}/bin32"
        fi
    env_var_prepend "${QUARTUS_ROOTDIR}/bin64"
else
    env_var_prepend "${QUARTUS_ROOTDIR}/bin"
fi

export QUARTUS_ROOTDIR
############################################################


############################################################
#
# Setup Modelsim AE
#  (if modelsim_ae/modelsim_ase directory exists and vsim not in PATH)
#

if [ -z "$(which vsim 2>/dev/null)" ]; then

    if [ "${_IS_WINDOWS}" = "1" ]; then
        _VSIM_EXEC_DIR=win32aloem
    else
        _VSIM_EXEC_DIR=linuxaloem
    fi

    if [ -d "${_ACDS_ROOT}/modelsim_ae/${_VSIM_EXEC_DIR}" ]; then
        env_var_prepend "${_ACDS_ROOT}/modelsim_ae/${_VSIM_EXEC_DIR}"
    else
        if [ -d "${_ACDS_ROOT}/modelsim_ase/${_VSIM_EXEC_DIR}" ]; then
            env_var_prepend "${_ACDS_ROOT}/modelsim_ase/${_VSIM_EXEC_DIR}"
        fi
    fi
    unset _VSIM_EXEC_DIR
fi
############################################################


############################################################
#
# Setup Nios2eds (GCC 4)
#

SOPC_KIT_NIOS2=${_ACDS_ROOT}/nios2eds

env_var_prepend "${SOPC_KIT_NIOS2}/bin"
env_var_prepend "${SOPC_KIT_NIOS2}/sdk2/bin"

if grep -q Microsoft /proc/version; then
    if [ -d "${SOPC_KIT_NIOS2}/bin/gnu/H-x86_64-mingw32/bin" ]; then
            env_var_prepend ${SOPC_KIT_NIOS2}/bin/gnu/H-x86_64-mingw32/bin
    else
        env_var_prepend ${SOPC_KIT_NIOS2}/bin/gnu/H-i686-mingw32/bin
    fi
else
    if [ -d "${SOPC_KIT_NIOS2}/bin/gnu/H-x86_64-pc-linux-gnu/bin" ]; then
            env_var_prepend ${SOPC_KIT_NIOS2}/bin/gnu/H-x86_64-pc-linux-gnu/bin
    else
            env_var_prepend ${SOPC_KIT_NIOS2}/bin/gnu/H-i686-pc-linux-gnu/bin
    fi
fi

export SOPC_KIT_NIOS2

# Set Windows Subsystem for Linux environment variable interop between Win32/WSL.
export WSLENV=QUARTUS_ROOTDIR/p:SOPC_KIT_NIOS2/p:PATH/p
############################################################

unset _ACDS_ROOT
unset _NIOS2EDS_ROOT
unset _QUARTUS_ROOT
unset env_var_prepend
unset env_var_append
unset env_var_remove


if [ -n "$*" ]; then
    exec $@
else
    echo "------------------------------------------------"
    echo "Altera Nios2 Command Shell"
    echo
    echo "Version 23.1, Build 991"
    echo "------------------------------------------------"

    # Use bash --norc to get a clean shell
    # Use bash --rcfile <bashrc> to for a user rcfile
    # Default to using ~/.bashrc
    bash
fi

~/workspace/csc10/platformdesigner_tutorial/app_software >

~/workspace/csc10/platformdesigner_tutorial/app_software > source /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh

env_var_delete:4: bad substitution

~/workspace/csc10/platformdesigner_tutorial/app_software > echo $SHELL

/usr/bin/zsh

~/workspace/csc10/platformdesigner_tutorial/app_software > bash
[benjamin@envy app_software]$ source /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh
bash: cd: bash: No such file or directory
dirname: missing operand
Try 'dirname --help' for more information.
dirname: missing operand
Try 'dirname --help' for more information.
/nios2eds not found. Invalid or corrupt ACDS Install

~/workspace/csc10/platformdesigner_tutorial/app_software > bash
[benjamin@envy app_software]$ source /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh
bash: cd: bash: No such file or directory
dirname: missing operand
Try 'dirname --help' for more information.
dirname: missing operand
Try 'dirname --help' for more information.
/nios2eds not found. Invalid or corrupt ACDS Install

~/workspace/csc10/platformdesigner_tutorial/app_software > bash source /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh

bash: source: No such file or directory

~/workspace/csc10/platformdesigner_tutorial/app_software > which nios2-elf-as

nios2-elf-as not found

~/workspace/csc10/platformdesigner_tutorial/app_software > bash

[benjamin@envy app_software]$ echo $SHELL
/usr/bin/zsh
[benjamin@envy app_software]$ echo $0
bash
[benjamin@envy app_software]$ source /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh
bash: cd: bash: No such file or directory
dirname: missing operand
Try 'dirname --help' for more information.
dirname: missing operand
Try 'dirname --help' for more information.
/nios2eds not found. Invalid or corrupt ACDS Install

~/workspace/csc10/platformdesigner_tutorial/app_software > which nios2-elf-as

nios2-elf-as not found

~/workspace/csc10/platformdesigner_tutorial/app_software > /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh

------------------------------------------------
Altera Nios2 Command Shell

Version 23.1, Build 991
------------------------------------------------
[benjamin@envy app_software]$ cd ~/workspace/csc10/platformdesigner_tutorial/app_software
[benjamin@envy app_software]$ which nios2-elf-as
/opt/intelFPGA/23.1/nios2eds/bin/gnu/H-x86_64-pc-linux-gnu/bin/nios2-elf-as
[benjamin@envy app_software]$
[benjamin@envy app_software]$ nios2-elf-as --version
GNU assembler (GNU Binutils) 2.39.50
Copyright (C) 2022 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or later.
This program has absolutely no warranty.
This assembler was configured for a target of `nios2-elf'.
[benjamin@envy app_software]$ ls
amp  lights.c  lights_example.amp  lights.s  makefile
[benjamin@envy app_software]$ make CLEAN
rm -f lights.srec lights.elf  lights.s.o
[benjamin@envy app_software]$ make COMPILE
rm -f lights.s.o
nios2-elf-as --gstabs -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/sdk/inc/" lights.s -o lights.s.o
rm -f lights.elf
nios2-elf-ld --defsym nasys_stack_top=0x1000 --defsym nasys_program_mem=0x0 --defsym nasys_data_mem=0x0 --script="/opt/intelFPGA/23.1/University_Program/Monitor_Program/build/nios_as_build.ld" -e _start -u _start  lights.s.o -o lights.elf
nios2-elf-ld: warning: lights.elf has a LOAD segment with RWX permissions
rm -f lights.srec
nios2-elf-objcopy -O srec lights.elf lights.srec
[benjamin@envy app_software]$ make compile
make: *** No rule to make target 'compile'.  Stop.
[benjamin@envy app_software]$ make COMPILE
make: Nothing to be done for 'COMPILE'.
[benjamin@envy app_software]$ ^C
[benjamin@envy app_software]$
exit

~/workspace/csc10/platformdesigner_tutorial/app_software > /opt/intelFPGA/23.1/quartus/bin64/quartus_pgm -c "DE-SoC [1-2]" --auto
Info: *******************************************************************
Info: Running Quartus Prime Programmer
    Info: Version 23.1std.0 Build 991 11/28/2023 SC Lite Edition
    Info: Copyright (C) 2023  Intel Corporation. All rights reserved.
    Info: Your use of Intel Corporation's design tools, logic functions
    Info: and other software and tools, and any partner logic
    Info: functions, and any output files from any of the foregoing
    Info: (including device programming or simulation files), and any
    Info: associated documentation or information are expressly subject
    Info: to the terms and conditions of the Intel Program License
    Info: Subscription Agreement, the Intel Quartus Prime License Agreement,
    Info: the Intel FPGA IP License Agreement, or other applicable license
    Info: agreement, including, without limitation, that your use is for
    Info: the sole purpose of programming logic devices manufactured by
    Info: Intel and sold by Intel or its authorized distributors.  Please
    Info: refer to the applicable agreement for further details, at
    Info: https://fpgasoftware.intel.com/eula.
    Info: Processing started: Fri Nov 15 14:22:03 2024
Info: Command: quartus_pgm -c "DE-SoC [1-2]" --auto
Info (213045): Using programming cable "DE-SoC [1-2]"
1) DE-SoC [1-2]
  4BA00477   SOCVHPS
  02D120DD   5CSE(BA5|MA5)/5CSTFD5D5/..

Info: Quartus Prime Programmer was successful. 0 errors, 0 warnings
    Info: Peak virtual memory: 272 megabytes
    Info: Processing ended: Fri Nov 15 14:22:04 2024
    Info: Elapsed time: 00:00:01
    Info: Total CPU time (on all processors): 00:00:00

~/workspace/csc10/platformdesigner_tutorial/app_software > /opt/intelFPGA/23.1/nios2eds/nios2_command_shell.sh

------------------------------------------------
Altera Nios2 Command Shell

Version 23.1, Build 991
------------------------------------------------
[benjamin@envy app_software]$ nios2-elf-as --gstabs -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/sdk/inc/" lights.s -o lights.s.o
[benjamin@envy app_software]$ nios2-elf-ld --defsym nasys_stack_top=0x1000 --defsym nasys_program_mem=0x0 --defsym nasys_data_mem=0x0 --script="/opt/intelFPGA/23.1/University_Progr
am/Monitor_Program/build/nios_as_build.ld" -e _start -u _start lights.s.o -o lights.elf
nios2-elf-ld: warning: lights.elf has a LOAD segment with RWX permissions
[benjamin@envy app_software]$ nios2-elf-objcopy -O srec lights.elf lights.srec
[benjamin@envy app_software]$ ls -l
total 36
drwxr-xr-x 3 benjamin wheel 4096 Nov 15 12:34 amp
-rw-r--r-- 1 benjamin wheel  126 Nov 12 11:29 lights.c
-rwxr-xr-x 1 benjamin wheel 5524 Nov 15 14:22 lights.elf
-rw-r--r-- 1 benjamin wheel 1189 Nov 15 13:08 lights_example.amp
-rw-r--r-- 1 benjamin wheel  171 Nov 12 11:25 lights.s
-rw-r--r-- 1 benjamin wheel  908 Nov 15 14:22 lights.s.o
-rwxr-xr-x 1 benjamin wheel  126 Nov 15 14:22 lights.srec
-rw-r--r-- 1 benjamin wheel 1443 Nov 15 13:08 makefile
[benjamin@envy app_software]$ /opt/intelFPGA/23.1/quartus/bin64/quartus_pgm -c "DE-SoC [1-2]" --auto
Info: *******************************************************************
Info: Running Quartus Prime Programmer
    Info: Version 23.1std.0 Build 991 11/28/2023 SC Lite Edition
    Info: Copyright (C) 2023  Intel Corporation. All rights reserved.
    Info: Your use of Intel Corporation's design tools, logic functions
    Info: and other software and tools, and any partner logic
    Info: functions, and any output files from any of the foregoing
    Info: (including device programming or simulation files), and any
    Info: associated documentation or information are expressly subject
    Info: to the terms and conditions of the Intel Program License
    Info: Subscription Agreement, the Intel Quartus Prime License Agreement,
    Info: the Intel FPGA IP License Agreement, or other applicable license
    Info: agreement, including, without limitation, that your use is for
    Info: the sole purpose of programming logic devices manufactured by
    Info: Intel and sold by Intel or its authorized distributors.  Please
    Info: refer to the applicable agreement for further details, at
    Info: https://fpgasoftware.intel.com/eula.
    Info: Processing started: Fri Nov 15 14:22:55 2024
Info: Command: quartus_pgm -c "DE-SoC [1-2]" --auto
Info (213045): Using programming cable "DE-SoC [1-2]"
1) DE-SoC [1-2]
  4BA00477   SOCVHPS
  02D120DD   5CSE(BA5|MA5)/5CSTFD5D5/..

Info: Quartus Prime Programmer was successful. 0 errors, 0 warnings
    Info: Peak virtual memory: 272 megabytes
    Info: Processing ended: Fri Nov 15 14:22:55 2024
    Info: Elapsed time: 00:00:00
    Info: Total CPU time (on all processors): 00:00:00
[benjamin@envy app_software]$ nios2-download -g lights.srec
Another application is using the target processor (or is using the JTAG cable
in a way which conflicts with our request to use the target processor).
Please close down that application and try again.
[benjamin@envy app_software]$ nios2-download -g lights.srec
Using cable "DE-SoC [1-2]", device 2, instance 0x00
Pausing target processor: OK
Initializing CPU cache (if present)
OK
Downloaded 1KB in 0.0s
Verified OK
Starting processor at address 0x00000000
[benjamin@envy app_software]$ nios2-elf-as --gstabs -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/sdk/inc/" lights.s -o lights.s.o^C
[benjamin@envy app_software]$ SRCS := lights.s
bash: SRCS: command not found
[benjamin@envy app_software]$ n makefile
bash: n: command not found
[benjamin@envy app_software]$ vim makefile
[benjamin@envy app_software]$ vim makefile
[benjamin@envy app_software]$ vim makefile
[benjamin@envy app_software]$ make CLEAN
rm -f lights.srec lights.elf lights.o amp/lib/src/niosII_jtag_uart.o
[benjamin@envy app_software]$ make COMPILE
rm -f lights.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c lights.c -o lights.o
lights.c:3:6: warning: return type of 'main' is not 'int' [-Wmain]
    3 | void main() {
      |      ^~~~
rm -f amp/lib/src/niosII_jtag_uart.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c amp/lib/src/niosII_jtag_uart.c -o amp/lib/src/niosII_jtag_uart.o
rm -f lights.elf
nios2-elf-gcc  -Wl,--defsym  -Wl,nasys_stack_top=0x1000  -Wl,--defsym  -Wl,nasys_program_mem=0x0  -Wl,--defsym  -Wl,nasys_data_mem=0x0  -Wl,--script="/opt/intelFPGA/23.1/University_Program/Monitor_Program/build/nios_cpp_build.ld" lights.o amp/lib/src/niosII_jtag_uart.o -o lights.elf
/opt/intelFPGA/23.1/nios2eds/bin/gnu/H-x86_64-pc-linux-gnu/bin/../lib/gcc/nios2-elf/12.3.1/../../../../../H-x86_64-pc-linux-gnu/nios2-elf/bin/ld: warning: lights.elf has a LOAD segment with RWX permissions
rm -f lights.srec
nios2-elf-objcopy -O srec lights.elf lights.srec
[benjamin@envy app_software]$ /opt/intelFPGA/23.1/quartus/bin64/quartus_pgm -c "DE-SoC [1-2]" --auto
Info: *******************************************************************
Info: Running Quartus Prime Programmer
    Info: Version 23.1std.0 Build 991 11/28/2023 SC Lite Edition
    Info: Copyright (C) 2023  Intel Corporation. All rights reserved.
    Info: Your use of Intel Corporation's design tools, logic functions
    Info: and other software and tools, and any partner logic
    Info: functions, and any output files from any of the foregoing
    Info: (including device programming or simulation files), and any
    Info: associated documentation or information are expressly subject
    Info: to the terms and conditions of the Intel Program License
    Info: Subscription Agreement, the Intel Quartus Prime License Agreement,
    Info: the Intel FPGA IP License Agreement, or other applicable license
    Info: agreement, including, without limitation, that your use is for
    Info: the sole purpose of programming logic devices manufactured by
    Info: Intel and sold by Intel or its authorized distributors.  Please
    Info: refer to the applicable agreement for further details, at
    Info: https://fpgasoftware.intel.com/eula.
    Info: Processing started: Fri Nov 15 14:38:16 2024
Info: Command: quartus_pgm -c "DE-SoC [1-2]" --auto
Info (213045): Using programming cable "DE-SoC [1-2]"
1) DE-SoC [1-2]
  4BA00477   SOCVHPS
  02D120DD   5CSE(BA5|MA5)/5CSTFD5D5/..

Info: Quartus Prime Programmer was successful. 0 errors, 0 warnings
    Info: Peak virtual memory: 272 megabytes
    Info: Processing ended: Fri Nov 15 14:38:17 2024
    Info: Elapsed time: 00:00:01
    Info: Total CPU time (on all processors): 00:00:00
[benjamin@envy app_software]$ make CLEAN
rm -f lights.srec lights.elf lights.o amp/lib/src/niosII_jtag_uart.o
[benjamin@envy app_software]$ make COMPILE
rm -f lights.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c lights.c -o lights.o
lights.c:3:6: warning: return type of 'main' is not 'int' [-Wmain]
    3 | void main() {
      |      ^~~~
rm -f amp/lib/src/niosII_jtag_uart.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c amp/lib/src/niosII_jtag_uart.c -o amp/lib/src/niosII_jtag_uart.o
rm -f lights.elf
nios2-elf-gcc  -Wl,--defsym  -Wl,nasys_stack_top=0x1000  -Wl,--defsym  -Wl,nasys_program_mem=0x0  -Wl,--defsym  -Wl,nasys_data_mem=0x0  -Wl,--script="/opt/intelFPGA/23.1/University_Program/Monitor_Program/build/nios_cpp_build.ld" lights.o amp/lib/src/niosII_jtag_uart.o -o lights.elf
/opt/intelFPGA/23.1/nios2eds/bin/gnu/H-x86_64-pc-linux-gnu/bin/../lib/gcc/nios2-elf/12.3.1/../../../../../H-x86_64-pc-linux-gnu/nios2-elf/bin/ld: warning: lights.elf has a LOAD segment with RWX permissions
rm -f lights.srec
nios2-elf-objcopy -O srec lights.elf lights.srec
[benjamin@envy app_software]$ make CLEAN
rm -f lights.srec lights.elf lights.o amp/lib/src/niosII_jtag_uart.o
[benjamin@envy app_software]$ make COMPILE
rm -f lights.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c lights.c -o lights.o
lights.c:3:6: warning: return type of 'main' is not 'int' [-Wmain]
    3 | void main() {
      |      ^~~~
rm -f amp/lib/src/niosII_jtag_uart.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c amp/lib/src/niosII_jtag_uart.c -o amp/lib/src/niosII_jtag_uart.o
rm -f lights.elf
nios2-elf-gcc  -Wl,--defsym  -Wl,nasys_stack_top=0x1000  -Wl,--defsym  -Wl,nasys_program_mem=0x0  -Wl,--defsym  -Wl,nasys_data_mem=0x0  -Wl,--script="/opt/intelFPGA/23.1/University_Program/Monitor_Program/build/nios_cpp_build.ld" lights.o amp/lib/src/niosII_jtag_uart.o -o lights.elf
/opt/intelFPGA/23.1/nios2eds/bin/gnu/H-x86_64-pc-linux-gnu/bin/../lib/gcc/nios2-elf/12.3.1/../../../../../H-x86_64-pc-linux-gnu/nios2-elf/bin/ld: warning: lights.elf has a LOAD segment with RWX permissions
rm -f lights.srec
nios2-elf-objcopy -O srec lights.elf lights.srec
[benjamin@envy app_software]$ make CLEAN
rm -f lights.srec lights.elf lights.o amp/lib/src/niosII_jtag_uart.o
[benjamin@envy app_software]$ make COMPILE
rm -f lights.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c lights.c -o lights.o
lights.c:3:6: warning: return type of 'main' is not 'int' [-Wmain]
    3 | void main() {
      |      ^~~~
rm -f amp/lib/src/niosII_jtag_uart.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c amp/lib/src/niosII_jtag_uart.c -o amp/lib/src/niosII_jtag_uart.o
rm -f lights.elf
nios2-elf-gcc  -Wl,--defsym  -Wl,nasys_stack_top=0x1000  -Wl,--defsym  -Wl,nasys_program_mem=0x0  -Wl,--defsym  -Wl,nasys_data_mem=0x0  -Wl,--script="/opt/intelFPGA/23.1/University_Program/Monitor_Program/build/nios_cpp_build.ld" lights.o amp/lib/src/niosII_jtag_uart.o -o lights.elf
/opt/intelFPGA/23.1/nios2eds/bin/gnu/H-x86_64-pc-linux-gnu/bin/../lib/gcc/nios2-elf/12.3.1/../../../../../H-x86_64-pc-linux-gnu/nios2-elf/bin/ld: warning: lights.elf has a LOAD segment with RWX permissions
rm -f lights.srec
nios2-elf-objcopy -O srec lights.elf lights.srec
[benjamin@envy app_software]$ /opt/intelFPGA/23.1/quartus/bin64/quartus_pgm -c "DE-SoC [1-2]" --auto
Info: *******************************************************************
Info: Running Quartus Prime Programmer
    Info: Version 23.1std.0 Build 991 11/28/2023 SC Lite Edition
    Info: Copyright (C) 2023  Intel Corporation. All rights reserved.
    Info: Your use of Intel Corporation's design tools, logic functions
    Info: and other software and tools, and any partner logic
    Info: functions, and any output files from any of the foregoing
    Info: (including device programming or simulation files), and any
    Info: associated documentation or information are expressly subject
    Info: to the terms and conditions of the Intel Program License
    Info: Subscription Agreement, the Intel Quartus Prime License Agreement,
    Info: the Intel FPGA IP License Agreement, or other applicable license
    Info: agreement, including, without limitation, that your use is for
    Info: the sole purpose of programming logic devices manufactured by
    Info: Intel and sold by Intel or its authorized distributors.  Please
    Info: refer to the applicable agreement for further details, at
    Info: https://fpgasoftware.intel.com/eula.
    Info: Processing started: Fri Nov 15 14:56:24 2024
Info: Command: quartus_pgm -c "DE-SoC [1-2]" --auto
Info (213045): Using programming cable "DE-SoC [1-2]"
1) DE-SoC [1-2]
  4BA00477   SOCVHPS
  02D120DD   5CSE(BA5|MA5)/5CSTFD5D5/..

Info: Quartus Prime Programmer was successful. 0 errors, 0 warnings
    Info: Peak virtual memory: 272 megabytes
    Info: Processing ended: Fri Nov 15 14:56:24 2024
    Info: Elapsed time: 00:00:00
    Info: Total CPU time (on all processors): 00:00:00
[benjamin@envy app_software]$ make CLEAN
rm -f lights.srec lights.elf lights.o amp/lib/src/niosII_jtag_uart.o
[benjamin@envy app_software]$ make COMPILE
rm -f lights.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c lights.c -o lights.o
rm -f amp/lib/src/niosII_jtag_uart.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c amp/lib/src/niosII_jtag_uart.c -o amp/lib/src/niosII_jtag_uart.o
rm -f lights.elf
nios2-elf-gcc  -Wl,--defsym  -Wl,nasys_stack_top=0x1000  -Wl,--defsym  -Wl,nasys_program_mem=0x0  -Wl,--defsym  -Wl,nasys_data_mem=0x0  -Wl,--script="/opt/intelFPGA/23.1/University_Program/Monitor_Program/build/nios_cpp_build.ld" lights.o amp/lib/src/niosII_jtag_uart.o -o lights.elf
/opt/intelFPGA/23.1/nios2eds/bin/gnu/H-x86_64-pc-linux-gnu/bin/../lib/gcc/nios2-elf/12.3.1/../../../../../H-x86_64-pc-linux-gnu/nios2-elf/bin/ld: warning: lights.elf has a LOAD segment with RWX permissions
rm -f lights.srec
nios2-elf-objcopy -O srec lights.elf lights.srec
[benjamin@envy app_software]$ /opt/intelFPGA/23.1/quartus/bin64/quartus_pgm -c "DE-SoC [1-2]" --auto
Info: *******************************************************************
Info: Running Quartus Prime Programmer
    Info: Version 23.1std.0 Build 991 11/28/2023 SC Lite Edition
    Info: Copyright (C) 2023  Intel Corporation. All rights reserved.
    Info: Your use of Intel Corporation's design tools, logic functions
    Info: and other software and tools, and any partner logic
    Info: functions, and any output files from any of the foregoing
    Info: (including device programming or simulation files), and any
    Info: associated documentation or information are expressly subject
    Info: to the terms and conditions of the Intel Program License
    Info: Subscription Agreement, the Intel Quartus Prime License Agreement,
    Info: the Intel FPGA IP License Agreement, or other applicable license
    Info: agreement, including, without limitation, that your use is for
    Info: the sole purpose of programming logic devices manufactured by
    Info: Intel and sold by Intel or its authorized distributors.  Please
    Info: refer to the applicable agreement for further details, at
    Info: https://fpgasoftware.intel.com/eula.
    Info: Processing started: Fri Nov 15 14:57:27 2024
Info: Command: quartus_pgm -c "DE-SoC [1-2]" --auto
Info (213045): Using programming cable "DE-SoC [1-2]"
1) DE-SoC [1-2]
  4BA00477   SOCVHPS
  02D120DD   5CSE(BA5|MA5)/5CSTFD5D5/..

Info: Quartus Prime Programmer was successful. 0 errors, 0 warnings
    Info: Peak virtual memory: 272 megabytes
    Info: Processing ended: Fri Nov 15 14:57:27 2024
    Info: Elapsed time: 00:00:00
    Info: Total CPU time (on all processors): 00:00:00
[benjamin@envy app_software]$ /opt/intelFPGA/23.1/quartus/bin64/quartus_pgm -c "DE-SoC [1-2]" --auto
Info: *******************************************************************
Info: Running Quartus Prime Programmer
    Info: Version 23.1std.0 Build 991 11/28/2023 SC Lite Edition
    Info: Copyright (C) 2023  Intel Corporation. All rights reserved.
    Info: Your use of Intel Corporation's design tools, logic functions
    Info: and other software and tools, and any partner logic
    Info: functions, and any output files from any of the foregoing
    Info: (including device programming or simulation files), and any
    Info: associated documentation or information are expressly subject
    Info: to the terms and conditions of the Intel Program License
    Info: Subscription Agreement, the Intel Quartus Prime License Agreement,
    Info: the Intel FPGA IP License Agreement, or other applicable license
    Info: agreement, including, without limitation, that your use is for
    Info: the sole purpose of programming logic devices manufactured by
    Info: Intel and sold by Intel or its authorized distributors.  Please
    Info: refer to the applicable agreement for further details, at
    Info: https://fpgasoftware.intel.com/eula.
    Info: Processing started: Fri Nov 15 14:57:57 2024
Info: Command: quartus_pgm -c "DE-SoC [1-2]" --auto
Info (213045): Using programming cable "DE-SoC [1-2]"
1) DE-SoC [1-2]
  4BA00477   SOCVHPS
  02D120DD   5CSE(BA5|MA5)/5CSTFD5D5/..

Info: Quartus Prime Programmer was successful. 0 errors, 0 warnings
    Info: Peak virtual memory: 272 megabytes
    Info: Processing ended: Fri Nov 15 14:57:57 2024
    Info: Elapsed time: 00:00:00
    Info: Total CPU time (on all processors): 00:00:00
[benjamin@envy app_software]$ vim makefile
[benjamin@envy app_software]$ make clean
make: *** No rule to make target 'clean'.  Stop.
[benjamin@envy app_software]$ make CLEAN
rm -f lights.srec lights.elf lights.o amp/lib/src/niosII_jtag_uart.o
[benjamin@envy app_software]$ make COMPILE
rm -f lights.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c lights.c -o lights.o
rm -f amp/lib/src/niosII_jtag_uart.o
nios2-elf-gcc -Wall -c -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile -mno-hw-mul -mno-hw-div -I "/opt/intelFPGA/23.1/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=8224u -c amp/lib/src/niosII_jtag_uart.c -o amp/lib/src/niosII_jtag_uart.o
rm -f lights.elf
nios2-elf-gcc  -Wl,--defsym  -Wl,nasys_stack_top=0x1000  -Wl,--defsym  -Wl,nasys_program_mem=0x0  -Wl,--defsym  -Wl,nasys_data_mem=0x0  -Wl,--script="/opt/intelFPGA/23.1/University_Program/Monitor_Program/build/nios_cpp_build.ld" lights.o amp/lib/src/niosII_jtag_uart.o -o lights.elf
/opt/intelFPGA/23.1/nios2eds/bin/gnu/H-x86_64-pc-linux-gnu/bin/../lib/gcc/nios2-elf/12.3.1/../../../../../H-x86_64-pc-linux-gnu/nios2-elf/bin/ld: warning: lights.elf has a LOAD segment with RWX permissions
rm -f lights.srec
nios2-elf-objcopy -O srec lights.elf lights.srec
[benjamin@envy app_software]$ /opt/intelFPGA/23.1/quartus/bin64/quartus_pgm -c "DE-SoC [1-2]" --auto
Info: *******************************************************************
Info: Running Quartus Prime Programmer
    Info: Version 23.1std.0 Build 991 11/28/2023 SC Lite Edition
    Info: Copyright (C) 2023  Intel Corporation. All rights reserved.
    Info: Your use of Intel Corporation's design tools, logic functions
    Info: and other software and tools, and any partner logic
    Info: functions, and any output files from any of the foregoing
    Info: (including device programming or simulation files), and any
    Info: associated documentation or information are expressly subject
    Info: to the terms and conditions of the Intel Program License
    Info: Subscription Agreement, the Intel Quartus Prime License Agreement,
    Info: the Intel FPGA IP License Agreement, or other applicable license
    Info: agreement, including, without limitation, that your use is for
    Info: the sole purpose of programming logic devices manufactured by
    Info: Intel and sold by Intel or its authorized distributors.  Please
    Info: refer to the applicable agreement for further details, at
    Info: https://fpgasoftware.intel.com/eula.
    Info: Processing started: Fri Nov 15 15:07:45 2024
Info: Command: quartus_pgm -c "DE-SoC [1-2]" --auto
Info (213045): Using programming cable "DE-SoC [1-2]"
1) DE-SoC [1-2]
  4BA00477   SOCVHPS
  02D120DD   5CSE(BA5|MA5)/5CSTFD5D5/..

Info: Quartus Prime Programmer was successful. 0 errors, 0 warnings
    Info: Peak virtual memory: 272 megabytes
    Info: Processing ended: Fri Nov 15 15:07:45 2024
    Info: Elapsed time: 00:00:00
    Info: Total CPU time (on all processors): 00:00:00
[benjamin@envy app_software]$
