### Lokalen Storage auf node-2 anlegen

```bash
# kubectl konfigurieren
vagrant ssh node-1
cp .kube/config /vagrant/kube-config
exit

vagrant ssh node-2
mkdir .kube
cp /vagrant/kube-config .kube/config
echo 'source <(kubectl completion bash)' >>~/.bashrc
source .bashrc

# kubectl testen
kubectl get pods --all-namespaces

# persistent Volume anlegen
sudo mkdir /mnt/data
sudo sh -c "echo 'Hallo aus dem lokalen Volume auf node-2' > /mnt/data/index.html"

kubectl apply -f /vagrant/storage/pv-volume.yaml

# Pod und PVC erstellen
kubectl apply -f /vagrant/storage/pv-pod.yaml

# zum Pod verbinden und Volume ausprobieren
kubectl exec -ti task-pv-pod -- bash
curl http://localhost/
# Antwort sollte sein: Hallo aus dem lokalen Volume auf node-2
```