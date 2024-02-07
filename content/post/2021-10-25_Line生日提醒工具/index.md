---
slug: "line-birthdy-notify"
title: "Line生日提醒工具"
description: 再也不用擔心忘記家人朋友的生日啦～
date: 2021-10-25
image: article-img.jpg
license: 
hidden: false
comments: true
tags: ["web"]
#categories: ["置頂"]
#weight: 100
---

## 前言
我有一個大學班級的Line群組，
每當有同學生日時，我們老師就會傳訊息祝他生日快樂，
而且持續到現在整整七年都還保持著這個習慣，真的是太有毅力了！
我們有時候還會開玩笑懷疑老師有寫機器人來自動發生日快樂訊息XD

![](https://i.imgur.com/VRpRFRi.png)

現在很多人的Facebook會把生日顯示關掉，因此更有可能錯過這些日子。
所以我們來做個免費、不需架設伺服器的生日提醒系統吧！

## Line 生日提醒工具
### 使用工具
- Google Apps Script
- Google Sheets
- Line Notify

### 運作方式
- 排程設定每天固定時間執行一次 Script
- 讀取 Google Sheets 取得生日資料
- 若近 7 天有人生日就呼叫 Line Notify 傳送提醒 (可自行調整天數)

### 設定步驟
1. [Line Notify](https://notify-bot.line.me/my/) 設定通知群組、取得專用Token
2. [Google Sheets](https://www.google.com.tw/intl/zh-TW/sheets/about/) 建立Sheets檔案，設定格式請參考[這裡](https://i.imgur.com/n4fAxKe.png)
3. [Google Apps Script](https://script.google.com/home/start) 建立程式檔案，請參考下方程式碼範例，將`sheetId`與`token`填入
4. 設定排程定時執行程式
5. 完成！

### 程式碼
```javascript=
function main(){
  //sheetId可以從網址複製 ->https://docs.google.com/spreadsheets/d/{sheet_id}/
  const sheetId = '';
  const token = '';
  const notifyDays = 7;

  const spreadSheet = SpreadsheetApp.openById(sheetId);
  const sheet = spreadSheet.getSheets()[0];
  const data = sheet.getRange(2,1,sheet.getLastRow()-1,3).getValues();

  const now = new Date();
  let message = '';
  data.forEach(item => {
    let birthday = new Date();
    birthday.setMonth(item[0]-1);
    birthday.setDate(item[1]);
    if(now > birthday){
      birthday.setFullYear(birthday.getFullYear()+1);
    }

    let check_date = new Date();
    check_date.setDate(now.getDate() + notifyDays);

    if(check_date >= birthday){
      message += '\n' + item[0] + '/' + item[1] + ' - ' + item[2];
    }
  });
  
  if(message !== ''){
    doPost(token, message);
  }
}

function doPost(token, message) {
  UrlFetchApp.fetch('https://notify-api.line.me/api/notify', {
    'headers': {
      'Authorization': 'Bearer ' + token,
    },
    'method': 'post',
    'payload': {
      'message': message
    }
  });
}
```



## 成果發表
### 設定生日列表 - Google Sheets
![](https://i.imgur.com/n4fAxKe.png)

### 自動提醒 - Line Notify
![](https://i.imgur.com/6GK6DJK.png)
