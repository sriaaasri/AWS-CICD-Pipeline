# AWS-CICD-Pipeline
A simple Devops CICD project.

**Author:** P. sri satya 

---

### **Table of Contents**
1. [Project Overview](#1-project-overview)
2. [Architecture Diagram](#2-architecture-diagram)
3. [Step 1: Spring boot application](#3-step-1-spring-boot-application)
4. [Step 2: AWS EC2 instance preparation](#4-step-2-aws-ec2-instance-preparation)
5. [Step 3: Install Dependencies on EC2](#5-step-3-install-dependencies-on-ec2)
6. [Step 4: AWS codebuild setup](#6-step-4-aws-codebuild-setup)
7. [Step 5: AWS codedeploy setup](#7-step-5-aws-codedeploy-setup)
8. [Step 6: AWS codepipeline setup](#8-step-6-aws-codepipeline-setup)
9. [Step 7: pushing changes and verification](#9-step-7-pushing-changes-and-verification)
10. [Conclusion](#10-conclusion)

---

### **1. Project Overview**
This project demonstrates how to build an end-to-end CI/CD pipeline using AWS services integrated with GitHub.
	It automates the process of building and deploying an application whenever code changes are pushed to the repository.
	The pipeline uses AWS CodePipeline for orchestration, CodeBuild for building the application, and CodeDeploy for deploying it to an EC2 instance.
	This setup eliminates manual deployment steps and ensures faster and more reliable releases.
	The project is designed as a beginner-friendly guide to understanding real-world DevOps workflows.

---

### **2. Architecture Diagram**

```
👨‍💻 Developer 
      │
      ▼
📦 GitHub Repository 
      │  (Push Code)
      ▼
🚀 AWS CodePipeline 
      │  (Orchestrates CI/CD)
      ▼
🔨 AWS CodeBuild ──▶ 📂 Amazon S3 ──▶ 🚚 AWS CodeDeploy ──▶ 🖥️ Amazon EC2 ──▶ 🌐 End Users
     (Build App)      (Store Artifact)    (Deploy App)        (Run App)         (Access App)
```
---

### **3. Step 1: Spring boot application**
In this step, we will create a simple Spring Boot application using Spring Initializr.

🔗 Generate project from: https://start.spring.io/

#### Project Configuration:
- Project: Maven
- Language: Java
- Spring Boot: 4.0.4
- Packaging: WAR
- Configuration: YAML
- Java Version: 17

#### Dependencies:
1) Spring Web

After generating the project, download and extract it to your local machine.

#### 🔧 Build the Application (WAR)
Navigate to the project directory and package the application:

```bash
mvn clean package
```
#### ▶️ Run the Application Locally

```bash
java -jar target/<your-app-name>.war
```
#### 🌐 Verify the Application
Open your browser and access:

```bash
http://localhost:8080
```
---

### **4. Step 2: AWS EC2 instance preparation**

1.  **Launch EC2 Instance:**
    * Navigate to the AWS EC2 console.
    * Launch a new instance using the **Amazon Linux** AMI.
    * Select the **t2.micro** instance type for free-tier eligibility.
    * Create and assign a new key pair for SSH access.

<img src="diagrams/ec2.png">

2.  **Configure Security Group:**
    * Create a security group with the following inbound rules:
        * **Type:** SSH, **Protocol:** TCP, **Port:** 22, **Source:** Anywhere (0.0.0.0/0)
        * **Type:** HTTP, **Protocol:** TCP, **Port:** 80, **Source:** Anywhere (0.0.0.0/0)
        * **Type:** HTTPS, **Protocol:** TCP, **Port:** 443, **Source:** Anywhere (0.0.0.0/0)

<img src="diagrams/securityGroups.png">

3.  **Connect to EC2 Instance:**
    * Use SSH to connect to the instance's public IP address.
    ```bash
    ssh -i /path/to/key.pem ec2-user@<ec2-public-ip>
    ```
---

### **5. Step 3: Install Dependencies on EC2**

In this step, we install the required dependencies on the EC2 instance to run the Spring Boot application and enable deployments using AWS CodeDeploy.

#### ☕ JDK 17

- Required to run the Spring Boot application
- Install Java 17 (Amazon Corretto)

```bash
sudo dnf install java-17-amazon-corretto -y
java -version
```
configure JAVA 

```bash
echo "export JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
source ~/.bashrc
```

#### 🌐 Nginx

2)  **Installing and configuring**
    * Used as a reverse proxy to handle incoming traffic
    * Routes requests from port 80 to the application server (Tomcat).

```bash
sudo dnf install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
```
3) **Tomcat 11**
    * Used to deploy and run the Spring Boot WAR file.

```bash
cd /home/ec2-user
wget https://downloads.apache.org/tomcat/tomcat-11/latest/bin/apache-tomcat-11.tar.gz
tar -xvzf apache-tomcat-11.tar.gz
mv apache-tomcat-11* tomcat
```

4) **CodeDeploy Agent**
    * Required for AWS CodeDeploy to access and deploy to the EC2 instance.

```bash
sudo dnf install ruby -y
sudo dnf install wget -y

cd /home/ec2-user
wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
```
#### Start and enable CodeDeploy Agent

```bash
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent
sudo systemctl status codedeploy-agent
```

---

### **6. Step 4: AWS codebuild setup**

--steps to create build project
Project name: "name"
Project type: Default project
Source provider: GitHub
**Connect your github account**
Repository: Repository in my GitHub account

**Environment**
* Provisioning model : On-demand
* Environment image: Managed image
* Compute: EC2
* Running mode: Instance
* Operating system: Amazon Linux
* Runtime: Base
* Service role: New service role
* Role name: "Give a new service role name"

**Additional configuration**
* compute : 2vCPUs, 4 GIB (just to avoid extra charges)

**BuildSpec**
* Build specifications: Use a buildspec file
* name: buildspec.yml  (make sure create a buildspec.yml file in root directory of you project)

**Artifacts**
* Type: Amazon S3
* Bucketname: "give a existing bucket name created only to save final artifacts"
* name: "name you prefered of final artifact"
* Artifacts packaging: Zip

**Logs**
* Group name: /aws/codebuild/"project-name"

<img src="diagrams/codebuild.png">

---

### **7. Step 5: AWS codedeploy setup**

---

### **8. Step 6: AWS codepipeline setup**















---

### **9. Step 7: pushing changes and verification**

---

### **10. Conclusion**

---