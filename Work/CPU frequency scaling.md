# CPU Frequency Scaling

Checking if hyperthreading is enable or disable; if silbling count is equal to cpu core count then HT is disable. if double HT is enable.
```
grep -E "cpu cores|siblings|physical id" /proc/cpuinfo |xargs -n 11 echo |sort |uniq
    physical id : 0 siblings : 24 cpu cores : 24
    physical id : 1 siblings : 24 cpu cores : 24
```
 
```
 /sys/devices/system/cpu/smt/control:
```
     This file allows to read out the SMT control state and provides the
     ability to disable or (re)enable SMT. The possible states are:

        ==============  ===================================================
        on              SMT is supported by the CPU and enabled. All
                        logical CPUs can be onlined and offlined without
                        restrictions.

        off             SMT is supported by the CPU and disabled. Only
                        the so called primary SMT threads can be onlined
                        and offlined without restrictions. An attempt to
                        online a non-primary sibling is rejected

        forceoff        Same as 'off' but the state cannot be controlled.
                        Attempts to write to the control file are rejected.

        notsupported    The processor does not support SMT. It's therefore
                        not affected by the SMT implications of L1TF.
                        Attempts to write to the control file are rejected.
        ==============  ===================================================

The possible states which can be written into this file to control SMT state are:
- on
- off
- forceoff
---

Controls the turbo boost setting for the whole system. You can read and write the below file with either "0" (boosting disabled) or "1" (boosting allowed).
```
echo "[0|1]" > /sys/devices/system/cpu/cpufreq/boost
```

AMD CPU frequency for CM
```
#[root@kratosn05 ~]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
#2350000 2000000 1500000
#add 1 for the last digit
qmgr -c "create queue f2351 "
qmgr -c "set queue f2351 queue_type = Execution "
qmgr -c "set queue f2351 enabled = True "
qmgr -c "set queue f2351 started = True "
qmgr -c "create queue f2351THPnoHT "
qmgr -c "set queue f2351THPnoHT queue_type = Execution "
qmgr -c "set queue f2351THPnoHT enabled = True "
qmgr -c "set queue f2351THPnoHT started = True "
qmgr -c "create queue f2351noHT "
qmgr -c "set queue f2351noHT queue_type = Execution "
qmgr -c "set queue f2351noHT enabled = True "
qmgr -c "set queue f2351noHT started = True "
qmgr -c "create queue f2351THP "
qmgr -c "set queue f2351THP queue_type = Execution "
qmgr -c "set queue f2351THP enabled = True "
qmgr -c "set queue f2351THP started = True "
#Then run this to check that the queue was created  ..... qstat -Q
```

turbo status

```
/bin/turbostat
################# output ################  
Package Core    CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz
-       -       -       1009    100.00  1000    2523
0       0       0       1016    100.00  1000    2541 
0       1       1       1016    100.00  1000    2541 
0       2       2       1016    100.00  1000    2541
                :               :               :
################ end #####################
```

The usage is 100% but the CPU frequency has been low.

```
% cat marirun.o7326
Start Prologue v3.6 Sun Aug  4 22:09:35 CDT 2019
cat: /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: No such file or directory
cat: /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: No such file or directory
cat: /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: No such file or directory
End Prologue v3.6 Sun Aug  4 22:09:41 CDT 2019
  Product Name: ProLiant XL170r Gen10         Nodes:apollon[034-045]
     Board MFG:  HPE
HPE
          BIOS: U38 - 05/21/2019 - 2.10
    Processors: 2 x 20 Intel(R) Xeon(R) Gold 6248 CPU @ 2.50GHz   Hyperthreading: Enabled
     Total Mem: 384 GB Speed: 2666MT/s
    OS Release: Redhat 7.6
    Kernel Ver: 3.10.0-957.el7.x86_64
      MLNX KIT: 4.6-1.0.1.1
     MLNX RATE:
        Lustre: 2.10.6
Setting of /sys/kernel/debug/x86/pti_enabled is 0
Setting of /sys/kernel/debug/x86/ibpb_enabled is 1
Setting of /sys/kernel/debug/x86/ibrs_enabled is 4
Unmatched `.
Start Epilogue v3.6 Sun Aug  4 22:49:33 CDT 2019
cat: /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: No such file or directory
cat: /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: No such file or directory
cat: /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: No such file or directory
```

Go into bios and change the 'Workload Profile' to 'HPC' then save then change to 'Custom'.
Head to 'Power and Performance Options' change 'Power Regulator' to 'OS control Mode'
install conrep to the hostname
```
conrep -s -f [file path]
```

then run the xml file to the rest of the nodes
```
pdsh -w [nodes] conrep -l -f [file path]
```



# CPU Frequency 

install linux-tools-common for cpupower command
information about cpu power frequency

```
cpupower frequency-info
```

Setting maximum and minimum frequencies
In rare cases, it may be necessary to manually set maximum and minimum frequencies.

To set the maximum clock frequency (clock_freq is a clock frequency with units: GHz, MHz):

```
cpupower frequency-set -u clock_freq
```

To set the minimum clock frequency:

```
cpupower frequency-set -d clock_freq
```

To set the CPU to run at a specified frequency:

```
cpupower frequency-set -f clock_freq
```



# CPU Governor
Setting Governor CPU frequency
Governor	Description
performance	: Run the CPU at the maximum frequency.
powersave	: Run the CPU at the minimum frequency.
userspace	: Run the CPU at user specified frequencies.
ondemand	: Scales the frequency dynamically according to current load. Jumps to the highest frequency and then possibly back off as the idle time increases.
conservative	: Scales the frequency dynamically according to current load. Scales the frequency more gradually than ondemand.
schedutil	: Scheduler-driven CPU frequency selection

```  
echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
# (note you have to do this for each logical cpu)
```

or install linux-tools-common for cpupower command
```
cpupower frequency-set -g [governor]
```

To monitor cpu speed in real time, run:

```
watch grep \"cpu MHz\" /proc/cpuinfo
```






# acpi cpufreq driver 
Install conrep. hp-scripting-tools-11.30-29.rhel7.x86_64.rpm
Save the current BIOS settings just in case:

```
conrep --save --filename ${HOSTNAME}-before.xml
```

In the BIOS, change

```
      Workload_Profile -> Custom
      Power_Regulator -> OS_Control_Mode
      Energy/Performance Bias -> Maximum_Performance
```

There's an XML file at znode53:/root/acpi_cpufreq-bios.xml to make these changes with conrep.  Copy it over to the node and do

```
conrep --load --filename acpi_cpufreq-bios.xml
```

Edit /etc/default/grub and add "intel_pstate=disable" to GRUB_CMDLINE_LINUX.  For example, on znode53, the new string became:

```
GRUB_CMDLINE_LINUX="crashkernel=auto rhgb quiet nouveau.modeset=0 rd.driver.blacklist=nouveau intel_pstate=disable"
```

Regenerate the grub config:

```
grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg     #(rhel)
update-grub     #(ubuntu)
Reboot
```

After the reboot is complete, check to make sure the acpi-cpufreq driver is loaded:

```
cpupower frequency-info | grep driver
    driver: acpi-cpufreq
```

If cpupower frequency-info | grep driver shows no or unknown cpupower driver then you need to set the bios to 'OS Control'

Now you can set the frequency to any of the values in 

```
cpupower frequency-info | grep 'available frequency steps'
    the available frequencies are 2.50 GHz, 2.40 GHz, 2.30 GHz, 2.20 GHz, 2.10 GHz, 2.00 GHz, 1.90 GHz, 1.70 GHz, 1.60 GHz, 1.50 GHz, 1.40 GHz, 1.30 GHz, 1.20 GHz, 1.10 GHz, 1000 MHz.
```

Change the frequency to the highest available and set the performance governor to "performance":

```
cpupower frequency-set -g performance --min 2500MHz --max 2500MHz
```

turbo

```
cpupower frequency-set -g performance --min 2501MHz --max 2501MHz
```

check that all the CPUs are running in turbo with:

```
cpupower frequency-info -o
```

All the CPUs should say 2501000 KHz.  If turbo isn't on, they'll say 2500000 kHz.
  
  
Make sure all the cores have the frequency you set:

```
grep MHz /proc/cpuinfo
```



