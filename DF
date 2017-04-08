FROM fsharp

# Download nuget from web
# Use nuget to download FAKE.
# Define a shortcut to call fake without refering to mono or binary path.

RUN wget -q -O NuGet.exe 'https://github.com/NuGet/Home/releases/download/3.2/nuget.exe'                  \
 && mono NuGet.exe install fake -ExcludeVersion -OutputDirectory /usr/lib -Verbosity quiet                \
 && echo "#!/bin/bash" > /usr/local/bin/fake                                                              \
 && echo "mono /usr/lib/FAKE/tools/FAKE.exe \"\$@\"" >> /usr/local/bin/fake                               \
 && chmod +x /usr/local/bin/fake                                                                          

WORKDIR /app

ENTRYPOINT ["fake"]