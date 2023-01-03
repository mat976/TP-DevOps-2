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

# lancer la commande dockerfile
```
docker build -t ma_super_app -f C:\Users\matis\OneDrive\Documents\docker\TP-DevOps-2\Dockerfile .
[+] Building 25.1s (10/10) FINISHED
 => [internal] load build definition from Dockerfile                                                               0.0s
 => => transferring dockerfile: 180B                                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/node:12-alpine3.9                                               2.8s
 => [1/5] FROM docker.io/library/node:12-alpine3.9@sha256:16d40e6c2858ee41cc7e19bb36f8a92718ad935ceae036e88dcffb6  3.1s
 => => resolve docker.io/library/node:12-alpine3.9@sha256:16d40e6c2858ee41cc7e19bb36f8a92718ad935ceae036e88dcffb6  0.0s
 => => sha256:16d40e6c2858ee41cc7e19bb36f8a92718ad935ceae036e88dcffb68041dea6c 1.43kB / 1.43kB                     0.0s
 => => sha256:ed9251aca55330890ef48a274c6ce03052e5438e87b6101b0bab5362ac79b5e5 1.16kB / 1.16kB                     0.0s
 => => sha256:a7d6e4c06dd4f80d3ba52db58f3c7421f6c29497ddf084928103d71b6635314c 6.73kB / 6.73kB                     0.0s
 => => sha256:31603596830fc7e56753139f9c2c6bd3759e48a850659506ebfb885d1cf3aef5 2.77MB / 2.77MB                     2.1s
 => => sha256:f5b0d1ce6f59dcbee12d1ce6f4093fa9a7939c7751f00ff2137b4651dcf2de8f 24.49MB / 24.49MB                   1.2s
 => => sha256:55922cf6f31687a003e818aab6c5e42db644b2be19a1c74040d750db3d63354c 2.24MB / 2.24MB                     1.5s
 => => sha256:e8a7c0650cafa577c71ba40f4423d3486d700990904de11327a69bdff61d1a92 283B / 283B                         1.5s
 => => extracting sha256:31603596830fc7e56753139f9c2c6bd3759e48a850659506ebfb885d1cf3aef5                          0.1s
 => => extracting sha256:f5b0d1ce6f59dcbee12d1ce6f4093fa9a7939c7751f00ff2137b4651dcf2de8f                          0.6s
 => => extracting sha256:55922cf6f31687a003e818aab6c5e42db644b2be19a1c74040d750db3d63354c                          0.1s
 => => extracting sha256:e8a7c0650cafa577c71ba40f4423d3486d700990904de11327a69bdff61d1a92                          0.0s
 => [internal] load build context                                                                                  0.1s
 => => transferring context: 40.17kB                                                                               0.0s
 => [2/5] WORKDIR /app                                                                                             0.1s
 => [3/5] COPY package*.json ./                                                                                    0.0s
 => [4/5] RUN npm install --production                                                                            18.5s
 => [5/5] COPY . .                                                                                                 0.0s
 => exporting to image                                                                                             0.5s
 => => exporting layers                                                                                            0.5s
 => => writing image sha256:31202a646c9872753f748826e94a7472c066f87ddaeabc7bd12753305a434a30                       0.0s
 => => naming to docker.io/library/ma_super_app
 ```
 ## on peut lancer l'app
 mais cela ne fonctionne pas car on a pas configurer docker compose:
 ```
 docker run -p 3000:3000 ma_super_app
Running on port 3000
Connection to MySQL failed.
/app/src/index.js:22
      throw error
      ^

Error: connect ECONNREFUSED 0.0.0.0:3306
    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1144:16)
    --------------------
    at Protocol._enqueue (/app/node_modules/mysql/lib/protocol/Protocol.js:144:48)
    at Protocol.handshake (/app/node_modules/mysql/lib/protocol/Protocol.js:51:23)
    at Connection.connect (/app/node_modules/mysql/lib/Connection.js:116:18)
    at /app/src/index.js:19:14
    at Layer.handle [as handle_request] (/app/node_modules/express/lib/router/layer.js:95:5)
    at next (/app/node_modules/express/lib/router/route.js:144:13)
    at Route.dispatch (/app/node_modules/express/lib/router/route.js:114:3)
    at Layer.handle [as handle_request] (/app/node_modules/express/lib/router/layer.js:95:5)
    at /app/node_modules/express/lib/router/index.js:284:15
    at Function.process_params (/app/node_modules/express/lib/router/index.js:346:12) {
  errno: 'ECONNREFUSED',
  code: 'ECONNREFUSED',
  syscall: 'connect',
  address: '0.0.0.0',
  port: 3306,
  fatal: true
}
 ```
 # configuration de dockercompose
 ```
 version: '3.9'
services:
  app:
    image: ma_super_app
    ports:
      - "3000:3000"
    environment:
      - MYSQL_HOST=mysql
      - MYSQL_USER=mon_user
      - MYSQL_PASSWORD=mon_password
      - MYSQL_DATABASE=ma_base_de_donnees
  mysql:
    image: mysql:8.0
    environment:
      - MYSQL_ROOT_PASSWORD=mon_password_root
      - MYSQL_USER=mon_user
      - MYSQL_PASSWORD=mon_password
      - MYSQL_DATABASE=ma_base_de_donnees
 ```
 mise en place de compose:
 ```
 docker-compose up
[+] Running 12/12
 - mysql Pulled                                                                                                    9.3s
   - 0ed027b72ddc Pull complete                                                                                    2.3s
   - 0296159747f1 Pull complete                                                                                    2.3s
   - 3d2f9b664bd3 Pull complete                                                                                    2.4s
   - df6519f81c26 Pull complete                                                                                    2.5s
   - 36bb5e56d458 Pull complete                                                                                    2.6s
   - 054e8fde88d0 Pull complete                                                                                    2.6s
   - f2b494c50c7f Pull complete                                                                                    4.7s
   - 132bc0d471b8 Pull complete                                                                                    4.7s
   - 135ec7033a05 Pull complete                                                                                    6.6s
   - 5961f0272472 Pull complete                                                                                    6.6s
   - 75b5f7a3d3a4 Pull complete                                                                                    6.7s
[+] Running 3/3
 - Network tp-devops-2_default    Created                                                                          1.0s
 - Container tp-devops-2-app-1    Created                                                                          0.6s
 - Container tp-devops-2-mysql-1  Created                                                                          0.6s
Attaching to tp-devops-2-app-1, tp-devops-2-mysql-1
 ```

