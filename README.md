# Rescript-Koa

## example

### install

```shell
npm install @futurert/rescript-koa@0.0.1-alpha.13 --save-dev
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