# 使用官方的 Node.js 镜像作为构建阶段
FROM node:18.18.1

# 设置工作目录
WORKDIR /usr/src/app

# 安装依赖
COPY package*.json ./
RUN npm install

# 复制项目文件
COPY . .

# 构建应用
RUN npm run build

# 使用 Nginx 镜像作为生产阶段
FROM nginx:alpine

# 复制构建输出到 Nginx 的默认静态资源目录
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# 复制 Nginx 配置文件
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]