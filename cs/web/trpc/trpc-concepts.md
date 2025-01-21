# TRPC notes
https://trpc.io/docs/concepts

## RPC
Stands for Remote Procedure Call. Instead of calling an URL and gettting a response, with RPC you call a function and get a response.

```js
// HTTP/REST
const res = await fetch('/api/users/1');
const user = await res.json();

// RPC
const user = await api.users.getById({ id: 1 });
```

tRPC (TypeScript Remote Procedure Call) is one implementation of RPC, designed for TypeScript monorepos. It has its own flavor, but is RPC at its heart.
