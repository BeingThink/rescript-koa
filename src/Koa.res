// application settings
type app = {
  // defaulting to the NODE_ENV or "development"
  mutable env: string,
  // array of signed cookie keys
  mutable keys: array<string>,
  // when true proxy header fields will be trusted
  mutable proxy: bool,
  // offset of .subdomains to ignore, default to 2
  mutable subdomainOffset: int,
  // proxy ip header, default to X-Forwarded-For
  mutable proxyIpHeader: string,
  // max ips read from proxy ip header, default to 0 (means infinity)
  mutable maxIpsCount: int,
}

@module("koa") @new external koa: unit => app = "default"

// base on node.js http-server
type server

type context = {mutable body: string}

type next<'a> = ('a) => Js.Promise.t<'a>

type middleware = (context, (. unit) => Js.Promise.t<unit>) => unit

@send external use: (app, middleware) => unit = "use"

@send external callback: (app, int) => server = "callback"

@send external listen: (app, int, option<Js.Exn.t> => unit) => server = "listen"
