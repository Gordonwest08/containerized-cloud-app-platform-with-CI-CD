#Build stage
######################
FROM node:22-alpine AS build

WORKDIR /app

#copy dependency manifests
COPY package.json package-lock.json ./

#instal exact dependencies
RUN npm ci

#copy source code
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

EXPOSE 3000
#start the app
CMD ["dist/index.js"]
