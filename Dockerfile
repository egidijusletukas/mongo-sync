FROM alpine

RUN apk update
RUN apk upgrade
RUN apk add git go musl-dev bash
RUN git clone https://github.com/mongodb/mongo-tools
RUN cd mongo-tools && \
    source ./set_gopath.sh && \
    mkdir bin && \
    go build -o bin/mongodump mongodump/main/mongodump.go && \
    go build -o bin/mongorestore mongorestore/main/mongorestore.go
RUN mv /mongo-tools/bin/mongodump /bin/mongodump
RUN mv /mongo-tools/bin/mongorestore /bin/mongorestore
ADD ./mongo-sync /bin/mongo-sync