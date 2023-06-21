# Use a imagem base do Go para compilação
FROM golang:latest AS build

# Desabilitar lookup de DNS para acelerar a compilação
ENV CGO_ENABLED=0

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie os arquivos do projeto para o contêiner
COPY . .

# Compile o aplicativo com flags de compilação estática e otimização
RUN go build -ldflags="-s -w" -a -installsuffix cgo -o main .

# Use uma imagem base mínima
FROM scratch

# Copie o executável do aplicativo da imagem de compilação
COPY --from=build /app/main /

# Defina o comando de inicialização do contêiner
CMD ["/main"]
