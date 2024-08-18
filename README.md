# Automated Vulnerability Scanner Bot

A Bash script for performing automated vulnerability scans using Nmap and Nikto. The script allows users to specify a target IP address or hostname, choose a port range for scanning, and optionally upload scan results to an AWS S3 bucket.

## Features

- **Customizable Target:** Enter the target IP address or hostname for scanning.
- **Port Range Scanning:** Configure the port range for Nmap scans.
- **Web Vulnerability Checks:** Use Nikto for web application vulnerability scanning.
- **Local and Cloud Storage:** Save scan results locally or upload them to an AWS S3 bucket.

## Prerequisites

- **Nmap**: Ensure Nmap is installed and accessible from your environment.
- **Nikto**: Ensure Nikto is installed and accessible from your environment.
- **Perl**: Nikto requires Perl. Ensure Perl is installed and properly configured.
- **AWS CLI**: For uploading results to AWS S3, install and configure the AWS CLI.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/mxfxhck/AutoVulnScan.git
   cd AutoVulnScan `

2. Make the script executable:
   ```bash
   chmod +x vuln_scan.sh `

3. Run the script:
   ```bash
   ./vuln_scan.sh`

## Usage
 **Follow the prompts to enter the target IP address or hostname and specify the S3 bucket name if desired.**

 ## Configuration
* You can modify the vuln_scan.sh script to adjust the default settings, such as the port range or scanning tools.

## Policy JSON for AWS S3 Access

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::your-bucket-name",
        "arn:aws:s3:::your-bucket-name/*"
      ]
    }
  ]
}

**Replace your-bucket-name with the actual name of your S3 bucket.**



   
