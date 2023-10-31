# Database
# Redis memiliki konsep database seperti pada relational database mysql atau postgre
# Kita bisa menggunakan database sejumlah maksimal sesuai dengan konfigurasi yang kita gunakan di file konfigurasi (redis.conf)
# Operasi          Keterangan
# select database  Selecting database number
# select 0, select 1, select 2, select 4

localhost:6379> select 0
OK
localhost:6379> select 1
OK
localhost:6379[1]> select 2
OK
localhost:6379[2]> select 3
OK
localhost:6379[3]>