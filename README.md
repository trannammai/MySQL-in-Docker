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
docker compose up
