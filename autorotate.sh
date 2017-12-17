#!/bin/bash
screen -X -S karta quit
echo "Exited screen karta"
sleep 5

sed -n 1,4p /home/tim/Vellingekartan/Scripts/auto/hl.txt >/home/tim/Vellingekartan/1/RocketMap/lv30.csv
echo "lv30.csv updated"
sed '1,4{H;d}; ${p;x;s/^\n//}' /home/tim/Vellingekartan/Scripts/auto/hl.txt >/home/tim/Vellingekartan/Scripts/auto/hl_temp.txt; mv /home/tim/Vellingekartan/Scripts/auto/hl_temp.txt /home/tim/Vellingekartan/Scripts/auto/hl.txt
echo "File hl.txt rotated"

sed -n 1,25p /home/tim/Vellingekartan/Scripts/auto/ll.txt >/home/tim/Vellingekartan/1/RocketMap/accounts.csv
echo "accounts.csv updated"
sed '1,25{H;d}; ${p;x;s/^\n//}' /home/tim/Vellingekartan/Scripts/auto/ll.txt >/home/tim/Vellingekartan/Scripts/auto/ll_temp.txt; mv /home/tim/Vellingekartan/Scripts/auto/ll_temp.txt /home/tim/Vellingekartan/Scripts/auto/ll.txt
echo "File ll.txt rotated"

sqlite3 /home/tim/Vellingekartan/1/RocketMap/pogom.db "UPDATE spawnpoint SET missed_count = 0;"
echo "Spawnpoint missed_count reset. Starting server..."
sleep 5

screen -dmS karta
screen -S karta -X stuff 'cd /home/tim/Vellingekartan/1/RocketMap/\n'
screen -S karta -X stuff 'python ./runserver.py\n'
echo "Done"
