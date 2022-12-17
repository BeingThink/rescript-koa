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
// simple object that just has key value
type keyValue
type connection

type req = {
  mutable header: keyValue,
  mutable headers: keyValue,
  mutable url: string,
  mutable origin: string,
  mutable href: string,
  mutable method: string,
  mutable path: string,
  mutable query: keyValue,
  mutable querystring: string,
  mutable search: string,
  mutable host: string,
  mutable hostname: string,
  mutable fresh: bool,
  mutable stale: bool,
  mutable idempotent: bool,
  mutable socket: connection, // TODO: type
  mutable charset: string,
  mutable length: int,
  mutable protocol: string,
  mutable secure: string,
  ips: array<string>,
  mutable ip: string,
  subdomains: array<string>,
  mutable accept: keyValue,
}


type res = {
  header: keyValue,
  headers: keyValue,
  mutable status: int,
  mutable message: string,
  mutable length: int,
  mutable headerSent: bool,
  @as("type") mutable type_: string,
  mutable lastModified: string,
  mutable etag: string,
  writable: bool,
}

// @send external accepts: (req, [string | array<string>]) => keyValue = "accepts"

type context = {
  mutable body: string,
  request: req,
  response: res,
}

type middleware = (context,  (. unit) => Js.Promise.t<unit>) => Js.Promise.t<unit>
// type middleware = () =>


@send external use: (app, middleware) => unit = "use"

@send external callback: (app, int) => server = "callback"

@send external listen: (app, int, option<Js.Exn.t> => unit) => server = "listen"

