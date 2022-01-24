#!/bin/sh

installer_path=$PWD

echo "[+] Checking for required dependencies..."
if command -v git >/dev/null 2>&1 ; then
    echo "[-] Git found!"
else
    echo "[-] Git not found! Aborting..."
    echo "[-] Please install git and try again."
fi

if [ -f ~/.gdbinit ] || [ -h ~/.gdbinit ]; then
    echo "[+] backing up gdbinit file"
    cp ~/.gdbinit ~/.gdbinit.back_up
fi

# download peda and decide whether to overwrite if exists
if [ -d ~/tools/peda ] || [ -h ~/.tools/peda ]; then
    echo "[-] PEDA found"
    read -p "skip download to continue? (enter 'y' or 'n') " skip_peda

    if [ $skip_peda = 'n' ]; then
        rm -rf ~/tools/peda
        git clone https://github.com/longld/peda.git ~/tools/peda
    else
        echo "PEDA skipped"
    fi
else
    echo "[+] Downloading PEDA..."
    git clone https://github.com/longld/peda.git ~/tools/peda
fi

# download peda arm
if [ -d ~/tools/peda-arm ] || [ -h ~/.tools/peda ]; then
    echo "[-] PEDA ARM found"
    read -p "skip download to continue? (enter 'y' or 'n') " skip_peda

    if [ $skip_peda = 'n' ]; then
        rm -rf ~/tools/peda-arm
	git clone https://github.com/alset0326/peda-arm.git
    else
	echo "PEDA ARM skipped"
    fi
else	    
    echo "[+] Downloading PEDA ARM..."
    git clone https://github.com/alset0326/peda-arm.git ~/tools/peda-arm
fi

# download pwndbg
if [ -d ~/tools/pwndbg ] || [ -h ~/.tools/pwndbg ]; then
    echo "[-] Pwndbg found"
    read -p "skip download to continue? (enter 'y' or 'n') " skip_pwndbg

    if [ $skip_pwndbg = 'n' ]; then
        rm -rf ~/tools/pwndbg
        git clone https://github.com/pwndbg/pwndbg.git ~/tools/pwndbg

        cd ~/tools/pwndbg
        ./setup.sh
    else
        echo "Pwndbg skipped"
    fi
else
    echo "[+] Downloading Pwndbg..."
    git clone https://github.com/pwndbg/pwndbg.git ~/tools/pwndbg

    cd ~/tools/pwndbg
    ./setup.sh
fi

# download gef
echo "[+] Downloading GEF..."
git clone https://github.com/hugsy/gef.git ~/tools/gef

cd $installer_path

echo "[+] Setting .gdbinit..."
cp gdbinit ~/.gdbinit

{
  echo "[+] Creating files..."
    sudo cp gdb-peda /usr/bin/gdb-peda &&\
    sudo cp gdb-peda-arm /usr/bin/gdb-peda-arm &&\
    sudo cp gdb-peda-intel /usr/bin/gdb-peda-intel &&\
    sudo cp gdb-pwndbg /usr/bin/gdb-pwndbg &&\
    sudo cp gdb-gef /usr/bin/gdb-gef
} || {
  echo "[-] Permission denied"
    exit
}

{
  echo "[+] Setting permissions..."
    sudo chmod +x /usr/bin/gdb-*
} || {
  echo "[-] Permission denied"
    exit
}

echo "[+] Done"
