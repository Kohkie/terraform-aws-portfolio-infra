# 🚀 Terraform AWS Portfolio Infrastructure

このプロジェクトは、Terraform を用いて AWS 上に仮想インフラを構築する模擬案件です。

構築対象：
- VPC
- Subnet（2つ、別AZ）
- Internet Gateway
- Route Table
- EC2（Ubuntu 22.04）
- RDS（MariaDB）
- S3（バックアップ用）

---

## ✅ 事前準備

- AWSアカウントとCLIのセットアップ
- SSH Key作成済み
- Terraform v1.5以上インストール済み

---
## 🗂 構成図

![構成図](https://github.com/Kohkie/terraform-aws-portfolio-infra/blob/main/May%2030,%202025%20at%2007_56_38%20PM.png?raw=true)


---


## 🛠 デプロイ手順

以下の手順で、Terraform による AWS インフラの構築を実行できます。

### 1. `terraform.tfvars` を準備

変数定義ファイル `terraform.tfvars` を用意し、以下のような内容を記述します：

```hcl
aws_region = "ap-northeast-1"
instance_type = "t3.micro"
key_name = "your-key-name"
db_name = "mydb"
db_username = "admin"
db_password = "your-secure-password"
