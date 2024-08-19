#!/bin/bash

# Prompt the user to enter the target IP address or hostname
read -p "Enter the target IP address or hostname: " TARGET

# Set the port range to scan (e.g., 1-1024)
PORT_RANGE="1-1024"

# Directory to save output files
OUTPUT_DIR="./scan_results"
mkdir -p $OUTPUT_DIR

# Set the scanning tools to use (e.g., nmap, nikto, etc.)
TOOLS=("nmap" "nikto")

# Function to run nmap scan
nmap_scan() {
  echo "Running nmap scan..."
  nmap -sS -p $PORT_RANGE $TARGET -oN $OUTPUT_DIR/nmap_scan.txt
}

# Function to run nikto scan
nikto_scan() {
  echo "Running nikto scan..."
  nikto -h $TARGET -p $PORT_RANGE -o $OUTPUT_DIR/nikto_scan.txt
}

# Function to upload results to S3
upload_to_s3() {
  if [ -z "$BUCKET_NAME" ]; then
    echo "No bucket name provided. Skipping upload."
  else
    echo "Uploading results to S3..."
    aws s3 cp $OUTPUT_DIR s3://$BUCKET_NAME/scan_results/ --recursive
    echo "Results have been uploaded to S3."
  fi
}

# Prompt the user to optionally enter an S3 bucket name
read -p "Enter the S3 bucket name to upload the results (or press Enter to skip): " BUCKET_NAME

# Loop through each tool and run the corresponding scan function
for TOOL in "${TOOLS[@]}"; do
  case $TOOL in
    "nmap")
      nmap_scan &
      ;;
    "nikto")
      nikto_scan &
      ;;
    *)
      echo "Unknown tool: $TOOL"
      ;;
  esac
done

# Wait for all background processes to complete
wait

echo "Scans completed! Check $OUTPUT_DIR for results."

# Upload results to S3 if a bucket name was provided
upload_to_s3
