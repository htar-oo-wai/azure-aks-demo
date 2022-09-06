resource "null_resource" "ad-pod-identity"{
provisioner "local-exec" {
command= "kubectl create -f https://raw.githubusercontent.com/Azure/aad-pod-identity/master/deploy/infra/deployment.yaml"
    }
}

resource "null_resource" "application-gateway-ingress"{
provisioner "local-exec" {
command= "helm repo add application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/"
    }
}
resource "null_resource" "application-gateway-ingress-config"{
provisioner "local-exec" {
command="helm install -f helm-config.yaml application-gateway-kubernetes-ingress/ingress-azure --generate-name"
    }
}

resource "null_resource" "web-install"{
provisioner "local-exec" {
command="kubectl apply -f application.yaml" 
   }
}

resource "null_resource" "prmethous"{
provisioner "local-exec" {
command="helm repo add prometheus-community https://prometheus-community.github.io/helm-charts" 
   }
}

resource "null_resource" "prmethous-update"{
provisioner "local-exec" {
command="helm repo update" 
   }
}
resource "null_resource" "prmethous-install"{
provisioner "local-exec" {
command="helm install prometheus  prometheus-community/kube-prometheus-stack  --namespace monitoring  --create-namespace" 
   }
}

#to check promethous - run kubectl --namespace monitoring get pods -l "release=prometheus"

# resource "helm_release" "prometheus" {
#   chart      = "prometheus"
#   name       = "prometheus"
#   namespace  = var.namespace
#   repository = "https://prometheus-community.github.io/helm-charts"
#   version    = "15.5.3"

#   set {
#     name  = "podSecurityPolicy.enabled"
#     value = true
#   }

#   set {
#     name  = "server.persistentVolume.enabled"
#     value = false
#   }
