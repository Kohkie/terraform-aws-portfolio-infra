
# Terraform AWS Portfolio Infrastructure

このプロジェクトは、Terraformを使って構築した模擬ポートフォリオ案件です。  
EC2（Ubuntu）、RDS（MariaDB）、S3（バックアップ用）を含む基本的なインフラ環境をコードで定義しています。

## 🔧 使用サービス
- AWS VPC, Subnet, Internet Gateway, Route Table
- EC2（Ubuntu 22.04）
- RDS（MariaDB）
- S3（バックアップ用）

## 🔑 事前準備
- AWSアカウントとCLIのセットアップ
- SSH Key作成済み
- Terraform v1.5以上インストール済み

## 🚀 デプロイ手順
```sh
terraform init
terraform apply -var="key_name=your-key" -var="db_username=admin" -var="db_password=yourpass"
```

## 📂 構成ファイル
- `main.tf`：主要リソース定義
- `variables.tf`：変数管理

## 📜 免責
このコードは個人の学習目的であり、商用利用はサポートしていません。
