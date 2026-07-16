# Local Kubernetes GitOps with Terraform & Kind

This project automates the creation of local Kubernetes clusters using **Kind** and optionally bootstraps a GitOps tool of your choice: **Argo CD** or **Flux CD**.

## 🚀 What this repository does

1. **Creates one or more Kind clusters**  
   Uses the `tehcyx/kind` provider to spin up local clusters such as `dev-cluster`.

2. **Configures networking**  
   Maps host ports `80` and `443` to the Kind control-plane for future ingress use.

3. **Selects a GitOps tool**  
   You can install either Argo CD, Flux CD, or neither by setting the `gitops_tool` variable.

4. **Deploys the chosen GitOps tool**  
   Installs the selected Helm release into the appropriate namespace.

---

## 🛠 Prerequisites

- [Docker](https://www.docker.com) (running)
- [Terraform](https://www.terraform.io)
- [kubectl](https://kubernetes.io)

---

## 💻 Usage

### 1. Initialize and deploy

Run the following commands to provision the cluster and bootstrap the default GitOps tool:

```bash
terraform init
terraform apply
```

By default, this installs **Argo CD**. To choose a different tool, set the `gitops_tool` variable:

```bash
terraform apply -var='gitops_tool=argo'
terraform apply -var='gitops_tool=flux'
terraform apply -var='gitops_tool=none'
```

For a multi-cluster setup, you can pass a list of environments:

```bash
terraform apply -var='environments=["dev","uat","prod"]'
```

### 2. Access the GitOps UI or resources

#### Argo CD

If you installed Argo CD, port-forward the API server to your local machine:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Then open:

```text
https://localhost:8080
```

To retrieve the initial admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

#### Flux CD

If you installed Flux CD, you can verify the installation with:

```bash
kubectl get pods -n flux-system
```

### 3. Destroy the environment

To destroy the cluster and all associated resources:

```bash
terraform destroy
```

---

## ⚙️ Variables

- `environments`: list of clusters to create (default: `['dev']`)
- `gitops_tool`: which GitOps tool to install (`argo`, `flux`, or `none`)