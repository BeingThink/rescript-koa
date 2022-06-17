open Koa
let app = koa()


// Just for instance.
app.env = "development"


app->use(ctx => ctx.body = "hello world")

let _ = app->listen(8080, _ => {Js.Console.log("server is start success!")})
