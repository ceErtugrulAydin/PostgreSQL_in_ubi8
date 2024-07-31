# ubi8 içerisinde PostgreSQL

ubi8 imajının içerisinde PostgreSQL sunucusu olan yeni bir imaj. PostgreSQL sunucusu durdurulsa bile pod çökmemektedir.

macOS, Linux:

```bash
eval $(minikube docker-env)
```

Artık bu mevcut terminalde çalıştırdığınız herhangi bir 'docker' komutu minikube kümesi içindeki docker'a karşı çalışacaktır.

Docker imajı oluşturun:

```bash
sudo docker build -t pg-in-ubi8 .
```

Oluşan Docker imajını yükleyin:

```bash
minikube image load pg-in-ubi8
```

Manifest dosyalarını kullanarak PV, PVC, StatefulSet ve Service'i Kubernetes cluster'ınıza yükleyin:

```bash
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
kubectl apply -f statefulset.yaml
kubectl apply -f service.yaml
```

Öncelikle PostgreSQL pod'unuzun adını öğrenmeniz gerekiyor. Pod adını öğrenmek için şu komutu çalıştırın:

```bash
kubectl get pods
```

Pod adını öğrendikten sonra, pod'un içerisine girmek için kubectl exec komutunu kullanın:

```bash
kubectl exec -it <pod-adı> -- /bin/bash
```

Pod’un içine girdikten sonra postgres kullanıcısına geçiş yapıp PostgreSQL sunucusuyle ilgili ayarlar yapabilirsiniz:

```bash
#postgres kullanıcısına geçiş yapmak için:
su postgres

#PostgreSQL sunucusnu durdurmak için:
pg_ctl stop

#PostgreSQL sunucusunu başlatmak için:
pg_ctl start
```

postgres kullanıcısındayken PostgreSQL sunucusuna bağlanın:

```bash
psql
```