# Rescript-Koa
![NPM](https://img.shields.io/npm/l/@futurert/rescript-koa) ![npm](https://img.shields.io/npm/v/@futurert/rescript-koa)
## example

### install

```shell
npm install @futurert/rescript-koa --save-dev
```

### bsconfig

You should add "@futurert/rescript-koa" in bs-dependencies, just like this:
```json
{
  "name": "rescript-project-template",
  "version": "0.0.1",
  "sources": {
    "dir" : "src",
    "subdirs" : true
  },
  "package-specs": {
    "module": "commonjs",
    "in-source": true
  },
  "bs-dependencies": [
    "@futurert/rescript-koa",
  ],
  "warnings": {
    "error" : "+101"
  }
}
```

### Get First Koa App

Koa is great for its middleware design, we just can use sync function as `app->use()` function params, just like here:

```rescript
open Koa

// init koa app
let app = koa()

// Just for instance.
app.env = "development"

// you can use middleware like this
app->use(ctx => ctx.body = "hello world")

// ok, just start an server instance
let _ = app->listen(8080, _ => {Js.Console.log("server is start success!")})
```

But, fortunately we now can use async function in `app->use()`, just like this

```rescript
open Koa
open Promise

// init koa app
let app = Koa.koa()

// Just for instance.
app.env = "development"

// you can use middleware like this
app->use((context, next) => {
  Js.log("1")
  Js.log(context.request.ip)
  context.body = "hello"
  next()->then(_ => {
    Js.log("2")
    resolve()
  })->ignore;
})

app->use((_, next) => {
  Js.log("3")
  next()->then(_ => {
    Js.log("4")
    resolve()
  })->ignore;
})

let _ = app->listen(8080, _ => {Js.Console.log("server is start success!")})
```

There is a [full example](./examples//index.res) to help you start, Let's try it!
