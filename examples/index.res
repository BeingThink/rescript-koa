open Koa

// init koa app
let app = koa()

// Just for instance.
app.env = "development"

// you can use middleware like this
app->use(ctx => ctx.body = "hello world")

// ok, just start an server instance
let _ = app->listen(8080, _ => {Js.Console.log("server is start success!")})
