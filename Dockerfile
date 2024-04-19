FROM ubuntu:22.04

# Install required dependencies
RUN apt-get update && apt-get install -y git cmake g++ curl
WORKDIR /app

# Clone the Proxygen repository
RUN git clone https://github.com/facebook/proxygen.git

RUN apt-get install python3 python3-pip -y
RUN apt-get install -y openssl libssl-dev pkg-config
RUN apt-get install -y autoconf automake libtool

# Build and install Proxygen
WORKDIR /app/proxygen
RUN ./getdeps.sh

WORKDIR /app
COPY . .
RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# Set the default command to run when the container starts
CMD ["./build/server"]