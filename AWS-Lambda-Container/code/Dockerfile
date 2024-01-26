FROM python:3.9-slim-bullseye AS base

# install required pkgs
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y git curl iputils-ping

# create virtual environment and install python pkgs
RUN python -m venv /venv
ENV PATH=/venv/bin:$PATH
RUN python -m pip install --upgrade pip

COPY ./requirements.txt ./requirements.txt
RUN python -m pip install -r requirements.txt
# RUN python -m pip install numpy==1.23.0
# RUN python -m pip install pandas==1.4.2
# RUN python -m pip install pytest==7.1.1

# set up env var
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

FROM base as final-islocaldevelopment-true

RUN python -m pip install ipykernel==6.29.0
RUN python -m pip install pytest==7.4.4

FROM base as final-islocaldevelopment-false

# Define custom function directory
ARG FUNCTION_DIR="/function"

# Copy function code
RUN mkdir -p ${FUNCTION_DIR}
COPY . ${FUNCTION_DIR}

# Install the function's dependencies
RUN python -m pip install \
    --target ${FUNCTION_DIR} \
        awslambdaric

# Set working directory to function root directory 
WORKDIR ${FUNCTION_DIR}


# Set runtime interface client as default command for the container runtime
ENTRYPOINT [ "/venv/bin/python", "-m", "awslambdaric" ]
# Pass the name of the function handler as an argument to the runtime
CMD ["lambda_function.handler"]



