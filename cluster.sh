
for i in "$@"
	docker run \
	   -d \
	   --cpu-period=1000000 --cpu-quota=1000 \
	   -e constraint:server==manager \
	   -p $i:6379 \
	   --restart=always \
	   --name "redis$i" \
		redis:3.2.9
done