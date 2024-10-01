# Unique Spin Apps

This is a simple [Spin App](https://github.com/fermyon/spin) that responds to incoming HTTP requests. There are 5000 unique tags available for this artifact (`1`..`5000`). 

Every individual Spin App returns it's unique identifier as a HTTP response header (`x-spin-app-id`) and a response body containing the unique app identifier (`Hello, this is Spin App 2!`). 

Using unique OCI artifacts, you can ensure Kubernetes (e.g. using [SpinKube](https://spinkube.dev)) has to pull a particular artifact per Spin App deployment.

You can also run those apps on your local machine using the `spin` CLI:

```bash
spin up --from thorstenhans/unique-spin-app:3032

Serving http://127.0.0.1:3000
Available Routes:
  app: http://127.0.0.1:3000 (wildcard)
```

From within a new terminal instance you can sent an HTTP request to the Spin App using `curl`:

```bash
curl -iX GET localhost:3000

HTTP/1.1 200 OK
x-spin-app-id: 3032
content-type: text/plain
transfer-encoding: chunked
date: Tue, 01 Oct 2024 10:46:43 GMT

Hello, this is Spin App 3032!%
```