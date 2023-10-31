# menjalanakan redis server. dengan configuration default dari redis nya sendiri
redis-server
                _._
           _.-``__ ''-._
      _.-``    `.  `_.  ''-._           Redis 7.2.2 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 73
  `-._    `-._  `-./  _.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |           https://redis.io
  `-._    `-._`-.__.-'_.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |
  `-._    `-._`-.__.-'_.-'    _.-'
      `-._    `-.__.-'    _.-'
          `-._        _.-'
              `-.__.-'

# menjalanakan redis server. dengan configuration costum
# , syaratnya kita perlu membuat file redis.conf isinya adalah https://github.com/redis/redis/blob/7.0/redis.conf copy semua paste di redis.conf.
# jika menggunakan docker maka file dari redis.conf di add atau di copy ke destination supya bisa di terapkan
redis-server redis.conf
83:C 31 Oct 2023 05:17:46.773 * oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
83:C 31 Oct 2023 05:17:46.773 * Redis version=7.2.2, bits=64, commit=00000000, modified=0, pid=83, just started
83:C 31 Oct 2023 05:17:46.773 * Configuration loaded
83:M 31 Oct 2023 05:17:46.773 * monotonic clock: POSIX clock_gettime
                _._
           _.-``__ ''-._
      _.-``    `.  `_.  ''-._           Redis 7.2.2 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 83
  `-._    `-._  `-./  _.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |           https://redis.io
  `-._    `-._`-.__.-'_.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |
  `-._    `-._`-.__.-'_.-'    _.-'
      `-._    `-.__.-'    _.-'
          `-._        _.-'
              `-.__.-'

# jika kita sudah membuat file redis.conf jika kita tidak panggil maka akan muncul peringatan
redis-server
84:C 31 Oct 2023 05:21:51.723 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
                _._
           _.-``__ ''-._
      _.-``    `.  `_.  ''-._           Redis 7.2.2 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 84
  `-._    `-._  `-./  _.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |           https://redis.io
  `-._    `-._`-.__.-'_.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |
  `-._    `-._`-.__.-'_.-'    _.-'
      `-._    `-.__.-'    _.-'
          `-._        _.-'
              `-.__.-'




# menjalankan redis CLI (Command Line Interface)
redis-cli -h localhost -p 6379
# berhasil masuk ke redis CLI
localhost:6379>