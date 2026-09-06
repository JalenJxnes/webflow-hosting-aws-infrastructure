# webflow-hosting-aws-infrastructure
This repository is a project used to create a reusable AWS infrastructure for hosting websites built in WebFlow.

The Terraform docs are sorted into 3 stages: Development, Staging, Deployment. This will ensure new features, improvements, and performance tweaks are gradually introduced into the environment over time.

Phase One of this project includes creating the basic infrastructure and understanding the requirements.

Phase Two of this project includes staging the infrastructure by performing performance/stress testing, making any necessary tweaks, and ensuring the components are performing to requirements.

Phase Three of this project includes deploying the infrastructure to Production. From here, everything should be performing at spec and other groups or individuals should be able to deploy this architecture immediately to host their WebFlow sites directly on AWS, giving them more flexibility and custom hosting. 