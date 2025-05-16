### Install using the apt repository  
1. Set up Docker's apt repository.
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
2. Install the Docker packages.
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
3. Verify that the installation is successful by running the
```bash
sudo docker run hello-world
```
### Continue to Linux postinstall  
1. Create the docker group.  
```bash
sudo groupadd docker
```
2. Add your user to the docker group.
```bash
sudo usermod -aG docker $USER
```
3. Log out and log back in so that your group membership is re-evaluated.  
3.1 You can also run the following command to activate the changes to groups:  
```bash
newgrp docker
```
4. Verify that you can run docker commands without sudo.
```bash
docker run hello-world
```
### Configure Docker to start on boot with systemd
```bash
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```
To stop this behavior, use disable instead.  
```bash
sudo systemctl disable docker.service
sudo systemctl disable containerd.service
```
