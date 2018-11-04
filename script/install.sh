if [ $# -ne 2 ] || [ $1 == "-h" ] || [ $1 == "--help" ]
then
    if [ $# -ne 2 ]
       then
           echo "No arguments supplied"
    fi
    echo "./$0 minion_name software_name"
    exit -1
fi

sudo salt $1 pkg.install $2 --timeout=120 >& /tmp/salstack_install.log

if [ $? -eq 0 ]
then
    echo "Installation: success"
else
    echo "Installation: failed (see log in /tmp/salstack_install.log)"
fi
