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


# Strings
# Redis sebenarnya mendukung struktur data yang banyak, seperti String, List, Set, dan lain-lain
# Namun yang paling sering digunakan adalah struktur data String

# Operasi             Keterangan
# set key value       mengubah string value dari key
# get key             mendapatkan value menggunakan key
# exists key          mengecek apakah key memiliki value
# del key [key ...]   menghapus menggunakan key
# append key value    menambah data value ke key
# keys pattern        mencari key menggunakan patterns

localhost:6379> set budhi "budhi"
OK
localhost:6379> get budhi
"budhi"
localhost:6379> exists budhi
(integer) 1
localhost:6379> append budhi " oct"
(integer) 9
localhost:6379> get budhi
"budhi oct"
localhost:6379> keys *
1) "budhi"
localhost:6379> keys bu*
1) "budhi"
localhost:6379> del budhi
(integer) 1
localhost:6379> get budhi
(nil)
localhost:6379>
