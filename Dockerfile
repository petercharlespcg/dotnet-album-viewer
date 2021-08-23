# FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS BUILD
# FROM sdk:2.1 AS BUILD
FROM peterreg.azurecr.io/petercharles/sdk:2016-2.1 AS BUILD
WORKDIR /album-viewer
COPY . .
RUN dotnet restore src/AlbumViewerNetCore/AlbumViewerNetCore.csproj
RUN dotnet publish src\AlbumViewerNetCore\AlbumViewerNetCore.csproj -c release -o /app

# FROM mcr.microsoft.com/dotnet/core/runtime:2.1 AS RUN
FROM microsoft/dotnet:2.0-runtime AS RUN
WORKDIR /app
COPY --from=build /app .
EXPOSE 80
CMD dotnet AlbumViewerNetCore.dll
