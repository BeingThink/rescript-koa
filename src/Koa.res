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

module App = {
  type t
  @get external env: t => string = "env"
  // TODO: properties
}

@module("koa") @new external koa: koaOptions => App.t = "default"
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

type context = {
  mutable body: string,
  request: req,
  response: res,
}
// application settings


// @send external accepts: (req, [string | array<string>]) => keyValue = "accepts"

type middleware = (context, (. unit) => Js.Promise.t<unit>) => Js.Promise.t<unit>
// type middleware = () =>

@send external use: (App.t, middleware) => unit = "use"

@send external callback: (App.t, int) => NodeJs.Http.Server.t = "callback"

@send external listen: (App.t, int, option<Js.Exn.t> => unit) => NodeJs.Http.Server.t = "listen"
