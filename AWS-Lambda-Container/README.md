# References
* https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-alt-test

# In local
* Developing inside a container
    1. Debugging 
    2. Unit testing
    3. Interactive window
* Build the image with name as 'aws-lambda-container_myfunction' (`<folder-name>_<service-name>`)
    ```sh
    docker-compose build
    ```
* Test the function 
    1. Download the runtime interface emulator 
        ```sh
        mkdir -p ~/.aws-lambda-rie && \
            curl -Lo ~/.aws-lambda-rie/aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie && \
            chmod +x ~/.aws-lambda-rie/aws-lambda-rie
        ```
    2. Spin up the container 
        ```sh
        docker run -d \
            -v ~/.aws-lambda-rie:/aws-lambda \
            -p 9000:8080 \
            --entrypoint /aws-lambda/aws-lambda-rie \
            aws-lambda-container_myfunction:latest \
            /venv/bin/python -m awslambdaric lambda_function.handler
        ```
    3. Invoke the function
        ```sh
        curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"input":"10"}'
        ```

# Push image to ECR and deploy manually 
```sh
TBD
```
# Main commands for CI/CD pipeline
* CI (build the image and push to ECR)
    ```sh
    TBD
    ```
* CD (update the lambda function using the new version of image from ECR)
    ```sh
    TBD
    ```

