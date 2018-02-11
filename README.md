# IBM Cloud AppLaunch Swift Sample - HealthIsWealth

### Description
HealthIsWealth[HIW] is a fictitious health care provider who is looking to enhance its digital health engagement. We will see how App Launch can help HIW with its feature control and inapp message capabilities.

### Prerequisites

- [GIT](https://git-scm.com/)
- [Xcode](https://developer.apple.com/xcode/)
- [Cocoapods](https://cocoapods.org/#get_started)
- [IBM Cloud Developer Tools](https://github.com/IBM-Cloud/ibm-cloud-developer-tools) 

### IBM Cloud Services

This samples uses the following services:

- [App ID](https://console.bluemix.net/catalog/services/AppID)
- [AppLaunch](https://console.bluemix.net/catalog/services/AppLaunch)
- [Cloudant NoSQL DB](https://console.bluemix.net/catalog/services/cloudantNoSQLDB)

### Supported Levels

- iOS 10 +
- Swift 4

### AppLaunch Concepts

#### Gradual Feature Roll Out 

Many of HIW customers never got an eye test done and since eye test is not a part of annual checkup list offered by HIW, many customers landed up consulting ophthalmologists only  when eye condition deteriorates sometimes resulting vision loss. HIW wanted to introduce a innovative feature where the customer can take a high resolution picture of the retina and send it to ophthalmologist who could review and suggest consultation only if required. HIW however is not sure of this experiment and wants to roll out only to 10% of its userbase and see if this concept works before increasing the rollout.  The metrics was number of user s opting for this and feedback from ophthalmologists. Although metrics indicated large users opting for this,  it found various issues with the quality of images as indicated by ophthalmologists. Hence it decided to rollback this feature at this time and later roll out by providing prescriptive guidance on taking pictures.

####  Audience based feature targeting 

One of HIW main focus was senior citizens. It wanted to provide VideoVisit feature for senior citizens only. A senior citizen can schedule a video visit with his physician. He will get a push notification message on appointment confirmation. HIW also wants to launch a simplified app UI for its senior citizens, so that they can easily browse the app.

####  In App Messaging 

HIW wants to launch monthly personalized messages to its users. Users will be classified as senior citizens, heart patients, expectant mothers, Obese patients etc . HIW wants to send in app message when the user logs in for the first time.

#### A/B testing 

HIW wants to customize its prescription refill page to include home delivery of refills instead of pharmacy pick up at additional costs. It wants to test 2 variants of the UI before making a final rollout decision

### Installation 

#### Get the application code

The repository contains both the mobile application and the Cloud Functions actions code.

- Checkout the code from the GitHub repository

 	`https://github.com/ibm-cloud-applaunch/sample-swift-healthwealth.git`

- Review the code structure

	|      Name     |                         Description                         |
	|:-------------:|:-----------------------------------------------------------:|
	| cloudant-docs | Contains database design documents                          |
	| HealthWealth  | Code for the mobile application                             |
	| deploy.sh     | Helper script to install, uninstall, update the cloudant DB |

#### Provision services from the IBM Cloud catalog

- Go to the [IBM Cloud catalog](https://console.bluemix.net/catalog/).
- Create an [App ID](https://console.bluemix.net/catalog/services/AppID) service with the **Graduated tier** plan. Set the name to **healthiswealth-appid**.
- Create an [AppLaunch](https://console.bluemix.net/catalog/services/AppLaunch) service with the **Beta** plan. Set the name to **healthiswealth-applaunch**.
- Create a [Cloudant NoSQL DB](https://console.bluemix.net/catalog/services/cloudantNoSQLDB) service with the **Lite** plan. Set the name to **healthiswealth-db**.

#### Provision services from the command line

With the command line, run the following commands to provision the services and retrieve their credentials:

- Create [App ID](https://console.bluemix.net/catalog/services/AppID) Service and generate credentials.
	- `bx cf create-service AppID "Graduated tier" healthiswealth-appid `
	- `bx cf create-service-key healthiswealth-appid for-cli`
	- `bx cf service-key healthiswealth-appid for-cli`

- Create [AppLaunch](https://console.bluemix.net/catalog/services/AppLaunch) Service and generate credentials.
	-  `bx cf create-service AppLaunch "Beta" healthiswealth-applaunch `
	-  `bx cf create-service-key healthiswealth-applaunch for-cli`
	-  `bx cf service-key healthiswealth-applaunch for-cli`

- Create [Cloudant NoSQL DB](https://console.bluemix.net/catalog/services/cloudantNoSQLDB) Service and generate credentials.
	- `bx cf create-service cloudantNoSQLDB Lite healthiswealth-db`
	- `bx cf create-service-key healthiswealth-db for-cli`
	- `bx cf service-key healthiswealth-db for-cli`

#### Deploy cloundant database design documents

- Get the credentials for Cloudant service from the IBM Cloud dashboard (or the output of the bx commands we ran before) and replace placeholders in local.env with corresponding values. These properties will be used to create database and deploy documents in Cloundant NoSQL DB.

- Deploy the DB Documents to IBM Cloud Service. `deploy.sh` loads the credentials from local.env to create the Cloudant database and deploy design documents which is later used in the application. Run the following  command from your terminal:

	 `./deploy.sh --install`

	**Note** : You can also run the following commands:
	
	- `./deploy.sh --update` to update the DB 
	- `./deploy.sh --uninstall` to delete the DB.
  
#### Configure and run a native mobile application



 
### Learn More

* Visit the **[IBM App Launch Docs](https://console-regional.ng.bluemix.net/docs/services/app-launch/index.html#gettingstartedtemplate)**. 

## License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissio ns and
limitations under the License.


Apache 2.0 © [IBM Mobile](mailto:ibmmobile@ibm.com)
