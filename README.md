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

## 🛠️ デプロイ手順

```bash
# 変数ファイルを指定して plan 実行
terraform plan -var-file="terraform.tfvars"

# 実際に構築（apply）
terraform apply -var-file="terraform.tfvars"
