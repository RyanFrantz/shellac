# shellac
A REPL for Varnish's ``varnishlog`` command.

## Installation

``shellac`` is available on [rubygems.org](https://rubygems.org).

Install the gem via the ``gem`` command:

``gem install shellac``

## Running `shellac`

Simply call ``shellac`` top start the REPL:

shellac@varnish01 ~] $ shellac

```
Default request: http://localhost/
HTTP Port (varnishclient.request.port): 80
HTTP Request Path (varnishclient.request.path): /
HTTP Host Header (varnishclient.request.host): www.example.com

You may want to to modify this before calling @varnishclient.make_request!

shellac>
```

**NOTE**: ``shellac`` kindly informs you that it has set some defaults for a
number of parameters (identified in parentheses). Those defaults most likely
won't do anyone any good, so let's change them.

### ``varnishclient``

``varnishclient`` is an instance of a [VarnishClient](/tree/master/lib/varnishclient)
object. Its job is to define the HTTP request that will be sent to Varnish as well
as capture its response.

#### ``varnishclient.request``

As the above preamble recommends, the default request should be modified to make
a valid request through Varnish.

``varnishclient.request.host`` defines the Host header for the request.
``varnishclient.request.path`` defines the path for the request.
``varnishclient.request.port`` defines the port for the request.

### ``varnishlog``

### Example

