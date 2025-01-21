Almost,  I have 2 lables now though

```
frontend-4d0d1d4b:
    image: registry.gitlab.com/benjaminshawkiorg/pintandpillage-containerized/main/frontend:4d0d1d4b
    build:
      context: .
      dockerfile: PintAndPillageFrontend/Dockerfile
    labels:
      - "traefik.http.routers.frontend-4d0d1d4b.rule=Host(`4d0d1d4b.bluejund.com`) || Host(`bluejund.com`)"
      - "traefik.http.routers.frontend-4d0d1d4b.rule=Host(`4d0d1d4b.bluejund.com`)"
      - "traefik.http.services.frontend-4d0d1d4b.loadbalancer.server.port=80"
    environment:
      VUE_APP_BACKEND_URL:
      VUE_APP_FRONTEND_URL: http://4d0d1d4b.bluejund.com
```
