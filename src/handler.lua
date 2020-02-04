
local FORBIDDEN = 403
local MaAuthHandler = {}

MaAuthHandler.PRIORITY = 989
MaAuthHandler.VERSION = "0.0.1"


function MaAuthHandler:access(conf)
  local ssl_client_thumbprint = ngx.var.ssl_client_fingerprint

  if not ssl_client_thumbprint then
    return kong.response.exit(FORBIDDEN, { message = "No SSL Certificate sent" })
  end
  local num_of_thumbprints = #conf.thumbprints
  if conf.thumbprints and num_of_thumbprints > 0 then
    for i = 1, num_of_thumbprints do
        local current_thumbprint = conf.thumbprints[i]
        kong.log.debug("compare ssl_client_thumbprint: ", ssl_client_thumbprint, " to current_thumbprint: ", current_thumbprint)
        if ssl_client_thumbprint == current_thumbprint then
          return
        end
    end
  end
  return kong.response.exit(FORBIDDEN, { message = "Your Thumbprint is not allowed" })
end

return MaAuthHandler