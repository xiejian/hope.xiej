read -p "Input Pass:" pass
if [ -z "$pass" ]
  then
    echo "Nothing happened."
    exit
fi
echo "$pass" > p
nohup python btcsync.py &
exit
