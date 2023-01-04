open Koa
// init koa app
let app = Koa.koa(koaOptions())

// Just for instance.
// app.env = "development"

// you can use middleware like this
app->use(async (context, next) => {
  Js.log("1")
  Js.log(context.request.ip)
  context.body = "hello"
  await next(.);
  Js.log("2")
})

app->use(async (_, next) => {
  Js.log("3")
  await next(.)
  Js.log("4")
})

Js.log(app->App.env) 

let _ = app->listen(8080, _ => {Js.Console.log("server is start success!")})
