- generate each deployment for all reverse proxy providers
  - adjust script that will generate the deployment for each reverse proxy provider
  - create nginx service

- change the ./make-short-sha-root-domain to so that it'll stop all services if another proxy provider is used, and restart the services with the new proxy provider

- Log time to live for each deployment and its domain and subdomains
