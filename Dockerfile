FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Instala herramientas necesarias
RUN apt-get update && apt-get install -y curl gnupg apt-transport-https software-properties-common

# Agrega repositorio de SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)" && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-server

# Configura SQL Server
RUN /opt/mssql/bin/mssql-conf -n setup accept-eula && \
    MSSQL_PID=Developer MSSQL_SA_PASSWORD="YourStrong!Passw0rd" /opt/mssql/bin/mssql-conf setup

# Expone puerto
EXPOSE 1433

# Inicia SQL Server
CMD ["/opt/mssql/bin/sqlservr"]
