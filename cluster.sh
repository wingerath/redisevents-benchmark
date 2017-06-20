for i in "$@"
do
docker stop redis$i &
done
sleep 10

for i in "$@"
do
docker rm redis$i &
done
sleep 10

for i in "$@"
do
docker run \
   -d \
   --cpu-period=1000000 --cpu-quota=1000 \
   -e constraint:server==manager \
   -v $(readlink -m redis$i.conf):/usr/local/etc/redis/redis.conf \
   -p $i:$i \
   --restart=always \
   --name redis$i \
    redis:3.2.9 redis-server /usr/local/etc/redis/redis.conf
done

sleep 5

docker ps -a
