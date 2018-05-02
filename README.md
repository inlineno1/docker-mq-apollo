# docker-mq-apollo


sudo docker build -t apollomq:1.7.1 .


sudo docker run --name apollomq -p=61613:61613 -p=61623:61623 -p=61680:61680 -p=61614:61614 -p=61624:61624 -p=61681:61681 -d -t apollomq:1.7.1

sudo docker exec -it apollomq /bin/bash
