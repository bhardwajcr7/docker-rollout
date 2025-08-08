# Build stage
FROM node:18-alpine AS build
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build

# Production stage
FROM node:18-alpine AS prod
WORKDIR /usr/src/app

# Copy only necessary files
COPY --from=build /usr/src/app/package*.json ./
RUN npm install --omit=dev

COPY --from=build /usr/src/app/build ./build

CMD ["npm", "start"]
