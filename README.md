# TP-DevOps-2 de Matisse demontis

# configuration du dockerfile:
## définir le repertoir de l'application
WORKDIR /src

## Copiez les fichiers de package.json
COPY package*.json ./

## npm install
RUN npm install

## Copiez le code source de l'application dans src
COPY src ./src

## port d'execution 
EXPOSE 3000
