# FROM node:16 AS builder
# WORKDIR '/app'
# COPY package.json .
# RUN npm install
# COPY . .
# RUN npm run build

# FROM nginx
# EXPOSE 80
# COPY --from=builder /app/dist /usr/share/nginx/html


FROM node:16

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

CMD ["npx", "ng", "serve", "--host", "0.0.0.0"]