# MySQL to BigQuery Data Pipeline

This mini-project demonstrates how to set up a MySQL database in a Docker container and replicate its data to a BigQuery table on Google Cloud Platform (GCP).

---

## **Project Objectives**

- Set up a MySQL database using Docker.
- Populate and manage data in MySQL.
- Upload the Docker container image to GCP.
- Replicate the MySQL data to BigQuery.

---

## **Table of Contents**

1. [Setup MySQL Database in Docker](#step-1-setup-mysql-database-in-docker)
2. [Upload Docker Container to GCP](#step-2-upload-docker-container-to-gcp)
3. [Access and Populate MySQL Database](#step-3-access-and-populate-mysql-database)
4. [Replicate Data to BigQuery](#step-4-replicate-data-to-bigquery)

---

## **Step 1: Setup MySQL Database in Docker**

### **1.1 Run the Docker Compose File**
Execute the `docker-compose.yml` file to spin up the MySQL container:
```bash
docker-compose up
```

### **1.2 Verify the Container is Running**
Check if the MySQL and Adminer containers are running:

```bash
docker ps
```
Visit http://localhost:8080/ to verify the database initialization. Use the root username and password specified in the .env file. The database is initialized based on the ./mysql/data.sql script.


## **Step 2: Upload Docker Container to GCP**
### **2.1 Tag the Docker Container**
Tag the MySQL container with your Docker Hub repository:

bash
Copy code
docker tag comdockerdevenvironmentscode_mysql trannammai/final_mysql_image

### **2.2 Login to Docker Hub**
Authenticate with your Docker Hub credentials:

bash
Copy code
docker login

### **2.3 Push the Docker Image**
Push the container image to Docker Hub:

bash
Copy code
docker push trannammai/final_mysql_image

### **2.4 Enable GCP APIs**
Ensure the following APIs are enabled in your GCP project:

BigQuery API
Container Registry API
Cloud Composer API

### **2.5 Transfer Docker Image to GCP**
Pull the Docker image from Docker Hub, tag it for GCP, and push it to the Container Registry:

bash
Copy code
docker pull trannammai/final_mysql_image
docker tag trannammai/final_mysql_image gcr.io/parabolic-wall-323414/final_image
docker push gcr.io/parabolic-wall-323414/final_image

### **2.6 Deploy Container on Compute Engine**
Create a VM instance in Compute Engine and deploy the container:

bash
Copy code
gcloud compute instances create-with-container mysqlvm \
    --container-image gcr.io/parabolic-wall-323414/final_image

## **Step 3: Access and Populate MySQL Database**
### **3.1 Connect to the VM Instance**
Access the VM instance via SSH. Identify the container ID and connect to it:

bash
Copy code
docker ps
docker exec -it <container_id> bash

### **3.2 Log in to MySQL**
Inside the container, log in to the MySQL database:

bash
Copy code
mysql -uroot -ppassword

### **3.3 Verify Database Initialization**
List databases and tables to confirm initialization:

bash
show databases; 
use mydb;
show tables;

### **3.4 Populate Data**
Execute SQL scripts in the following order to populate data:

udf.sql
store_procedure.sql
populate_data.sql
modeling_data.sql

### **3.5 Generate Final Dataset**
Run the to_bigquery.sql script to generate a dataset of 1,000 students, 10 schools, and 3 course registrations per student:

sql
Copy code
source to_bigquery.sql;

### **3.6 Preview the Data**
Preview the dataset before replication:

sql
SELECT * FROM bq_data LIMIT 20;
Step 4: Replicate Data to BigQuery
Now that the data is ready, follow your organization's guidelines to replicate it to BigQuery. This may involve using tools like Cloud Composer or custom scripts.

# **Project Highlights**
- Technologies Used: Docker, MySQL, BigQuery, GCP.
- Key Features: Seamless containerization, robust data population scripts, and efficient cloud integration.
Feel free to submit pull requests or open issues to improve this project
