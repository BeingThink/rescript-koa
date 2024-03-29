open NodeJs
type koaOptions

@obj
external koaOptions: (
  ~env: string=?,
  ~keys: array<string>=?,
  ~proxy: bool=?,
  ~subdomainOffset: int=?,
  ~proxyIpHeader: string=?,
  ~maxIpsCount: int=?,
  unit,
) => koaOptions = ""

module Req = {
  type req
}

module Res = {
  type res
}

module Ctx = {
  include Req
  include Res

  type cookie

  type context = {
    mutable body: string,
    store: Js.Dict.t<string>,
    req: Http.ClientRequest.t,
    res: Http.ServerResponse.t,
    request: req,
    response: res,
    cookies: cookie,
  }

  type getOption
  type setOption
  @obj
  external getOption: (~signed: bool=?, unit) => getOption = ""
  @obj
  external setOption: (
    ~maxAge: int=?,
    ~expires: Js.Date.t=?,
    ~path: string=?,
    ~domain: string=?,
    ~secure: bool=?,
    ~httpOnly: bool=?,
    ~sameSite: bool=?,
    ~signed: bool=?,
    ~overwrite: bool=?,
    unit,
  ) => setOption = ""
  @send external getCookies: (cookie, string, getOption) => unit = "get"
  @send external setCookies: (cookie, string, string, setOption) => unit = "set"

  @get external getStore: context => option<Js.Dict.t<string>> = "store"
  @set external setStore: (context, Js.Dict.t<string>) => unit = "store"
}

module App = {
  include Ctx
  type t
  type error
  type middleware = (context, @uncurry (unit => Js.Promise.t<unit>)) => Js.Promise.t<unit>
  @set external keys: (t, array<string>) => unit = "keys"
  @set external proxy: (t, bool) => unit = "proxy"
  @set external subdomainOffset: (t, int) => unit = "subdomainOffset"
  @set external proxyIpHeader: (t, string) => unit = "proxyIpHeader"
  @set external env: (t, string) => unit = "env"
  @set external maxIpsCount: (t, int) => int = "maxIpsCount"
  @send
  external listen: (t, ~port: int=?, ~host: string=?, ~callback: unit => unit=?) => unit = "listen"
  @send external callback: t => Http.Server.t = "callback"
  @send external use: (t, middleware) => unit = "use"
  @send external on: (t, string, (error, context) => unit) => unit = "on"
  @send external emit: (t, string, error, context) => unit = "emit"

  @get external getContext: t => context = "context"

  // TODO: app.context
  // @set external context: (t, string, string) => unit = "context"
}

@module("koa") @new external koa: koaOptions => App.t = "default"

module Special = {
  @get external getAppInstance: Ctx.context => App.t = "app"
}
