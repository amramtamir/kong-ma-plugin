local typedefs = require "kong.db.schema.typedefs"


return {
  name = "ma-auth",
  fields = {
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { thumbprints = { type = "array", elements = { type = "string" }, }, },
        },
      },
    },
  },
}