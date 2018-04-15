# uTensor + Mbed + Cloud9 Setup Script

## Introduction

  This script will install uTensor-CLI and Mbed-CLI on Cloud9 IDE. Installation takes only one line in the cloud:

  `bash <(curl -s https://raw.githubusercontent.com/neil-tan/cloud9-installer/master/install.sh)`
  
  It jump-starts the development process by automating the environment setup in the cloud. It contains the tools needed to create device binaries and data files from Tensorflow models.


 
## Steps

### Register a Cloud9 account
- Go to [Cloud9](https://aws.amazon.com/cloud9/) and register  an account

![cloud9 register](docs/img/register.jpg)

### Create an Environment
- Create an environment from the Cloud9 Dashboard

![environment naming](docs/img/createEnv1.jpg)

- Give the instance a name

![environment naming](docs/img/nameEnv.jpg)

- Create an instance on EC2 and choose the Free-tier

![environment config](docs/img/envConfig.jpg)

- Click on Next

- Click on Create

![environment create](docs/img/createEnv2.jpg)

### Run the Command
- Run the command

![console](docs/img/console1.jpg)

`bash <(curl -s https://raw.githubusercontent.com/neil-tan/cloud9-installer/master/install.sh)`

Let the script run

![installer output](docs/img/console2.jpg)
  
## What's Next?
Try the quick-start guide
