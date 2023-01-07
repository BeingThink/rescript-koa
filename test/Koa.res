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


module Ctx = {
  type req
  type res
  type context = {
    mutable body: string,
    request: req,
    response: res,
  }
}

module App = {
  include Ctx
  type t
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
}

@module("koa") @new external koa: koaOptions => App.t = "default"

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

// @send external callback: (App.t, int) => NodeJs.Http.Server.t = "callback"
