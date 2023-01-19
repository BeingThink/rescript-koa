open Koa
// init koa app
let app = koa(koaOptions())

// Just for instance.
// app.env = "development"

// you can use middleware like this
app->App.use(async (context, next) => {
  context.cookies->Ctx.getCookies("name", Ctx.getOption(~signed=true, ()))
  Js.log(Js.Dict.get(context.store, "name"))
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



let context = App.getContext(app)

let store = App.getStore(context)

// store = Belt.Map.fromArray([("name", "pjw")])

// Belt.Map.set()
App.setStore(context, Js.Dict.fromArray([("name", "pjw")]))

switch store {
| None => Js.log("哈哈哈")
| Some(value) => Js.Dict.set(value, "name", "pjw")
}

// app.listen()
app->App.on("error", (err, ctx) => Js.log(err))

app->App.listen(~port = 3000, ~host= "127.0.0.1", ~callback= _ => Js.log("哈哈哈"))
Js.log(app->App.env) 
