COMPOSE_FILE = ./srcs/docker-compose.yml

all: up

preup:
	mkdir -p /home/$(USER)/data/mysql
	mkdir -p /home/$(USER)/data/wordpress

up: preup
	sudo docker compose -f $(COMPOSE_FILE) up -d --build

down:
	sudo docker compose -f $(COMPOSE_FILE) down

clean: down
	#sudo docker stop `sudo docker ps -qa`
	#sudo docker rm `sudo docker ps -qa`
	sudo docker rmi -f `sudo docker images -qa`
	sudo docker volume rm `sudo docker volume ls -q`
	#sudo docker network rm `sudo docker network ls -q`

fclean: clean
	sudo rm -rf /home/$(USER)/data/mysql
	sudo rm -rf /home/$(USER)/data/wordpress

re: down fclean up

.PHONY: all preup up down clean fclean re