**Redash Installation Guide with Oracle Support on Centos**


**1. Clone the current repository**

$ git clone https://github.com/vmnet02/redash_oracle
Navigate to the redash_oracle directory


$ cd /redash_oracle

**2. Run setup if you don't have Redash installed**

#/redash_oracle/
$ chmod a+x setup.sh
$ ./setup.sh

**3. Create a custom Docker image for a new installation**

#/redash_oracle/
$ docker build --pull -t redash/redash: .

For updates, you can force an image refresh

#/redash_oracle/
$ docker build --pull -t redash/redash:latest -t redash/redash:<actual redash version> .

To support Cyrillic characters in queries, you may need to change or add the shell encoding. 
Check your current encoding with the command:

#/redash_oracle/
$ echo $LANG
To change the encoding:


#/redash_oracle/
$ export LANG=en_US.UTF-8
If you had Redash installed previously, make backups of the /opt/redash and var/lib/postgresql directories. Stop all containers with:



#/redash_oracle/
$ docker stop $(docker ps -a -q)
Or only Redash containers with:


$ docker-compose stop server scheduler scheduled_worker adhoc_worker

**4. Deploy the container**

Copy the docker-compose.yml file from /redash_oracle to /opt/redash before deployment, 
or update the file at https://github.com/getredash/setup.

For a new Redash installation, execute the following commands:

$ cd /opt/redash
$ docker-compose run --rm server create_db
$ docker-compose up -d
For Redash updates, execute the following commands:


$ cd /opt/redash
$ docker-compose run --rm server manage db upgrade
$ docker-compose up -d
This guide will help you set up Redash with Oracle support on your system.
