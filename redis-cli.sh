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

# Operasi Range Data String
# Operasi                     Keterangan
# setrange key offset value   mengubah value dari offset yang ditentukan
# getrange key start end      mengambil value dari range yang ditentukan

localhost:6379> set budhi "budhi octaviansyah"
OK
localhost:6379> get budhi
"budhi octaviansyah"
localhost:6379> setrange budhi 6 "octaviansyah 868"
(integer) 22
localhost:6379> get budhi
"budhi octaviansyah 868"
localhost:6379> getrange budhi 6 18
"octaviansyah "
localhost:6379>

# Operasi Multiple Data String
# Operasi                           Keterangan
# mget key [key ...]                Get the values of all the given keys
# mset key value [key value ...]    Set multiple keys to multiple values

localhost:6379> mset budhi "100" joko "200" achmad "300" idris "400" jamal "500"
localhost:6379> OK
localhost:6379> mget budhi joko achmad idris jamal
1) "100"
2) "200"
3) "300"
4) "400"
5) "500"
localhost:6379>



# Expiration
# Secara default saat kita menyimpan data ke redis, redis akan menyimpannya secara permanen sampai kita menghapusnya
# dalam kasus kita ingin menghapus data di redis secara otomatis dalam waktu tertentu
# Misal kita menyimpan data cache di redis selama 10 menit, setelah 10 menit kita akan query ulang ke database untuk mendapatkan data terbaru
# redis memiliki fitur expiration secara otomatis pada data yang kita simpan di redis

# Operasi Expiration Data String
# Operasi                       Keterangan
# expire key seconds            Set a key's time to live in seconds
# setex key seconds value       Set the value and expiration of a key
# ttl key                       Get the time to live for a key.. (ttl ==> time to live (realtime))

localhost:6379> keys *
1) "achmad"
2) "budhi"
3) "idris"
4) "jamal"
5) "joko"
localhost:6379> expire budhi 10
(integer) 1
localhost:6379> ttl budhi
(integer) 5
localhost:6379> ttl budhi
(integer) 3
localhost:6379> get budhi
(nil)
localhost:6379> setex budhi 12 "budhi oct 868"
OK
localhost:6379> ttl budhi
(integer) 7
localhost:6379> get budhi
"budhi oct 868"
localhost:6379> get budhi
(nil)
localhost:6379>



# Increment & Decrement
# Operasi Increment & Decrement sekilas sangat mudah dilakukan, hanya tinggal mengupdate data yang di redis dengan data baru (data lama ditambah 1)
# Namun jika operasi dilakukan secara paralel dan dalam waktu yang sangat cepat, hal ini bisa memungkinkan race condition
# Untungnya redis memiliki operasi untuk melakukan increment dan decrement

# Operasi                 Keterangan
# incr key                Increment the integer value of a key by one
# decr key                Decrement the integer value of a key by one
# incrby key increment    Increment the integer value of a key by the given amount
# decrby key decrement    Decrement the integer value of a key by the given number

localhost:6379> incr counter
(integer) 1
localhost:6379> incr counter
(integer) 2
localhost:6379> incr counter
(integer) 3
localhost:6379> get counter
"3"
localhost:6379> decr counter
(integer) 2
localhost:6379> decr counter
(integer) 1
localhost:6379> get counter
"1"
localhost:6379>

localhost:6379> incrby counter 5
(integer) 6
localhost:6379> incrby counter 5
(integer) 11
localhost:6379> incrby counter 5
(integer) 16
localhost:6379> decrby counter 5
(integer) 11
localhost:6379> decrby counter 5
(integer) 6
localhost:6379> decrby counter 5
(integer) 1
localhost:6379> get counter
"1"
localhost:6379>



# Flush
# Menghapus data di redis satu-satu menggunakan operasi delete bukanlah hal yang bijak
# Redis memiliki fitur untuk menghapus seluruh data serentak di database redis, yaitu operasi flush

# Operasi       Keterangan
# flushdb       Remove all keys from the current database
# flushall      Remove all keys from all databases

localhost:6379> keys *
1) "jamal"
2) "counter"
3) "achmad"
4) "idris"
5) "joko"
localhost:6379> mget jamal counter achmad idris joko
1) "500"
2) "1"
3) "300"
4) "400"
5) "200"
localhost:6379> select 1
OK
localhost:6379[1]> mset budhi "budhi" oct "oct"
OK
localhost:6379[1]> mget budhi oct
1) "budhi"
2) "oct"
localhost:6379[1]> select 0
OK
localhost:6379> flushdb
OK
localhost:6379> mget jamal counter achmad idris joko
1) (nil)
2) (nil)
3) (nil)
4) (nil)
5) (nil)
localhost:6379> flushall
OK
localhost:6379> select 1
OK
localhost:6379[1]> mget budhi oct
1) (nil)
2) (nil)
localhost:6379[1]>



# Pipeline
# Perintah yang dikirim dari client ke server redis menggunakan Request/Response protocol
# Kadang ada kebutuhan kita mengirim data ke redis dalam jumlah besar, misal ketika ada kasus memindahkan data dari database mysql ke redis
# Jika kita mengirim satu per satu datanya, maka akan butuh waktu lama untuk selesai
# pipeline, dimana kita bisa mengirim beberapa perintah sekaligus dalam satu request
# perlu diketahui, server redis tidak akan membalas tiap perintah yang dikirim via pipeline

pertama kita buat dulu file.. input-file.txt
isi content
set budhi "budhi"
set oct "oct"
set lfc "liverpool football club"
set palestine "palestine"

saat memulai redis-cli kita bisa merujuk file input-file.txt yang kita buat barusan dengan command di bawah
redis-cli -h localhost -p 6379 -n 0 --pipe < input-file.txt

root@71ae6829b569:/hello# nano input-file.txt
root@71ae6829b569:/hello# ls
dump.rdb  input-file.txt  redis.conf
root@71ae6829b569:/hello# cat input-file.txt
set budhi "budhi"
set oct "oct"
set lfc "liverpool football club"
set palestine "palestine"
root@71ae6829b569:/hello# redis-cli -h localhost -p 6379 -n 0 --pipe < input-file.txt
All data transferred. Waiting for the last reply...
Last reply received from server.
errors: 0, replies: 4
root@71ae6829b569:/hello# redis-cli -h localhost -p 6379
localhost:6379> mget budhi oct lfc palestine
1) "budhi"
2) "oct"
3) "liverpool football club"
4) "palestine"
localhost:6379>



Transaction
# Seperti pada database relational, redis juga mendukung transaction
# Proses transaction adalah proses dimana kita mengirimkan beberapa perintah, dan perintah tersebut akan dianggap sukses jika semua perintah sukses, jika gagal maka semua perintah harus dibatalkan

# Operasi                   Keterangan
# multi (begin)             Mark the start of a transaction block
# exec (commit)              Execute all commands issued after MULTI
# discard (rollback)        Discard all commands issued after MULTI

# ketika di exec (commit)
localhost:6379> multi
OK
localhost:6379(TX)> set android "adroid"
QUEUED
localhost:6379(TX)> set ios "ios"
QUEUED
localhost:6379(TX)> set linux "linux"
QUEUED
localhost:6379(TX)> exec
1) OK
2) OK
3) OK
localhost:6379> mget android ios linux
1) "adroid"
2) "ios"
3) "linux"
localhost:6379>

# ketika di discard (rollback)
localhost:6379> multi
OK
localhost:6379(TX)> set satu "satu"
QUEUED
localhost:6379(TX)> set dua "dua"
QUEUED
localhost:6379(TX)> set tiga "tiga"
QUEUED
localhost:6379(TX)> discard
OK
localhost:6379> mget satu dua tiga
1) (nil)
2) (nil)
3) (nil)
localhost:6379>



# Monitor
# mendebug aplikasi saat berkomunikasi dengan redis
# Redis memiliki fitur monitor, yaitu fitur untuk memonitor semua request yang masuk ke redis server
# Dengan fitur ini kita bisa mudah mendebug jika ternyata ada perintah yang salah yang dikirim oleh aplikasi kita ke redis server

#Operasi     Keterangan
#monitor     Listen for all requests received by the server in real time

# redis CLI
localhost:6379> keys *
1) "oct"
2) "android"
3) "lfc"
4) "palestine"
5) "ios"
6) "budhi"
7) "linux"
localhost:6379> mget oct android lfc palestine ios budhi linux
1) "oct"
2) "adroid"
3) "liverpool football club"
4) "palestine"
5) "ios"
6) "budhi"
7) "linux"
localhost:6379> set ayam "ayam"
OK
localhost:6379> get ayam
"ayam"
localhost:6379>

# redis on docker
> docker container exec -it redis-stack /bin/bash
root@71ae6829b569:/hello# redis-cli -h localhost -p 6379

# redis Monitor
localhost:6379> monitor
OK
1698741210.509241 [0 127.0.0.1:60064] "keys" "*"
1698741240.649120 [0 127.0.0.1:60064] "mget" "oct" "android" "lfc" "palestine" "ios" "budhi" "linux"
1698741263.949037 [0 127.0.0.1:60064] "set" "ayam" "ayam"
1698741266.637323 [0 127.0.0.1:60064] "get" "ayam"



# Server Information
# butuh mendapatkan informasi dan statistik redis server
# Seperti jumlah memory yang sudah terpakai, konfigurasi dan lain-lain
# Redis memiliki fitur ini, sehingga kita sangat mudah untuk mendapat informasi server dan memonitor nya

# Operasi               Keterangan
# info                  Get information and statistics about the server
# config get <key>      Get the value of a configuration parameter from redis.conf

# info
localhost:6379> info
# Server
redis_version:7.2.2
# Clients
connected_clients:3
# Memory
used_memory:1341072
# Persistence
loading:0
# ETC

# config get <key>
localhost:6379> config get databases
1) "databases"
2) "16"
localhost:6379> config get bind
1) "bind"
2) "* -::*"
localhost:6379> config get save
1) "save"
2) "3600 1 300 100 60 10000"
localhost:6379>



# Client Connection
# Redis menyimpan semua informasi client di server
# Hal ini memudahkan kita untuk melihat daftar client, dan juga mengecek jika ada anomali, seperti terlalu banyak koneksi client ke redis

# Operasi Keterangan
# client list             Get the list of client connections
# client id               Returns the client ID for the current connection
# client kill ip:port     Kill the connection of a client

# client list
localhost:6379> client list
id=3 addr=127.0.0.1:60088 laddr=127.0.0.1:6379 fd=8 name= age=353 idle=334
id=4 addr=127.0.0.1:60090 laddr=127.0.0.1:6379 fd=9 name= age=249 idle=0
id=5 addr=127.0.0.1:60092 laddr=127.0.0.1:6379 fd=10 name= age=10 idle=10

# client id (mengecek client id berapa command ini aktif)
localhost:6379> client id
(integer) 4

# client kill ip:port
localhost:6379> client kill 127.0.0.1:60092
OK



# Protected Mode
# Secara default, redis server akan mendengarkan request dari semua network interface. Ini sangat berbahaya, karena bisa jadi redis terekspos secara public
# Namun, redis punya second layer untuk pengecekan koneksi, yaitu mode protected, secara default mode protectednya aktif, artinya walaupun redis bisa diakses dari manapun, tapi redis hanya mau menerima request dari 127.0.0.1 (localhost)

# network configuration
# rubah ip default pada file redis.conf, menjadi IPv4 Address yang di dapat dari ipconfig/ ifconfig di laptop atau di komputer
# bind 127.0.0.1 -::1
bind 192.168.0.102

# even if no authentication is configured. (wajib)
protected-mode yes

# restart redis server dengan file redis.conf
root@71ae6829b569:/hello# redis-server redis.conf

# jalankan ulang redis clinet dengan host IPv4 Address yang sudah di set di file redis.conf
root@71ae6829b569:/hello# redis-cli -h 192.168.0.102 -p 6379
192.168.0.102:6379> ping
PONG
192.168.0.102:6379>






