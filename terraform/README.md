# Terraform Infrastructure for Ecommerce App

This Terraform configuration provides a complete Google Cloud infrastructure setup for deploying the ecommerce app to Google Kubernetes Engine (GKE) with CI/CD support via GitHub Actions.

## 📁 Directory Structure

```
terraform/
├── modules/
│   ├── compute/              # GKE cluster configuration
│   ├── network/              # VPC and networking
│   ├── storage/              # Cloud Storage buckets
│   ├── artifactregistry/     # Docker image registry
│   └── serviceaccount/       # IAM service accounts and permissions
├── main.tf                   # Module instantiation
├── provider.tf               # Provider configuration
├── variables.tf              # Variable definitions
├── output.tf                 # Output values
└── terraform.tfvars          # Variable values (customize this!)
```

## 🚀 Quick Start

### Prerequisites

1. **Terraform** >= 1.0 installed
   ```bash
   # Verify installation
   terraform --version
   ```

2. **Google Cloud SDK** installed and authenticated
   ```bash
   # Install from: https://cloud.google.com/sdk/docs/install
   gcloud auth application-default login
   gcloud config set project YOUR_PROJECT_ID
   ```

3. **Required GCP permissions:**
   - Kubernetes Engine Admin
   - Compute Admin
   - Service Account Admin
   - Artifact Registry Administrator
   - Storage Admin

### Step 1: Configure Variables

Edit `terraform.tfvars` with your configuration:

```hcl
project_id = "your-gcp-project-id"  # Required: Your GCP project
region     = "us-central1"           # Optional: Change if needed
bucket_name = "ecommerce-app-bucket-YOUR_PROJECT_ID"  # Required: Must be globally unique
```

### Step 2: Initialize Terraform

```bash
cd terraform
terraform init
```

This downloads the required providers and initializes the backend.

### Step 3: Plan Your Infrastructure

```bash
terraform plan
```

Review the output to see what resources will be created.

### Step 4: Apply Configuration

```bash
terraform apply
```

Type `yes` to confirm deployment. This will take 10-15 minutes.

### Step 5: Get Outputs

After deployment:

```bash
terraform output
```

Save these outputs for GitHub Actions configuration:
- `artifact_registry_url` - Docker image registry URL
- `github_actions_service_account_email` - For GitHub Actions authentication

## 📚 Module Descriptions

### Network Module
Creates VPC and networking infrastructure:
- VPC Network with custom subnets
- Internal firewall rules (TCP/UDP)
- HTTP/HTTPS firewall rules

**Key Output:** `vpc_network_id`, `subnet_id`

### Compute Module (GKE)
Deploys a managed Kubernetes cluster:
- GKE cluster with auto-scaling node pool
- Workload Identity enabled
- Cloud Logging and Cloud Monitoring integrated

**Key Output:** `kubernetes_cluster_name`, `kubernetes_cluster_host`

### Storage Module
Sets up Cloud Storage:
- Versioning enabled for data protection
- Automatic lifecycle transitions (NEARLINE → COLDLINE)
- Service account access control

**Key Output:** `bucket_url`

### Artifact Registry Module
Creates Docker image registry:
- Docker repository
- IAM permissions for GitHub Actions (push)
- IAM permissions for GKE (pull)
- Cleanup policies (keeps last 10 images)

**Key Output:** `artifact_registry_url` (format: `region-docker.pkg.dev/project/repo`)

### Service Account Module
Sets up authentication and authorization:
- GitHub Actions service account (for pushing images)
- GKE workload service account (for pulling images)
- Required IAM roles and permissions
- Optional service account key creation

**Key Outputs:**
- `github_actions_service_account_email`
- `gke_workload_service_account_email`

## 🔐 Security Features

✅ **Workload Identity**: GKE pods authenticate to Google Cloud services without keys  
✅ **RBAC**: Fine-grained IAM permissions per service account  
✅ **Preemptible Nodes**: Cost optimization for non-production workloads  
✅ **Network Isolation**: Private subnets with firewall rules  
✅ **Versioning & Backups**: Cloud Storage versioning enabled  

## 🔧 Common Configurations

### Production Setup
```hcl
preemptible = false          # Non-preemptible nodes for stability
node_count = 3               # More nodes for redundancy
max_node_count = 10          # Higher scaling limit
machine_type = "e2-standard-4"  # Larger machines
```

### Cost Optimization
```hcl
preemptible = true           # Enable preemptible nodes (70% savings)
node_count = 1               # Minimal nodes
max_node_count = 3           # Limited scaling
machine_type = "e2-small"    # Smaller machines
```

### Different Region
```hcl
region = "europe-west1"      # Choose any GCP region
```

## 📝 GitHub Actions Integration

After Terraform deployment, configure GitHub Actions to push images to Artifact Registry:

### 1. Create GitHub Action Secret

Add to GitHub repository settings:
- **Secret Name:** `GCP_PROJECT_ID`  
- **Secret Value:** (from `terraform output project_id`)

### 2. Use in GitHub Actions Workflow

```yaml
name: Build and Push Docker Image

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      id-token: write

    steps:
      - uses: actions/checkout@v3

      - name: Set up Cloud SDK
        uses: google-github-actions/setup-gcloud@v1

      - name: Build Docker image
        run: |
          docker build -t docker-image:${{ github.sha }} ./ecommerce-app

      - name: Push to Artifact Registry
        run: |
          gcloud auth configure-docker us-central1-docker.pkg.dev
          docker tag docker-image:${{ github.sha }} \
            us-central1-docker.pkg.dev/${{ secrets.GCP_PROJECT_ID }}/ecommerce-docker/ecommerce-app:${{ github.sha }}
          docker push \
            us-central1-docker.pkg.dev/${{ secrets.GCP_PROJECT_ID }}/ecommerce-docker/ecommerce-app:${{ github.sha }}
```

## 🛠️ Maintenance Commands

### View Current State
```bash
terraform state list
terraform state show module.compute.google_container_cluster.primary
```

### Update Configuration
```bash
# Edit terraform.tfvars, then:
terraform plan
terraform apply
```

### Destroy Infrastructure
```bash
terraform destroy
```

### Backend State Management
By default, state is stored locally. For team environments:

```hcl
# Uncomment in provider.tf
backend "gcs" {
  bucket = "your-terraform-state-bucket"
  prefix = "ecommerce-app"
}
```

## 📊 Estimated Costs

- **GKE Cluster**: ~$50-100/month (2 e2-medium nodes, preemptible)
- **Cloud Storage**: ~$0.20/GB stored
- **Artifact Registry**: ~$0.10 per GB stored

*Note: Preemptible nodes can reduce GKE costs by 70%*

## 🐛 Troubleshooting

### Error: "resource already exists"
```bash
terraform import google_compute_network.vpc <network-id>
```

### Error: "permission denied"
Ensure your GCP service account has required roles:
```bash
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=serviceAccount:SA_EMAIL \
  --role=roles/container.admin
```

### Get GKE Cluster Credentials
```bash
gcloud container clusters get-credentials ecommerce-gke-cluster \
  --region us-central1
```

## 📚 Documentation References

- [Terraform Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Google Cloud GKE](https://cloud.google.com/kubernetes-engine/docs)
- [Artifact Registry](https://cloud.google.com/artifact-registry/docs)
- [Service Accounts](https://cloud.google.com/docs/authentication/service-accounts)

## 💡 Next Steps

1. ✅ Run `terraform init && terraform plan`
2. ✅ Review the plan output
3. ✅ Run `terraform apply` to create infrastructure
4. ✅ Configure GitHub Actions using output values
5. ✅ Deploy your ecommerce app to GKE

## 📞 Support

For issues or questions:
- Check Terraform logs: `TF_LOG=DEBUG terraform apply`
- Review GCP Cloud Console for resource details
- Consult [Terraform documentation](https://www.terraform.io/docs)
