### Initial game plan
![image](./imgs/game_plan.png)

* Generate temporary token
```sh
/Applications/SnowSQL.app/Contents/MacOS/snowsql --generate-jwt -a YOKIWZW -u yintingchou --private-key-path ./rsa_key.p8
```

* POST request to ingest data <br>
https://YOKIWZW-my_account.snowflakecomputing.com/v1/data/pipes/MY_DATABASE.SNOWPIPE.MYPIPE/insertFiles?requestId=adfjijo34dsf
![image](./imgs/post_request.png)

* GET request to check status <br>
https://YOKIWZW-my_account.snowflakecomputing.com/v1/data/pipes/MY_DATABASE.SNOWPIPE.MYPIPE/insertReport?requestId=adfjijo34dsf
![image](./imgs/get_request.png)
