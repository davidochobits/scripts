#Sources: https://stackoverflow.com/questions/12845206/check-if-file-exists-on-remote-host-with-ssh

host="<remote-host>"
user="<user>"
correos="<email addresses>"

RUTA="<file path on the remote server>"


if ssh $host stat $RUTA \> /dev/null 2\>\&1

then
        ssh $user@$host "rm -rf $RUTA"
        echo "The file has been deleted in $RUTA" > resultado.txt
else
        echo "The file $RUTA does not exist" > resultado.txt
fi
