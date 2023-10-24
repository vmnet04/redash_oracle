# Use the Redash base image based on CentOS
FROM redash/redash:latest

# Switch to the root user to perform system-level installations
USER root

# Update the package manager and install dependencies
RUN yum -y update && \
    yum -y install unzip libaio

# Clean up the package manager
RUN yum clean all

# -- Start setup Oracle
# Add Oracle Instant Client files
ADD oracle/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip /tmp/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip
ADD oracle/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip /tmp/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip
ADD oracle/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip /tmp/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip
ADD oracle/instantclient-odbc-linux.x64-19.3.0.0.0dbru.zip /tmp/instantclient-odbc-linux.x64-19.3.0.0.0dbru.zip
ADD oracle/instantclient-jdbc-linux.x64-19.3.0.0.0dbru.zip /tmp/instantclient-jdbc-linux.x64-19.3.0.0.0dbru.zip

# Create the Oracle directory and unzip the files
RUN mkdir -p /opt/oracle/ && \
    unzip /tmp/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip -d /opt/oracle/ && \
    unzip /tmp/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip -d /opt/oracle/ && \
    unzip /tmp/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip -d /opt/oracle/ && \
    unzip /tmp/instantclient-odbc-linux.x64-19.3.0.0.0dbru.zip -d /opt/oracle/ && \
    unzip /tmp/instantclient-jdbc-linux.x64-19.3.0.0.0dbru.zip -d /opt/oracle/

# Set Oracle environment variables
ENV ORACLE_HOME=/opt/oracle/instantclient_19_3
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_19_3:$LD_LIBRARY_PATH
ENV PATH=/opt/oracle/instantclient_19_3:$PATH

# Add REDASH ENV to include Oracle Query Runner
ENV REDASH_ADDITIONAL_QUERY_RUNNERS=redash.query_runner.oracle
# -- End setup Oracle

# Continue with the rest of your Dockerfile as needed (e.g., installing Python packages)
# ...

# Switch back to the non-root user (if needed)
USER redash
