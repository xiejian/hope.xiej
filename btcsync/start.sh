if [ -f "p" ]
  then
    echo Process already running
    exit
fi
read -p "Input Pass:" pass
if [ -z "$pass" ]
  then
    echo "Nothing happened."
    exit
fi
echo "$pass" > p
date > nohup.out
nohup python btcsync.py &
exit
