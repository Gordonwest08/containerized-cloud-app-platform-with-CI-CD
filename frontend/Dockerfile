#Build stage
######################
FROM node:22-alpine AS build

WORKDIR /app

#copy dependency manifests (package-lock optional)
COPY package*.json ./

#install dependencies with npm so builds stay reproducible even without a lockfile
RUN npm install

#copy source code and config
COPY index.html .
COPY vite.config.js .
COPY src ./src


#build production assests
RUN npm run build

#########################
#stage2:Runtimestage(distroless)
#########################
FROM gcr.io/distroless/nodejs20-debian12

WORKDIR /app   
#Copy only built output from previous stage
COPY --from=build /app/dist ./dist

#Document port to be exposed here
EXPOSE 3000



#start the app
CMD ["dist/index.js"]
