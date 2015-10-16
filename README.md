# PubsubStress

## Broadcast testing

To run measurements, start the server with number of subscribers:

    ☁🚀 ☁ › SUBSCRIBERS=700 PORT=4000 MIX_ENV=prod mix phoenix.server

Then use `wrk` to push traffic:

    ☁🚀 ☁ › wrk -T 30s "http://localhost:4000/?format=json"


## WS Client testing

To run measurements, start the server with number of subscribers,
then ensure your phoenix server is running on 4002 and start the test:

    ☁🚀 ☁ › WS_CLIENTS=10000 SUBSCRIBERS=0 PORT=4000 REMOTE_URL="ws://127.0.0.1:4002/socket/websocket" MIX_ENV=prod mix phoenix.server


## v0.14.0

700 subscribers
```console
chris@chris-mbp ~/Workspace/projects/phoenix [2754f7f]
☁🚀 ☁ › wrk -T 30s "http://localhost:4000/?format=json"
Running 10s test @ http://localhost:4000/?format=json
  2 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    61.51ms    4.95ms  77.59ms   75.68%
    Req/Sec    81.47     12.64   119.00     87.84%
  1633 requests in 10.01s, 436.91KB read
Requests/sec:    163.19
Transfer/sec:     43.66KB
```

7000 subscribers
```console
chris@chris-mbp ~/Workspace/projects/phoenix [2754f7f]
☁🚀 ☁ › wrk -T 30s "http://localhost:4000/?format=json"
Running 10s test @ http://localhost:4000/?format=json
  2 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   554.17ms   17.68ms 563.31ms   84.35%
    Req/Sec     9.41     14.00    31.00     68.70%
  190 requests in 10.01s, 50.84KB read
Requests/sec:     18.98
Transfer/sec:      5.08KB
```

## cm-pg2-perf 6aefcbddcb4828390af48a06d3e4fb8c81f22736

700 susbscribers
```console
chris@chris-mbp ~/Workspace/projects/phoenix [cm-pg2-perf]
☁🚀 ☁ › wrk -T 30s "http://localhost:4000/?format=json"
Running 10s test @ http://localhost:4000/?format=json
  2 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.65ms    0.98ms  17.39ms   84.22%
    Req/Sec     3.28k   722.68     5.55k    71.85%
  62221 requests in 10.00s, 16.26MB read
Requests/sec:   6222.01
Transfer/sec:      1.63MB
```


7000 susbscribers
```console
chris@chris-mbp ~/Workspace/projects/phoenix [cm-pg2-perf]
☁🚀 ☁ › wrk -T 30s "http://localhost:4000/?format=json"
Running 10s test @ http://localhost:4000/?format=json
  2 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.51ms  814.06us  15.53ms   80.80%
    Req/Sec     3.57k   609.98     5.89k    70.39%
  66789 requests in 10.00s, 17.45MB read
Requests/sec:   6679.19
Transfer/sec:      1.75MB
```


## cm-pg2-perf 672827c1adb68b894f7b434fb1bfa2d161ac3952

700 subscribers
```console
☁🚀 ☁ › wrk -T 30s "http://localhost:4000/?format=json"
Running 10s test @ http://localhost:4000/?format=json
  2 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.43ms  634.19us   6.18ms   74.99%
    Req/Sec     3.73k   651.35     6.00k    70.34%
  70636 requests in 10.00s, 18.45MB read
Requests/sec:   7063.66
Transfer/sec:      1.85MB
```


7000 subscribers
```console
☁🚀 ☁ › wrk -T 30s "http://localhost:4000/?format=json"
Running 10s test @ http://localhost:4000/?format=json
  2 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.39ms  638.07us   7.92ms   77.65%
    Req/Sec     3.82k   634.80     6.00k    71.35%
  72089 requests in 10.00s, 18.83MB read
Requests/sec:   7208.97
Transfer/sec:      1.88MB
```
