FROM steamcmd/steamcmd:latest

# prepare steamcmd user
#RUN useradd -md /home/steamcmd -s /bin/bash steamcmd

# prepare server directory
#RUN mkdir /opt/satisfactory-server
#RUN chown steamcmd:steamcmd /opt/satisfactory-server

# switch user
#USER steamcmd:steamcmd
#WORKDIR /home/steamcmd 

# install satisfactory
#RUN steamcmd +login anonymous +force_install_dir /opt/satisfactory-server +app_update 1690800 validate +quit
RUN steamcmd +login anonymous +force_install_dir /home/steamcmd/satisfactory-server +app_update 1690800 validate +quit

# fix error "SteamAPI_Init(): Sys_LoadModule filed to load: /path/to/.steam/sdk64/steamclient.so"
RUN ln -s /home/steamcmd/.steam/steamcmd/linux64 /home/steamcmd/.steam/sdk64

# set server ports
ENV SF_SERVER_QUERY_PORT=15777
ENV SF_BEACON_PORT=15000
ENV SF_PORT=7777

ENTRYPOINT /home/steamcmd/satisfactory-server/FactoryServer.sh -ServerQueryPort=${SF_SERVER_QUERY_PORT} -BeaconPort=${SF_BEACON_PORT} ?listen -Port=${SF_PORT}