# Before going further, please pull the repo from my github account to your Docker developing environment.

# Creating a MySQL database in docker container environement
1. Open the terminal Execute the docker-compose.yml file by running the following script. <br>

```
docker-compose up
```

2. Once the script is launched, open another terminal to check whether the container is up and running <br>
```
docker ps 
```
The container image for MySQL database and Adminer should be available. Besides, you can verify if the database is initialized following the rule in ./mysql/data.sql file by going to http://localhost:8080/. Fill in the root and password specified in the .env file.

# Now the container image is ready in our local machine. Let's pull up to Google Cloud Platform
# Upload container to Docker Hub and Container Registry
1. Tag the container: <br>
```
docker tag comdockerdevenvironmentscode_mysql trannammai/final_mysql_image
```
2. Login to Docker Hub, fill in username and password: <br>
docker login
```
3. Push the container image to Docker Hub: <br>
```
docker push trannammai/final_mysql_image
```
4. Log in to Google Cloud Platform (login details are provided in the repository). Make sure that the following APIs are enabled: <br>
- BigQuery API
- Container Registry API
- Cloud Composer API

5. Pull the docker image from Docker Hub to Google Cloud Platform, tag it together with the host name (gcr.io) and project id (parabolic-wall-323414) then store it in Container Registry <br>
```
docker pull trannammai/final_mysql_image <br>
docker tag trannammai/final_mysql_image gcr.io/parabolic-wall-323414/final_image <br>
docker push gcr.io/parabolic-wall-323414/final_image
```
6. Deploy the image to VM instance in Compute Engine <br>
gcloud compute instances create-with-container mysqlvm \
    --container-image gcr.io/parabolic-wall-323414/final_image
```
7. Connect to the SSH of the VM and access to the bash script of the mysql container. Note that "edd57116c83a" is the container ID which might be different from your case. <br>
```
docker ps
docker exec -it edd57116c83a bash
```
8. Once access to the root, connect to mysql database with username being root and password being password <br>
mysql -uroot -ppassword
```
9. List all databases. One can see that mydb database is initialized with 4 pre-defined tables <br>
```
show databases; 
use mydb;
show tables;
```
10. Run the script according to the following dependency to populate random data into tables. You can copy the script and execute directly in the SSH of the VM <br>
udf.sql
store_procedure.sql
populate_data.sql
modeling_data.sql

11. Run the script to create a table which contains 1000 students from 10 schools and registering 3 courses as required. You can copy the script and execute directly in the SSH of the VM <br>
to_bigquery.sql

12. Now the table is ready to replicate to BigQuery. Take a glance at the data <br>
```
SELECT * FROM bq_data LIMIT 20;
```
Message from candidate: I'm stuck at transfering data from MYSQL on Compute Engine to BigQuery. My plan is to write a scheduled job on Cloud Composer or Airflow but didn't manage to sort it out. I'm sorry for the unfinished work. -Nam Mai-
