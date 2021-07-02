apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: {{ k8s_cluster.certificate_authority_data }}
    server: https://{{ k8s_cluster.ip }}:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    namespace: kube-system
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: {{ k8s_cluster.client_certificate_data }}
    client-key-data: {{ k8s_cluster.client_key_data }}
    token: {{ k8s_cluster.token }}
