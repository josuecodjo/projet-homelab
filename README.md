# projet-homelab


## Getting started

- Create a multipass vm `multipass launch -n k8s -c 2 -m 8G -d 20G noble`
- Generate ssh keypair and copy over the newly created machine
- Get the IP and replace in `host_vars/stormy.yml`

### Edit the inventory and test

```sh
ansible all -i hosts_global -m ping
```

### Install roles

```sh

## install to .ansible
ansible-galaxy install --ignore-errors  -r roles/requirements.yml

## install to roles folder
ansible-galaxy install --ignore-errors  -r roles/requirements.yml --roles-path roles
```

### Launch playbook

```sh
ansible-playbook -i hosts_global playbook.yml
ansible-playbook -i hosts_global playbook.yml -l stormy
ansible-playbook -i hosts_global playbook.yml -l stormy -t {k3s-traefik, k3s-neutral, argocd, awx, certmanager}
```


### Tips
- `kubectl expose deployment awx-web --type=NodePort --port=8052 --name=awx-nodeport -n awx`
- Sometimes, the certificate request is not there anymore for cert-manager. In this case delete the secret related to the certificate secret with `kubectl delete secret awx.home.lab -n awx` and the certificaterquest will appear `kubectl get issuer -n awx  && kubectl get certificate -n awx && kubectl get certificaterequest -n awx`