# Flink Streaming on K8s Kickstarter
Create local k8s cluster, install streaming infra on top of it and deploy streaming job.

## Tech Stack:
- k3d - local k8s cluster
- Kafka
- Schema Registry
- Flink K8s Operator
- Minio
- Clickhouse
- Akhq

## Requirements:
k3d + Terraform

## Quickstart

1. Go into the terraform directory:
`cd terraform`
2. Initialize Terraform:  
`terraform init`  
2. Apply Terraform:  
`terraform apply -auto-approve`
Applying for the first time takes some time due to the images being pulled. 
*In case of failure caused by a timeout re-run terraform apply*

## Access ui consoles
1. **akhq** is already exposed on:  
`localhost:3080`
2. **minio/s3**  
`kubectl port-forward --context k3d-flink-dev svc/minio 9001:9001`  
*user: admin password: adminadmin*

## Accessing Kafka
1. Forward Kafka PROXY listener
`kubectl port-forward --context k3d-flink-dev svc/kafka 9094:9094`
2. Now you can connect to Kafka with e.g.
`kafka-topics --bootstrap-server localhost:9094 --list`

## Suspend cluster
In order to suspend cluster run:  
`k3d cluster stop flink-dev`  
to resume cluster:  
`k3d cluster start flink-dev`  

## Destroy and start from scratch
1. Remove *terraform.tfstate* files:  
`rm terraform.tfstate*`
2. Destroy cluster:  
`k3d cluster delete flink-dev`  
3. Init & Apply Terraform
