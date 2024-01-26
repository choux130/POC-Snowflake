/*****************************/
/* Connect AWS and Snowflake */
/*****************************/
-- https://docs.snowflake.com/en/user-guide/data-load-s3-allow
-- allowing the Amazon Virtual Private Cloud (Amazon VPC) IDs for your Snowflake account
-- USE ROLE ACCOUNTADMIN;
SELECT SYSTEM$GET_SNOWFLAKE_PLATFORM_INFO();

-- https://docs.snowflake.com/en/user-guide/data-load-s3-config-storage-integration
-- Configuring Secure Access
-- Option 1: Configuring a Snowflake Storage Integration to Access Amazon S3
-- Only the ACCOUNTADMIN role has the privilege to create integration by default
CREATE STORAGE INTEGRATION my_integration_aws_s3
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::843562674612:role/my_snowflake_role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://us-east-1-snowflake-stage/');
DESC INTEGRATION my_integration_aws_s3;

GRANT CREATE STAGE ON SCHEMA public TO ROLE SYSADMIN;
GRANT USAGE ON INTEGRATION my_integration_aws_s3 TO ROLE SYSADMIN;

CREATE STAGE my_database.public.my_s3_stage
  STORAGE_INTEGRATION = my_integration_aws_s3
  URL = 's3://us-east-1-snowflake-stage/';
DESC STAGE my_database.public.my_s3_stage;

LIST @my_database.public.my_s3_stage;


