FROM fsharp

# Download nuget from web
# Use nuget to download FAKE.
# Define a shortcut to call fake without refering to mono or binary path.

RUN wget -q -O NuGet.exe 'https://github.com/NuGet/Home/releases/download/3.2/nuget.exe' \
 && mono NuGet.exe install fake -ExcludeVersion -OutputDirectory /usr/lib -Verbosity quiet \
 && echo "#!/bin/bash" > /usr/local/bin/fake \
 && echo "mono /usr/lib/FAKE/tools/FAKE.exe \"\$@\"" >> /usr/local/bin/fake  \
 && chmod +x /usr/local/bin/fake                                                                          \
 && rm NuGet.exe 

RUN sudo apt-get update \ 
&&  sudo apt-get install apt-transport-https \
&&  sudo sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list' \
&&  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 \                                                                    
&&  sudo apt-get update \
&&  sudo apt-get install -y dotnet-dev-1.0.3 \
&&  sudo apt-get remove -y apt-transport-https \
&&  rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENTRYPOINT ["fake"]