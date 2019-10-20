PROJECT_NAME="StudentApp"
PROJECT_ENV="DEV"
VPC_CIDR="10.0.0.0/21"
AZ=["us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]

## DB PARAMETERS
DB_SIZE=10
DB_ENGINE="mariadb"
DB_ENGINE_VERSION="10.3"
NEED_FINAL_SNAPSHOT=false 
DBNAME="studentapp" 
DBUSER="student" 
DBPASS="student1"
DB_INSTANCE_TYPE="db.t2.micro"
RDS_DB_NAME="studentapp-db"

## EC2 Paramaeters
INSTANCE_TYPE="t2.micro"
INSTANCE_COUNT=1
KEYPAIR_NAME="devops"
