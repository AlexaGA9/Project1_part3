# S3 Bucket Setup

## S3 Bucket Information

- S3 bucket name: [project1-part3-2026]
- AWS Region: [us-west-2]
- Deployed website URL: [http://project1-part3-2026.s3-website-us-west-2.amazonaws.com/]
- GitHub repository: [https://github.com/AlexaGA9/Project1_part3.git]

## 1. Creating the S3 Bucket

Created an S3 bucket named `project1-part3-2026` in the `us-west-2` region to host the website.

[Screenshot of the S3 bucket name and region]
<img width="716" height="85" alt="Screenshot 2026-10-05 at 7 46 32 PM" src="https://github.com/user-attachments/assets/c19b8dcd-15fc-4a7c-b240-2cabbc7a6ade" />


## 2. Website Files Uploaded

The following website files were uploaded to the S3 bucket:

- HTML files
- CSS files
- JavaScript files
- React files
- Images
- Supporting files

[Screenshot showing the uploaded files inside the bucket]
<img width="753" height="766" alt="Screenshot 2026-10-05 at 8 05 06 PM" src="https://github.com/user-attachments/assets/dfc0b7c4-6279-497e-93ff-a7961f52724b" />


## 3. Static Website Hosting

Static website hosting was enabled for the bucket.

[Screenshot of the Static Website Hosting settings]
<img width="884" height="396" alt="Screenshot 2026-10-05 at 8 08 16 PM" src="https://github.com/user-attachments/assets/10e1f1f0-9ad0-4ee9-9da3-56713a46e400" />


## 4. Deployed Website

The website is available at:

[http://project1-part3-2026.s3-website-us-west-2.amazonaws.com]

[Screenshot of the deployed website with the URL visible]
<img width="1208" height="1081" alt="Screenshot 2026-10-05 at 8 11 00 PM" src="https://github.com/user-attachments/assets/c98c5c90-8cdb-45a4-8309-9b7929f4dbc6" />

## 5. Problems and Solutions

Although no major problems were encountered during the S3 deployment, we did stumble upon some small hiccups.

### Problem 1: AWS CLI Not on PATH

- Problem: AWS CLI installed successfully, but the shell could not find the aws command.
- Solution: Updated the deployment script to use ~/.local/bin/aws when AWS CLI isn’t on PATH. The site then built and uploaded successfully.


### Problem 2: AWS Sign-In Profile Conflict

- Problem: The default AWS profile already contained access key credentials, so aws login could not use that profile. A separate profile also needed a region and browser authorization.
- Solution: Kept the existing profile unchanged and used its authenticated AWS session after confirming the account. Deployed the site to the S3 bucket in us-west-2.

## 6. Page Testing/Verification

The deployed website was tested to confirm that the main pages were working.

| Page | Result |
|---|---|
| Home page | [Working] |
| About page | [Working] |
| Contact page | [Working] |
| App page | [Working] |
| Login page | [Working] |

[Screenshots of the pages with the deployed URL visible]

##HOME PAGE
<img width="1110" height="872" alt="HOME" src="https://github.com/user-attachments/assets/d56578a8-52d8-4e6b-a7a7-c5cd43e3fb44" />

##ABOUT PAGE
<img width="1114" height="873" alt="ABOUT" src="https://github.com/user-attachments/assets/d9f27cba-ce40-4541-aa8c-4a3f463cb4d3" />

##CONTACT PAGE
<img width="1113" height="1075" alt="CONTACT" src="https://github.com/user-attachments/assets/e83f0ddc-4d53-4b76-8482-fe134df30a4b" />

##APP PAGE
<img width="1111" height="1074" alt="APP" src="https://github.com/user-attachments/assets/407440fd-b06d-403e-9197-2d95e9ac2ae6" />

##LOGIN PAGE
<img width="1108" height="792" alt="LOGIN" src="https://github.com/user-attachments/assets/bcf68fe8-0075-41aa-84bb-353bdfd5518d" />


## 7. Cost Discussion

This project uses a small amount of S3 storage so the expected cost should be low, but AWS can charge for storage, requests, and data transfer. When you create a new AWS Free Tier account, you get $100 in credits immediately. As you explore key services, you can earn up to $100 more. The cost is little to none since a new account was created to implement it.

I checked the AWS S3 pricing information here: https://aws.amazon.com/s3/pricing/
