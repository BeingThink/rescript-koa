open Koa
open Promise

// init koa app
let app = Koa.koa()

// Just for instance.
app.env = "development"

// you can use middleware like this
app->use((context, next) => {
  Js.log("1")
  next(.)->then(_ => {
    Js.log("2")
    resolve()
  })->ignore;
})

app->use((context, next) => {
  Js.log("3")
  next(.)->then(_ => {
    Js.log("4")
    resolve()
  })->ignore;
})


// app->use((ctx, next) => {
//   Js.Console.log("haha")
//   next()->then(() => {
//     Js.Console.log("11111")
//   })
// })
// let myPromise = Js.Promise.make((~resolve, ~reject) => resolve(. 2))

// let _ = myPromise->Js.Promise.then_(value => {
//   Js.log(value)
//   Js.Promise.resolve(value + 2)
// }, _)

// ok, just start an server instance
let _ = app->listen(8080, _ => {Js.Console.log("server is start success!")})
