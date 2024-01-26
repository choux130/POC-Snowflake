/************************************/
/* Add user key pair authentication */
/************************************/
DESCRIBE USER yintingchou;
ALTER USER yintingchou SET RSA_PUBLIC_KEY='MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqgoxCRC3LkX7IJ5kVA1x
i0Vurq2D0JZfO1+N7M1URL1kCFEJTXgrgDwOH+OQZVGRuB6rSTJrEHY8Dm5urCMH
ZXSKguoFzTycoKbElzMK8UQatSb19lFW4aGc0nUXqwlSem9LDesz8paH1ByjQL/7
y6UkegE2W1PmfdXwQT4AWUoLXbn3ojD9WZWMSmvBN0/adPn9GfWqbgwkS8Ft5hRM
3kg3RD4YK5EBuRxpeueofGr4Fg28eHvodITBQ52EGb34EGwT1824Q9x+Mg5pT2ru
RRCZFLVKbuJhagT7zDMfQXqW7+4rpUkYPoLrMSBPODthxRqJt3EoD1CdLs6XlTsp
mwIDAQAB';


/*************************/
/* Create table and pipe */
/*************************/
-- https://docs.snowflake.com/en/user-guide/data-load-snowpipe-rest-gs
CREATE TABLE my_database.snowpipe.mytable (a NUMBER, b NUMBER, c NUMBER);
describe table my_database.snowpipe.mytable; 

create OR REPLACE pipe my_database.snowpipe.mypipe 
as 
copy into my_database.snowpipe.mytable 
from @my_database.public.my_s3_stage/snowpipe/
FILE_FORMAT = (TYPE = 'CSV' skip_header = 1);
;
describe pipe my_database.snowpipe.mypipe;


/*********************************************************/
/* grant permission to role on using the pipe and table  */
/*********************************************************/

-- Create a role for the Snowpipe privileges.
use role securityadmin;
create or replace role snowpipe1;

-- Grant the USAGE privilege on the database and schema that contain the pipe object.
grant usage on database my_database to role snowpipe1;
grant usage on schema my_database.snowpipe to role snowpipe1;

-- Grant the INSERT and SELECT privileges on the target table.
grant insert, select on my_database.snowpipe.mytable to role snowpipe1;

-- Grant the USAGE privilege on the external stage.
grant usage on stage my_database.public.my_s3_stage to role snowpipe1;

-- Grant the OPERATE and MONITOR privileges on the pipe object.
grant operate, monitor on pipe my_database.snowpipe.mypipe to role snowpipe1;

-- Grant the role to a user
grant role snowpipe1 to user yintingchou;

-- Set the role as the default role for the user
alter user yintingchou set default_role = snowpipe1;


/*********************/
/* Check pipe status */
/*********************/
select SYSTEM$PIPE_STATUS( 'my_database.snowpipe.mypipe' );
select * from my_database.snowpipe.mytable;
-- alter pipe my_database.snowpipe.mypipe SET PIPE_EXECUTION_PAUSED = true;
