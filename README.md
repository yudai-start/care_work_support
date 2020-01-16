# Auto Photo Sharing
介護施設の職員、入居者、その家族の写真共有アプリです。  
顔認証機能を用い、入居者家族に自動で写真のアップロード通知を送信できます。

## Description
このアプリケーションには、主に以下の機能があります。
- 写真投稿機能（顔認証による人物特定）  
介護職員が施設の様子を投稿。写真が投稿されると、写っている入居者をawsのAPIにて自動で判別。  
  [顔認証:aws Rekognition(aws API)]
- 家族への通知機能  
施設内で投稿された写真に写っている入居者の家族へ、メールで自動通知送信。  
  [自動メール送信:Action Mailer(gem)]
- 家族プライベート写真共有機能  
家族と入居者のプライベートページ。入居者が家族の様子を楽しめるように、写真のスライドショーを配置。  
  [スライドショー:bxSlider(jQuery プラグイン)]
- 利用者登録機能  
入居者の顔写真と、利用者家族のメールアドレスを登録。awsの顔認証APIを用いてface_idを付与。
- 各ページでの検索機能  
各ページで、写真や利用者の検索が可能。[検索機能: ransack(gem)]
- 認証機能と権限管理  
プライバシー保護のため認証機能を実装。また、介護施設職員と他の利用者で利用権限を分類。  
  [認証機能:devise(gem), 権限管理:cancancan(gem)]

## Demo
以下の接続先からデモを確認できます。テスト用アカウントでログインをしてください。
- 接続先情報 http://18.176.36.137/
- テスト用アカウント
管理者アカウント（施設職員向け）  
Mail: admin@com  
Pass: adm999 
一般ユーザー（施設入居者の家族向け）
Mail: general@com  
Pass: gen111
- メール通知機能のデモ  
管理者アカウントでログインし、右下の投稿フォームより写真を投稿してください。  
入居者と顔が一致した場合、登録済のメールアドレスへ通知が送られ、画面上部にその旨が表示されます。
※他の方の目に触れる可能性があるため、適宜下記のフリー写真をダウンロードして使用してください。  
https://care-work-support.s3-ap-northeast-1.amazonaws.com/uploads/roujin535.jpg  
https://care-work-support.s3-ap-northeast-1.amazonaws.com/uploads/1ab607.jpg

## Development environment
言語:Ruby(2.5.1), HTML, CSS,JavaScript(jQuery)  FW:Ruby on rails(5.0.7.2)  
OS: macOS Catalina   DB: MySQL  サーバー:AWS EC2  Nginx  Unicorn  ストレージ: AWS S3  
ツール:AWS Rekognition(写真顔認証機能)  Capistrano（デプロイ)  
Action Mailer（自動メール送信gem)  cancancan(権限管理gem)
