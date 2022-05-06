---
slug: "Nginx-Proxy-Manager"
title: "反向代理工具：Nginx Proxy Manager"
description: 反向代理工具：Nginx Proxy Manager
date: 2022-05-06
image: article-img.png
license: 
hidden: false
comments: true
tags: ["web"]
---

>官方網站：https://nginxproxymanager.com/

## 為什麼要使用Nginx Proxy Manager？
- 多人管理系統、圖形化介面
- 漂亮的介面、一目了然所有的Proxy設定
- 內建Let's Encrypt，免費又快速的幫你加上HTTPS

## 安裝方法：使用Docker-Compose

### Step1: 安裝 [Docker](https://docs.docker.com/install/)

### Step2: 安裝 [Docker-Compose](https://docs.docker.com/compose/install/) [Optional]

### Step3: 建立 `docker-compose.yml`
```
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
```

### Step4: 啟動服務 `docker-compose up -d`

### Step5: 開始使用 - http://127.0.0.1:81
若是使用SSH安裝，可以依照不同情況遠端連到`127.0.0.1:81`。
以下幾種連接方式提供做為參考：

- SSH Tunnel
- 公開實體IP / NAT轉址
- 區網虛擬IP

**預設管理員帳密**
```
Email: admin@example.com
Password: changeme
```

---

## 新增Proxy示範
![](https://i.imgur.com/ge9Rxla.png)

## Proxy列表
![](https://i.imgur.com/R2bo46x.png)