FROM steamcmd/steamcmd:latest

# prepare steamcmd user
RUN useradd -m steamcmd

# prepare server directory
RUN mkdir /opt/satisfactory-server
RUN chown steamcmd:steamcmd /opt/satisfactory-server

# install satisfactory
RUN su steamcmd -c "steamcmd +login anonymous +force_install_dir /opt/satisfactory-server +app_update 1690800 validate +quit"

# fix error "SteamAPI_Init(): Sys_LoadModule filed to load: /path/to/.steam/sdk64/steamclient.so"
RUN su steamcmd -c "ln -s /home/steamcmd/.steam/steamcmd/linux64 /home/steamcmd/.steam/sdk64"

# Expose ports
EXPOSE 7777/udp
EXPOSE 15000/udp
EXPOSE 15777/udp

ENTRYPOINT ["su", "steamcmd", "-c"]
CMD ["/opt/satisfactory-server/FactoryServer.sh"]