for i in "$@"
do
docker stop redis$i &
done
sleep 2

for i in "$@"
do
docker rm redis$i &
done
sleep 2

for i in "$@"
do
docker run \
   -d \
   --cpu-period=1000000 --cpu-quota=1000 \
   -e constraint:server==manager \
   -p 6379:$i \
   --restart=always \
   --name redis$i \
    redis:3.2.9
done
