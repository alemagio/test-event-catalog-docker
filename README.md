# event-catalog-pnpm

## Introduction

`event-catalog-pnpm` is a way to easily work with [Event Catalog](https://www.eventcatalog.dev/) together with [pnpm](https://pnpm.io/) and a monorepo.

For more info see [this](https://ducktors.hashnode.dev/create-an-eventcatalog-instance-in-a-pnpm-monorepo) blog post.

## Get started

Assuming you already have a structure for your `event-catalog` similar to this:

```
/domains
/events
/public
/services
eventcatalog.config.js
```

You need to create a `docker-compose` file or add the following service to your existing one:

```
services:
  event_catalog:
    image: event-catalog-pnpm:latest
    ports:
      - 3000:3000
    container_name: event_catalog_app
    volumes:
      - ./domains/:/home/node/domains/
      - ./events/:/home/node/events/
      - ./public/:/home/node/public/
      - ./services/:/home/node/services/
      - ./eventcatalog.config.js:/home/node/eventcatalog.config.js
```

Navigate to http://localhost:3000 and see your Event Catalog up and running

Now you should have a running service with event-catalog. Changes to your event-catalog files will be reflected and you should see them after reloading the browser page.
