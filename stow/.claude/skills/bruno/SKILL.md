---
name: bruno
description: "Create and manage Bruno API collections using the OpenCollection JSON spec. Use when: (1) Creating Bruno collections from API descriptions or OpenAPI specs, (2) Scaffolding HTTP, GraphQL, gRPC, or WebSocket requests, (3) Managing Bruno environments with variables and secrets, (4) Converting between Bruno and other API client formats, (5) Any task mentioning Bruno, OpenCollection, or .bru files."
---

# Bruno Collection Builder

Generate valid Bruno/OpenCollection JSON collections, requests, and environments.

## Schema Reference

The full OpenCollection JSON Schema is at `references/opencollection-schema.json`. Read it when you need to verify field names, types, or constraints for any definition.

## Quick Start: Minimal Collection

```json
{
  "opencollection": "1.0.0",
  "info": { "name": "My API" },
  "items": []
}
```

## Creating Requests

Each request lives in `items[]`. Identify by `info.type`:

### HTTP Request

```json
{
  "info": { "name": "Get Users", "type": "http" },
  "http": {
    "method": "GET",
    "url": "{{baseUrl}}/users",
    "headers": [{ "name": "Accept", "value": "application/json" }],
    "params": [{ "name": "page", "value": "1", "type": "query" }]
  },
  "runtime": { "auth": "inherit" }
}
```

Body types: `json`, `text`, `xml`, `sparql` (raw), `form-urlencoded`, `multipart-form`, `file`.

### GraphQL Request

```json
{
  "info": { "name": "Get User", "type": "graphql" },
  "graphql": {
    "method": "POST",
    "url": "{{baseUrl}}/graphql",
    "body": {
      "query": "query GetUser($id: ID!) { user(id: $id) { name email } }",
      "variables": "{\"id\": \"1\"}"
    }
  }
}
```

### gRPC Request

```json
{
  "info": { "name": "Get User", "type": "grpc" },
  "grpc": {
    "url": "localhost:50051",
    "method": "user.UserService/GetUser",
    "methodType": "unary",
    "message": "{\"id\": \"1\"}"
  }
}
```

`methodType`: `unary`, `client-streaming`, `server-streaming`, `bidi-streaming`.

### WebSocket Request

```json
{
  "info": { "name": "Live Feed", "type": "websocket" },
  "websocket": {
    "url": "wss://{{baseUrl}}/ws",
    "message": { "type": "json", "data": "{\"subscribe\": \"feed\"}" }
  }
}
```

Message types: `text`, `json`, `xml`, `binary`.

## Folders

Nest items in folders. Folders can have their own request defaults (headers, auth, variables, scripts).

```json
{
  "info": { "name": "Admin", "type": "folder" },
  "items": [ /* requests or nested folders */ ],
  "request": {
    "auth": { "type": "bearer", "token": "{{adminToken}}" }
  }
}
```

## Authentication

Set `auth` at collection, folder, or request level. Types:

| Type | Key fields |
|------|-----------|
| `basic` | `username`, `password` |
| `bearer` | `token` |
| `apikey` | `key`, `value`, `placement` (header/query) |
| `oauth2` | `flow` + flow-specific fields |
| `awsv4` | `accessKeyId`, `secretAccessKey`, `region`, `service` |
| `digest` | `username`, `password` |
| `ntlm` | `username`, `password`, `domain` |
| `wsse` | `username`, `password` |
| `"inherit"` | Inherit from parent |

OAuth2 flows: `client_credentials`, `authorization_code`, `resource_owner_password_credentials`, `implicit`.

## Environments

```json
{
  "config": {
    "environments": [
      {
        "name": "Development",
        "variables": [
          { "name": "baseUrl", "value": "http://localhost:3000" },
          { "secret": true, "name": "apiKey" }
        ]
      },
      {
        "name": "Production",
        "extends": "Development",
        "variables": [
          { "name": "baseUrl", "value": "https://api.example.com" }
        ]
      }
    ]
  }
}
```

Secret variables (`"secret": true`) have no value in the collection file; they are entered at runtime.

Environments support `dotEnvFilePath` to load from `.env` files and `clientCertificates` for mTLS.

## Scripts & Assertions

Lifecycle scripts (`before-request`, `after-response`, `tests`, `hooks`):

```json
"runtime": {
  "scripts": [
    { "type": "before-request", "code": "bru.setHeader('X-Request-Id', uuid());" },
    { "type": "after-response", "code": "bru.setVar('token', res.body.token);" }
  ],
  "assertions": [
    { "expression": "res.status", "operator": "eq", "value": "200" },
    { "expression": "res.body.data", "operator": "isJson" }
  ]
}
```

## Variants

Bodies, messages, GraphQL queries, and variables support variants (array of `{ title, selected, body/message/value }`). Use for testing multiple payloads on a single request.

## Request Settings

Per-request or collection-level via `settings`:

```json
"settings": {
  "http": { "encodeUrl": true, "timeout": 5000, "followRedirects": true, "maxRedirects": 10 }
}
```

Values can be `"inherit"` to use parent settings.
