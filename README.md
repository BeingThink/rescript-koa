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
open KoaJs.Koa
// init koa app
let app = koa(koaOptions())

// Just for instance.
// app.env = "development"

// you can use middleware like this
app->App.use(async (context, next) => {
  Js.log("1")
  context.body = "hello"
  await next();
  Js.log("2")
})

app->App.use(async (_, next) => {
  Js.log("3")
  await next()
  Js.log("4")
})

app->App.env("哈哈哈")

app->App.listen(~port = 3000, ~host= "127.0.0.1", ~callback= _ => Js.log("哈哈哈"))
// Js.log(app->App.env) 

// app.listen()
app->App.on("error", (err, ctx) => Js.log(err))
```

There is a [full example](./examples//index.res) to help you start, Let's try it!
