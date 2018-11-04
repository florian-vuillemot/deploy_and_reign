if [ $# -eq 0 ] || [ $1 == "-h" ] || [ $1 == "--help" ]
then
    if [ $# -eq 0 ]
       then
           echo "No arguments supplied"
    fi
    echo "./$0 minion_name"
    exit -1
fi

sudo salt $1 pkg.upgrade --timeout=120 >& /tmp/update_linux.log

if [ $? -eq 0 ]
then
    echo "Update: success"
else
    echo "Update: failed (see log in /tmp/update_linux.log)"
fi
