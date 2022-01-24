define init-peda
source ~/tools/peda/peda.py
end
document init-peda
Initializes the PEDA (Python Exploit Development Assistant for GDB) framework
end

define init-peda-arm
source ~/tools/peda-arm/peda-arm.py
end
document init-peda-arm
Initializes the PEDA (Python Exploit Development Assistant for GDB) framework for ARM.
end

define init-peda-intel
source ~/tools/peda-arm/peda-intel.py
end
document init-peda-intel
Initializes the PEDA (Python Exploit Development Assistant for GDB) framework for INTEL.
end

define init-pwndbg
source ~/tools/pwndbg/gdbinit.py
end
document init-pwndbg
Initializes PwnDBG
end

define init-gef
source ~/tools/gef/gef.py
end
document init-gef
Initializes GEF (GDB Enhanced Features)
end
