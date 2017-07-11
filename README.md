# elixir_fizzbuzz

### About 

FizzBuzz implemented as a REST endpoint using [Plug](https://github.com/elixir-lang/plug)

### Prerequisites

* Elixir 1.4.4
* Docker - if you would like to bake docker images of releases.

### Building and running a docker release

```
mix docker.build && mix docker.release && docker run -it --rm -p4000:4000 binarytemple/fizzbuzz:release foreground
```
