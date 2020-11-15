# Execute Docker Commands Without Sudo

```bash
# create docker group if not exists
sudo groupadd docker

# adding current user to docker group
sudo usermod -aG docker $USER

# restart docker server
sudo systemctl restart docker

# Log out and log back in so that your group membership is re-evaluated. 
# or you can run following commands to refresh docker group members
newgrp  docker

# please try some docker commands again
docker ps
# Outputs:
# CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
```
