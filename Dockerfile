FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /src
COPY ["vizientdemo.csproj", "."]
RUN dotnet restore "vizientdemo.csproj"
COPY . .
RUN dotnet build "vizientdemo.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "vizientdemo.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "vizientdemo.dll"]