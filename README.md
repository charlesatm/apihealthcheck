

<h2 align="center">Health Endpoint Deployment</h2>

  <p align="center">
    This Project deploys a simple health endpoint platform on the AWS using Terraform as the Infrastructure as code.
    <br />


## About The Project

The Health check API has been deployed on top of AWS. We are using API Gateway  and the CI-CD is made possible with the help of AWS Native services such as Codebuild and Codepipeline.


### Built With 

* ![Terraform] Terraform
* ![AWS] AWS




### Prerequisites


* AWS CLI
  ```sh
  https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
  ```
* Terraform CLI
  ```sh
  https://developer.hashicorp.com/terraform/downloads
  ```
* Github Account
  ```sh
  https://github.com/
  ```

## Folder Structure Conventions
    .
    ├── function                    # Contains the Nodejs Source code
    ├── modules                     # Terraform custom modules
    ├── pipeline                    # Buildspec file used by AWS Codebuild
    └── README.md
    
## Usage

### How to build and deploy infra through Terraform

1. Navigate to the below Github Repository and fork it to your own repository, this is because AWS Codepipeline needs oauth access and only the owner of the particular repo can provide it.
 ```sh
  https://github.com/charlesatm/apihealthcheck
  ```

2.  Clone the forked repo to your local and Initialise the Terraform module
 ```sh
  terraform init
  ```

3. Export the AWS keys as an env variable
```sh
export AWS_ACCESS_KEY_ID="xxxxxxxx"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxx"
  ```

4. Change the variables.tf file accordingly. This also contains local values specific to your repo so please replace them with your github username and repo names.

5. Then, We can Plan and Apply the changes to Terraform
```sh
terraform plan
terraform apply
  ```

6. Once the apply is completed succesfully, We should be able to access the health check endpoint with the below command
```sh
curl "$(terraform output -raw base_url)/status"
  ```

7. The state should be managed externally since both infrastructure and application are in the same repository. Uncomment the backend block from the terraform.tf file to use s3 as the backend. Then run the below commands and acknowledge state transfer to s3.
```sh
terraform init
terraform apply
  ```
8. Github account should be connected with AWS to enable the Pipeline process, this a manual one time change and unfortunately Terraform cannot do it. To connect your repo with AWS codepipeline go to AWS codepipeline https://console.aws.amazon.com/codesuite/home and click on settings and then connections. There will be a pending connection, update the pending connection by connecting your github acccount with AWS. Unless and until this is completed, the pipeline won't be triggered by the version control.

### Deployed Services [via Terraform]

API Gateway ---> `Refer apig module and apigateway.tf file in this Repo, The module will deploy api gateway and its related dependencies. `

S3 ---> `Refer s3 module and s3.tf, this enables artifact storage required for CodePipeline, terraform state and lambda source code.`

CodeBuild ---> `Refer code-build.tf, This will create a codebuild project required for planning the Infrastructure through Terraform`

CodeDeploy ---> `Refer code-deploy.tf, This will deploy the Infrastructure through Terraform. `

CodePipeline ---> `Refer codepipeline.tf, This will create a codepipeline , Github connection and the permissions required for pipeline through IAM policy and role.`

Lambda ---> `Refer lambda.tf and function.zip, This will create a Lambda function and the roles required for service execution, also, the function folder contains the nodejs code that logs the response data using console.log .`

Cloudwatch LogGroup ---> `Refer lambda.tf and apigateway.tf, The API gateway logs and Lambda execution logs are sent to the log groups for further filtering and monitoring.`

---

### How to scale the service 

- AWS Lambda is designed to automatically scale to accommodate varying workloads without manual intervention.

---

### How to access logs
- Below logs can be accessed easily from the AWS Console

1. API Gateway Logs
2. Lambda Logs
3. Pipeline Logs

- Go to AWS cloudwatch and then log-groups, You should be able to find the log-groups according to the respective service.

[Terraform]: https://icons-for-free.com/download-icon-Terraform-1324888767860173802_16.png
[AWS]: https://icons-for-free.com/download-icon-amazon+aws-1331550885897517282_16.png
