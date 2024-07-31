# Base image olarak ubi8 kullanıyoruz
FROM redhat/ubi8:latest

# Yazar bilgisi
LABEL maintainer="Ertuğrul Aydın" \
      description="PostgreSQL 16 Server on UBI 8"

# PostgreSQL deposunu ekliyoruz ve gereken paketleri yüklüyoruz
RUN yum install -y sudo \
    && yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-aarch64/pgdg-redhat-repo-latest.noarch.rpm \
    && yum install -y postgresql16-server postgresql16-contrib procps-ng vim \
    && yum clean all

# PostgreSQL veritabanı dizinlerini oluşturuyoruz
RUN mkdir -p /var/lib/pgsql/data

# Postgresql kullanıcısının zaten var olup olmadığını kontrol ediyoruz ve veritabanı dizininin sahibini bu kullanıcı yapıyoruz
RUN if ! id "postgres" >/dev/null 2>&1; then useradd -m postgres; fi \
    && chown -R postgres:postgres /var/lib/pgsql

# Kullanıcıyı postgres olarak değiştiriyoruz
USER postgres

# Veritabanı dizinini başlatıyoruz
RUN /usr/pgsql-16/bin/initdb -D /var/lib/pgsql/data

# Kullanıcıyı root olarak değiştiriyoruz
USER root

# PostgreSQL'i dışa açmak için portu belirtiyoruz
EXPOSE 5432

# Başlangıç betiğini ekliyoruz
COPY start.sh /start.sh
RUN chmod +x /start.sh

# $PATH değişkenini PostgreSQL binary'lerini içerecek şekilde ayarlama
ENV PATH="/usr/pgsql-16/bin:${PATH}"
ENV PGDATA=/var/lib/pgsql/data

# PostgreSQL sunucusunu başlatmak için başlangıç betiğini kullanıyoruz
ENTRYPOINT ["/start.sh"]