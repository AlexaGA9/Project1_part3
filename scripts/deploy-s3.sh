#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: npm run deploy:s3 -- <globally-unique-bucket-name> [aws-region]" >&2
  exit 2
fi

bucket="$1"
region="${2:-${AWS_REGION:-${AWS_DEFAULT_REGION:-us-west-2}}}"

aws_bin="$(command -v aws || true)"
if [[ -z "$aws_bin" && -x "$HOME/.local/bin/aws" ]]; then
  aws_bin="$HOME/.local/bin/aws"
fi
if [[ -z "$aws_bin" ]]; then
  echo "AWS CLI v2 is required. Install it and configure credentials first." >&2
  exit 1
fi

echo "Building site..."
npm run build

echo "Creating bucket $bucket in $region (if it does not already exist)..."
if [[ "$region" == "us-east-1" ]]; then
  "$aws_bin" s3api create-bucket --bucket "$bucket" --region "$region" 2>/dev/null || \
    "$aws_bin" s3api head-bucket --bucket "$bucket" --region "$region"
else
  "$aws_bin" s3api create-bucket --bucket "$bucket" --region "$region" \
    --create-bucket-configuration "LocationConstraint=$region" 2>/dev/null || \
    "$aws_bin" s3api head-bucket --bucket "$bucket" --region "$region"
fi

# Direct S3 website endpoints require public object reads. Keep ACLs disabled;
# grant only s3:GetObject on this bucket's site files.
"$aws_bin" s3api put-public-access-block --bucket "$bucket" --region "$region" \
  --public-access-block-configuration \
  'BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false'
"$aws_bin" s3api put-bucket-website --bucket "$bucket" --region "$region" \
  --website-configuration '{"IndexDocument":{"Suffix":"index.html"}}'

policy_file="$(mktemp)"
trap 'rm -f "$policy_file"' EXIT
cat > "$policy_file" <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadWebsiteFiles",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::$bucket/*"
  }]
}
POLICY
"$aws_bin" s3api put-bucket-policy --bucket "$bucket" --region "$region" --policy "file://$policy_file"

echo "Uploading dist/ ..."
"$aws_bin" s3 sync dist/ "s3://$bucket" --region "$region" --delete

case "$region" in
  us-east-1) website_host="$bucket.s3-website-us-east-1.amazonaws.com" ;;
  *) website_host="$bucket.s3-website-$region.amazonaws.com" ;;
esac
echo "Deployment complete: http://$website_host/"
echo "Pages: /, /about.html, /contact.html, /app.html, /login.html"
