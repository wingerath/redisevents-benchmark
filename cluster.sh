for i in "$@"
do
docker stop redis$i &
done
sleep 2

for i in "$@"
do
docker rm redis$i &
done
sleep 5

for i in "$@"
do
docker run \
   -d \
   --cpu-period=1000000 --cpu-quota=1000 \
   -e constraint:server==manager \
   -v $(readlink -m ./redis.conf):/usr/local/etc/redis/redis.conf \
   -p $i:$i \
   --restart=always \
   --name redis$i \
    redis:3.2.9
done

sleep 5

docker ps -a
