# shellac
A REPL for Varnish's ``varnishlog`` command.

## Installation

``shellac`` is available on [rubygems.org](https://rubygems.org) as
[shellac-repl](https://rubygems.org/gems/shellac-repl). [[1]](#footnote_1)<a name="return_from_footnote_1"></a>

Install the gem via the ``gem`` command:

``gem install shellac-repl``

## Running `shellac`

Simply call ``shellac`` top start the REPL:

shellac@varnish01 ~] $ shellac

```
Default request: http://localhost/
HTTP Port (varnishclient.request.port): 80
HTTP Request Path (varnishclient.request.path): /
HTTP Host Header (varnishclient.request.host): www.example.com

You may want to to modify this before calling @varnishclient.make_request!

shellac> varnishclient.request.port = 8080
=> 8080

shellac> varnishclient.request.path = '/images/shellac.png'
=> "/images/shellac.png"

shellac> varnishclient.request.host = 'www.shellac.com'
=> "www.shellac.com"

shellac> make_request

http://localhost:8080/images/shellac.png: 200 OK

=> ["-   RespHeader     Date: Tue, 09 Feb 2016 02:37:03 GMT", "-   RespHeader     Server: Apache", "-   RespHeader     Cache-Control: max-age=60, public", "-   RespHeader     Vary: Accept-Encoding", "-   RespHeader     Content-Encoding: gzip", "-   RespHeader     Content-Length: 736", "-   RespHeader     X-Cnection: close", "-   RespHeader     Content-Type: application/json", "-   RespHeader     X-Varnish: 886856589", "-   RespHeader     Age: 0", "-   RespHeader     Via: 1.1 varnish-v4", "-   RespHeader     X-Cache-Status: MISS", "-   RespHeader     Transfer-Encoding: chunked", "-   RespHeader     Connection: close", "-   RespHeader     Accept-Ranges: bytes"]

shellac> varnishlog.response.date
=> "Tue, 09 Feb 2016 02:37:03 GMT"

shellac> varnishlog.response.cache_control
=> "max-age=60, public"

shellac> varnishlog.response.x_cache_status
=> "MISS"

shellac>
```

**NOTE**: ``shellac`` kindly informs you that it has set some defaults for a
number of parameters (identified in parentheses). Those defaults most likely
won't do anyone any good, so it's recommended to change them.

### ``varnishclient``

``varnishclient`` is an instance of a [VarnishClient](https://github.com/RyanFrantz/shellac/blob/master/lib/varnishclient/varnishclient.rb)
object. Its job is to define the HTTP request that will be sent to Varnish as well
as capture its response.

#### ``varnishclient.request``

As ``shellac``'s opening preamble recommends, the default request should be
modified to make a valid request through Varnish.

Set the Host header for the request via ``varnishclient.request.host =``.

For paths other than ``/``, use ``varnishclient.request.path =``.

If Varnish is listening on a port other than ``80``, define it with ``varnishclient.request.port =``.

### Making Requests

To execute an HTTP request, call the ``#make_request`` method. ``shellac`` will
output the full request's URL and the response code received by ``varnishclient``.

```
shellac> make_request

```

At any time, ``varnishclient``'s attributes can be modified and ``#make_request``
called again.

### ``varnishlog``

``varnishlog`` is an instance of a [VarnishLog](https://github.com/RyanFrantz/shellac/blob/master/lib/varnishlog/varnishlog.rb)
object. ``varnishlog`` is used to start a ``'varnishlog'`` subprocess in another
thread before ``varnishclient`` sends its request. The output from the subprocess
is collected when ``varnishclient`` returns. Using ``varnishlog`` one can view
both the request Varnish received and the response that it generated.

#### Request/Response Headers

We can't anticipate (and therefore code) all request/response headers (i.e custom ``X-`` headers)
so ``varnishlog`` dynamically looks up headers based on the method passed to ``#request``
and ``#response``.

For single-word headers, life is really easy:

```
shellac> varnishlog.response.age
=> "0"

```

``varnishlog`` capitalizes the header name and looks it up in a hash of all the headers.

Multi-word headers like ``Cache-Control`` and ``X-Cache-Status`` need to be
specified in lowercase, replacing hyphens with underscores. ``varnishlog`` knows
what to do with them:

```
shellac> varnishlog.response.cache_control
=> "max-age=60, public"

shellac> varnishlog.response.x_cache_status
=> "MISS"

```

## Footnotes

<a name="footnote_1"></a>
[1] I am both happy and sad that there is an existing gem named [shellac](https://rubygems.org/gems/shellac).
I'm glad that someone else shares my sense of humor (all puns are **always** intended)
but it gets my goat that someone beat me to the punch. 4 years ago.

