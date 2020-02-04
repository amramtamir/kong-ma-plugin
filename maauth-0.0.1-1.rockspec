package = "maauth"

version = "0.0.1-1"

-- The version '0.0.1' is the source code version, the trailing '1' is the version of this rockspec.
-- whenever the source version changes, the rockspec should be reset to 1. The rockspec version is only
-- updated (incremented) when this file changes, but the source remains the same.

supported_platforms = {"linux", "macosx"}

source = {
  url = "https://github.com/amramtamir/kong-ma-plugin",
  tag = "0.1.1"
}

description = {
  summary = "A Kong plugin that allows for verifying the thumbprint for mutual authentication.",
  license = "MIT"
}

dependencies = {
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.maauth.handler"] = "src/handler.lua",
    ["kong.plugins.maauth.schema"] = "src/schema.lua"
  }
}