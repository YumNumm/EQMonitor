Warming Up...
Serialize
===
One
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|---------|--------------|
Total | 18047 μs (18.047ms) | 3825 μs (3.825ms) | 3306 μs (3.306ms)
Average | 1.8047 μs (0.0018047ms) | 0.3825 μs (0.00038250000000000003ms) | 0.3306 μs (0.0003306ms)
Longest | 50 μs (0.05ms) | 310 μs (0.31ms) | 788 μs (0.788ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 1 bytes | 1 bytes | 1 bytes
Fastest | msgpack_dart

Five Hundred Thousand
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|---------|--------------|
Total | 3554 μs (3.554ms) | 8758 μs (8.758ms) | 5710 μs (5.71ms)
Average | 0.3554 μs (0.0003554ms) | 0.8758 μs (0.0008758ms) | 0.571 μs (0.000571ms)
Longest | 336 μs (0.336ms) | 1306 μs (1.306ms) | 1503 μs (1.503ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 6 bytes | 5 bytes | 5 bytes
Fastest | JSON

List of Small Integers
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|---------|--------------|
Total | 20335 μs (20.335ms) | 4704 μs (4.704ms) | 3072 μs (3.072ms)
Average | 2.0335 μs (0.0020335ms) | 0.4704 μs (0.0004704ms) | 0.3072 μs (0.0003072ms)
Longest | 1536 μs (1.536ms) | 125 μs (0.125ms) | 37 μs (0.037ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 7 bytes | 4 bytes | 4 bytes
Fastest | msgpack_dart

Simple Map
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|---------|--------------|
Total | 7402 μs (7.402ms) | 8195 μs (8.195ms) | 5981 μs (5.981ms)
Average | 0.7402 μs (0.0007402ms) | 0.8195 μs (0.0008195ms) | 0.5981 μs (0.0005981ms)
Longest | 435 μs (0.435ms) | 308 μs (0.308ms) | 40 μs (0.04ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 17 bytes | 13 bytes | 13 bytes
Fastest | msgpack_dart

5.02817472928
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|---------|--------------|
Total | 2238 μs (2.238ms) | 4321 μs (4.321ms) | 2861 μs (2.861ms)
Average | 0.2238 μs (0.0002238ms) | 0.4321 μs (0.0004321ms) | 0.2861 μs (0.0002861ms)
Longest | 55 μs (0.055ms) | 216 μs (0.216ms) | 49 μs (0.049ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 13 bytes | 9 bytes | 9 bytes
Fastest | JSON

Multiple Type Map
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|---------|--------------|
Total | 13455 μs (13.455ms) | 15366 μs (15.366ms) | 15436 μs (15.436ms)
Average | 1.3455 μs (0.0013455ms) | 1.5366 μs (0.0015366ms) | 1.5436 μs (0.0015436ms)
Longest | 133 μs (0.133ms) | 150 μs (0.15ms) | 117 μs (0.117ms)
Shortest | 1 μs (0.001ms) | 1 μs (0.001ms) | 1 μs (0.001ms)
Size | 76 bytes | 61 bytes | 61 bytes
Fastest | JSON

Medium Data
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|---------|--------------|
Total | 120183 μs (120.183ms) | 52318 μs (52.318ms) | 49790 μs (49.79ms)
Average | 12.0183 μs (0.012018299999999999ms) | 5.2318 μs (0.0052318ms) | 4.979 μs (0.004979ms)
Longest | 165 μs (0.165ms) | 223 μs (0.223ms) | 187 μs (0.187ms)
Shortest | 11 μs (0.011ms) | 4 μs (0.004ms) | 4 μs (0.004ms)
Size | 902 bytes | 587 bytes | 587 bytes
Fastest | msgpack_dart

Deserialize
===
One
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 2646 μs (2.646ms) | 2114 μs (2.114ms) |2225 μs (2.225ms)
Average | 0.2646 μs (0.0002646ms) | 0.2114 μs (0.00021140000000000002ms) |0.2225 μs (0.00022250000000000001ms)
Longest | 51 μs (0.051ms) | 53 μs (0.053ms) |18 μs (0.018ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | MsgPack2

Five Hundred Thousand
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 2933 μs (2.933ms) | 2514 μs (2.514ms) |1941 μs (1.941ms)
Average | 0.2933 μs (0.00029330000000000003ms) | 0.2514 μs (0.00025140000000000004ms) |0.1941 μs (0.0001941ms)
Longest | 71 μs (0.071ms) | 25 μs (0.025ms) |14 μs (0.014ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

List of Small Integers
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 3297 μs (3.297ms) | 2279 μs (2.279ms) |2162 μs (2.162ms)
Average | 0.3297 μs (0.0003297ms) | 0.2279 μs (0.00022789999999999998ms) |0.2162 μs (0.0002162ms)
Longest | 149 μs (0.149ms) | 44 μs (0.044ms) |46 μs (0.046ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Simple Map
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 4120 μs (4.12ms) | 5848 μs (5.848ms) |4725 μs (4.725ms)
Average | 0.412 μs (0.000412ms) | 0.5848 μs (0.0005848ms) |0.4725 μs (0.0004725ms)
Longest | 61 μs (0.061ms) | 135 μs (0.135ms) |66 μs (0.066ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | JSON

5.02817472928
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 4727 μs (4.727ms) | 2181 μs (2.181ms) |2079 μs (2.079ms)
Average | 0.4727 μs (0.0004727ms) | 0.2181 μs (0.0002181ms) |0.2079 μs (0.0002079ms)
Longest | 142 μs (0.142ms) | 21 μs (0.021ms) |43 μs (0.043ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Multiple Type Map
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 9284 μs (9.284ms) | 14321 μs (14.321ms) |8729 μs (8.729ms)
Average | 0.9284 μs (0.0009284ms) | 1.4321 μs (0.0014321ms) |0.8729 μs (0.0008729ms)
Longest | 137 μs (0.137ms) | 143 μs (0.143ms) |156 μs (0.156ms)
Shortest | 0 μs (0.0ms) | 1 μs (0.001ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Medium Data
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 54849 μs (54.849ms) | 39660 μs (39.66ms) |23987 μs (23.987ms)
Average | 5.4849 μs (0.0054849ms) | 3.966 μs (0.003966ms) |2.3987 μs (0.0023986999999999997ms)
Longest | 184 μs (0.184ms) | 129 μs (0.129ms) |134 μs (0.134ms)
Shortest | 4 μs (0.004ms) | 3 μs (0.003ms) |1 μs (0.001ms)
Fastest | msgpack_dart

