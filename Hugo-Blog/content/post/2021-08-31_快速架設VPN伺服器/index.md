---
slug: "build-vpn-server"
title: "快速架設VPN伺服器"
description: 教你十分鐘內架好自己的VPN伺服器。
date: 2021-08-31
image: article-img.jpg
license: 
hidden: false
comments: true
tags: ["main"]
---

### 註：我先預設會讀這篇的都會用Linux...

### Step1: 租一台Linux虛擬主機

選擇自己喜歡的虛擬主機供應商，租一台虛擬主機。  
我目前是使用AWS的 [Lightsail](https://aws.amazon.com/tw/lightsail/) (VPS主機)，每個月只要3.5美元。

### Step2: 安裝 OpenVPN Server

#### 本文使用 [Nyr/openvpn-install](https://github.com/Nyr/openvpn-install) 進行安裝

```
sudo su
wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
```

#### 輸入完成後接著它會問題幾個問題：

1. UDP (建議) / TCP
2. port: (建議更改)
3. DNS server
4. 第一個用戶名稱

範例如下圖：
<img src="https://i.imgur.com/QEQEspC.png" alt="drawing" width="400"/>

### Step3: 下載你的使用者檔案
架設好OpenVPN Server之後，  
目錄下會多一個.ovpn檔，例如：```KevinChen.ovpn```  
我自己是習慣用FileZilla下載到client端。  


### Step4: 安裝 OpenVPN Client

在你想用VPN的電腦上面安裝 [OpenVPN Client](https://openvpn.net/vpn-client/)  
然後把ovpn檔案丟進去，就完成囉～  
在IP查詢網站上面測試看看：  
![](https://i.imgur.com/skrSkQ0.png)


### 結語
使用這個方法只需要5分鐘就可以搞定，感謝社群的貢獻，  
如果這個方法有幫助到你，歡迎去作者的github幫他按個星星哦～  
我真的很喜歡這些有效又簡單的解決方案。  

**實測2021/08/30可行。**  
沒有什麼方法是永遠有效的，至少現在還能用就好。