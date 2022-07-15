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

app->use((context, next) => {
  Js.log("3")
  next()->then(_ => {
    Js.log("4")
    resolve()
  })->ignore;
})

let _ = app->listen(8080, _ => {Js.Console.log("server is start success!")})
