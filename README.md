# nockchain-miner

## How to override the public key and run Docker image directly

1. Clone the repository by running `git clone https://github.com/wowdogemonster/nockchain-miner.git` to your local machine and enter the **nockchain-miner** folder.
1. Run `./init.sh` to install Docker and configure the system.
   1. For RAM < 128GB device, `sudo sysctl -w vm.overcommit_memory=1` should be executed every time after the system is rebooted.
1. Modify the public key in the **.env** and **Makefile** files located in the **nockchain** subfolder. (these will later be used by docker compose to override the corresponding files in the container)
1. Edit **docker-compose.yaml** to specify the number of instances to start, then run `docker compose up` -d to launch.

**!! Most importantly !!**, use `docker compose logs` to check if the public key in the startup parameters was successfully overridden. 

You can use `docker compose stats` to verify if each instance is running normally. After a while, memory usage should be around 17GB, CPU usage should hit 200% during block synchronization, and drop to 100% when mining starts, with a “mining-on” prompt appearing in the logs.

![image](https://github.com/user-attachments/assets/a70935da-4a94-4dd7-ba8e-4298817225b2)

## Build your own Docker image

1. Clone this repository.
1. Replace all PUBKEY with your own in the **Dockerfile**, **.env**, **Makefile** and other files.
1. Create a tag and publish a release, then the Github Action will build a Docker Image for you. (Takes approximately 1 hour 20 mins)

![image](https://github.com/user-attachments/assets/6bf5bc1d-d151-4f53-87c6-56a300eb9b1c)

## Disclaimer

The author is not responsible for any damages or losses resulting from the use or misuse of the code provided.
