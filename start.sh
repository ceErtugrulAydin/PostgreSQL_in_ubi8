#!/bin/bash

export PATH=/usr/pgsql-16/bin:$PATH
export PGDATA=/var/lib/pgsql/data

# PostgreSQL sunucusunu postgres kullanıcısı olarak başlatıyoruz
su - postgres -c "/usr/pgsql-16/bin/pg_ctl -D /var/lib/pgsql/data -l /var/lib/pgsql/data/logfile start"

# stop = false

# # PostgreSQL sunucusunu durdurma fonksiyonu
# stop_postgres() {
#   echo "PostgreSQL sunucusu durduruluyor..."
#   su - postgres -c "/usr/pgsql-16/bin/pg_ctl -D /var/lib/pgsql/data stop"
#   stop = true
# }

# # Sinyalleri yakalıyoruz
# trap 'stop_postgres' SIGINT SIGTERM

# PostgreSQL process'ini kontrol eden bir döngü
while true; do
  sleep 10
#   if [ "$stop" = false ]; then
#     echo "PostgreSQL process'i bulunamadı, yeniden başlatılıyor..."
#     su - postgres -c "/usr/pgsql-16/bin/pg_ctl -D /var/lib/pgsql/data -l /var/lib/pgsql/data/logfile start"
#   fi
done