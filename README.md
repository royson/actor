# actor

an actor system in ocaml

# TODO

Architecture: study KV store and PUB/SUB

How to express arbitrary DGA? How to express loop?

Need to separate the shuffling from Context as a module/function

Interface to Irmin or HDFS to provide persistent storage

Imply apply function then test

Test delay-bounded and error-bounded barrier

Need to read "transferring files" in ZMQ doc to remove high water marks in the code

Fail to compile using OCaml 4.02.3 (only on my Mac), 4.02.2 works fine.

# ISSUE

Stack overflow in reduce function (caused by Hashtbl: when there are over 30000 values with the same key)
