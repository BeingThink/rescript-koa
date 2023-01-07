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
