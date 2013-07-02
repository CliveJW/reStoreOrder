# Re-Store-Order
This is a basic ordering system that can import clients and products from CSV.

Orders are placed per client and products are selected and once finished an order can be mailed to suppliers, the client or whoever you want.

Written in coffee using the Frappe framework (NodeJS).

# NOTE

This software while free is written for my father and his business. Certain aspects of this app are customized to suite their expectations and as such will NOT fit yours. Don't complain. :-)

### Setup
	DEPS:
	 "dependencies": {
    "express": "~3.1.0",
    "jade": "*",
    "stylus": "*",
    "coffee-script": "~1.5.0",
    "underscore": "~1.4.1",
    "underscore.string": "~2.3.0",
    "connect-assets": "~2.3.3"

![Frappe](https://raw.github.com/dweldon/frappe/master/app/public/img/frappe.png)

# Frappé

Template for creating [Express](http://expressjs.com) applications with
[CoffeeScript](http://coffeescript.org).

Inspired by:
* [skeleton](https://github.com/EtienneLem/skeleton)
* [express-coffee](https://github.com/twilson63/express-coffee)
* [full-stack-nodejs](https://peepcode.com/screencasts/javascript)

## Installation

```sh
$ git clone http://github.com/dweldon/frappe [project-name]
$ cd [project-name] && rm -rf .git && npm install
```

## Commands

### Start

To start the server:
```sh
$ npm start
```

For convenience while developing, automatic restarts are provided with:
```sh
$ cake start
```

Additionally, the port and environment variables can be set. The following
example will start the server listening on port 3000 in production mode:
```sh
$ cake -p 3000 -e production start
```

## License

(The MIT License)

Copyright (c) 2012 David Weldon

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
