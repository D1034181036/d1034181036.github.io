---
slug: "this-video-has-69-views"
title: "有 6,987 個人點進來看我把筆放到貓的左手上"
description: 自動更新YouTube影片標題，讓別人以為你閒到像個神經病～
date: 2021-09-21
image: article-img.png
license: 
hidden: false
comments: true
tags: ["web"]
---

### [YouTube影片連結](https://youtu.be/aST49yvU3x0)
![thumbnail](https://i.imgur.com/hYEUdS8.png)

## 想法來源：Tom Scott

#### 非常有意思的影片，強烈推薦。
#### [This Video Has X Views](https://youtu.be/BxV14h0kFs0)

## 自己動手做

我在這邊選擇使用 Google Apps Script 來實作，原因有以下三點：

1. 授權 YouTube API 的方式非常簡單。
2. 方便連結 Google Sheet 紀錄執行結果。
3. 可以排程定時執行，無須自己花錢架設伺服器。

## 版本1 - 基本功能版

### 功能非常的簡單，只需要三行程式碼：
1. 呼叫api取得影片資訊
2. 更改影片資訊的標題欄(改為現在的觀看次數)
3. 呼叫api執行更新


```javascript=
function basic(){
  // 影片ID設定
  const videoId = "aST49yvU3x0";
  // 標題格式設定
  const titleFormat = "有 {views} 個人點進來看我把筆放到貓的左手上";
  // 取得影片資訊
  const videoDetails = YouTube.Videos.list("snippet, statistics", { id: videoId })['items'][0];
  // 更新標題資訊
  videoDetails['snippet']['title'] = titleFormat.replace("{views}", videoDetails['statistics']['viewCount'].toLocaleString('en-US'));
  // 執行更新
  YouTube.Videos.update(videoDetails, "id,snippet,statistics");
}
```



## 版本2 - 進階功能版

### 多增加三點功能
1. 若觀看次數相同，則不更新影片，這樣可以節省api的呼叫次數。
2. 將執行結果記錄在Google App Script Log，方便debug。
3. 將更新內容記錄在Google Sheets上，方便隨時查看更新記錄。

### 主程式
```javascript=
function main(){
  const videoId = "aST49yvU3x0";
  const titleFormat = "有 {views} 個人點進來看我把筆放到貓的左手上";
  const sheetId = "{sheet_id}";

  const response = YouTube.Videos.list("snippet, statistics", { id: videoId });
  const videoDetails = response['items'][0];

  const currentTitle = videoDetails['snippet']['title'];
  const currentViews = videoDetails['statistics']['viewCount'];
  const newTitle = titleFormat.replace("{views}", currentViews.toLocaleString('en-US'));

  if(currentTitle !== newTitle){
    videoDetails['snippet']['title'] = newTitle;
    YouTube.Videos.update(videoDetails, "id,snippet,statistics");
    Logger.log(`Update completed: ${newTitle}`);
    sheetLog(sheetId, currentViews);
  }else{
    Logger.log("No need to update");
  }
}
```
### 記錄Google Sheets
```javascript=
function sheetLog(sheetId, views){
  const spreadSheet = SpreadsheetApp.openById(sheetId);
  const sheet = spreadSheet.getSheets()[0];

  const lastRow = sheet.getLastRow();
  const currentDate = new Date();

  sheet.getRange(lastRow+1, 1).setValue(currentDate.toLocaleString('zh-tw', { timeZone: 'Asia/Taipei' }));
  sheet.getRange(lastRow+1, 2).setValue(views);
  sheet.getRange(lastRow+1, 3).setValue(currentDate.getTime());
}
```

## 如何使用

1. 上傳一支影片到YouTube，並且取得影片ID。
2. 建立一個Google App Script，設定videoId, titleFormat。
3. 設定排程，建議10分鐘執行一次，避免次數用完，詳細請見[Quota Calculator](https://developers.google.com/youtube/v3/determine_quota_cost)。
4. (Optional)建立Google Sheet並在Google App Script內設定sheetId。

## 成果發表

### 更新記錄
![](https://i.imgur.com/tABUTAK.png)