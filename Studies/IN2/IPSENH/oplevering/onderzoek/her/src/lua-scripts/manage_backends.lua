local backends = ngx.shared.backends
backends:set("short_sha1", "backend_short_sha1")
backends:set("short_sha2", "backend_short_sha2")
-- Add more backends as needed
