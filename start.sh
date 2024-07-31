#!/bin/bash

export PATH=/usr/pgsql-16/bin:$PATH
export PGDATA=/var/lib/pgsql/data

# PostgreSQL sunucusunu postgres kullanıcısı olarak başlatıyoruz
su - postgres -c "/usr/pgsql-16/bin/pg_ctl -D /var/lib/pgsql/data -l /var/lib/pgsql/data/logfile start"

while true; do
  sleep 10
done
