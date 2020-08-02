# Introduction

**CloudRestAPI has been developed to find certain words from the input string and replace them with the new ones.**

Example input: 	“We really like the new security features of Google Cloud”.


Expected output : "We really like the new security features of Google© Cloud" 

# Software dependencies

## Development
1.	Python 3.7
2.	Django Rest framework
3.  VSCode
4.  POSTMAN

## Deployment
1.	Microsoft Azure Webapp
2. Azure app service plan (Linux)

## Source code management (To checkout the code, please use anyone of the below)
1. GitHub [GitHub](https://github.com/tyagihimanshu1/cloudrestapp.git)
2. Azure DevOps [Azure DevOps -CodeHub](https://TH01codehub@dev.azure.com/TH01codehub/CodeHub/_git/cloudrestapp_v1)


## CICD Pipelines
1.	Azure DevOps [Azure DevOps -CodeHub](https://TH01codehub@dev.azure.com/TH01codehub/CodeHub/_git/cloudrestapp_v1)

# Test the API
## Authentication details:
As basic security is enabled to secure the REST endpoints, you'll be promted for username and password. Kindly use below details:

    Username : dev_user
    Password : Dev@2020

    

## Test API endpoints using POSTMAN
    URL    : https://cloudrestapp-d-01.azurewebsites.net/api/v1/replaceWords/
    
    Method : POST
    Body   : {
	            "inputStr":"We really like the new security features of Google Cloud"
             }
    Response:
             {
                "outputStr": "We really like the new security features of Google© Cloud"
             }