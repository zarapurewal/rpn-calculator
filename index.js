
const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const port = process.env.PORT || 8092;

/**
 * Example of a different API
 *
 * You can copy the ideas here to write your own API.
 *
 * This is an example of a random number generator.  There are two API
 * requests:
 *
 * POST /test/maximum
 *
 *    The data is a JSON-encoded maximum for the random number generator, and
 *    this call sets the maximum to that value.
 *
 * GET /test/maximum
 *
 *    Get the current maximum..
 *
 * GET /test/random
 *
 *    This returns a random number.  It is an error to request a random
 *    number before the maximum has been set (see above).
 */

var maxRandom = 10;

// For POST requests, parse the JSON-encoded body.  The result is stored
// in req.body. See POST "/test/maximum" example, below.
//
app.use(bodyParser.json());

// Example POST request with a JSON-encoded body.  The body is parsed into
// req.body (see above).
//
app.post("/test/maximum", function(req, res) {
   if ( req.body
        && req.body.hasOwnProperty("maximum")
        && Number.isInteger(req.body.maximum)
        && 0 <= req.body.maximum ) {
      maxRandom = req.body.maximum;
      console.log("setting maximum to", maxRandom);
      res.send(`server... ok, setting maximum: ${maxRandom}\n`);
   }
   else {
      res.status(400).send("bad request (invalid maximum value)\n");
   }
});

app.get("/test/maximum", function(req, res) {
   response = { maximum: maxRandom };
   res.send(JSON.stringify(response));
});

// Example GET request (including handling an error case).
//
app.get("/test/random", function(req, res) {
   if (maxRandom <= 0) {
      res.status(400).send("bad request (maximum not set)\n");
   }
   else {
      var r = Math.floor(Math.random() * maxRandom);
      console.log("server... sending random:", r);
      res.send(JSON.stringify(r) + "\n");
   }
});

/**
 * Serve static files from the directory ./static.
 *
 * Just "index.html" is served from here.
 *
 * You don't have to do anything here, apart from ensuring that the
 * asciidoc file in the static directory has been compiled to HTML.
 */

app.use(express.static('./static'));

/* RPN calculator API.
 *
 * Javascript tips:
 *
 *   - Look carefully at the examples above.  Much of what you need to do
 *     can be achieved by copying and tweaking that code.
 *
 *   - You will need these:
 *       stack = stack.concat(values)
 *       stack.length (length of array "stack", like len(stack) in Python)
 *       value = stack.pop()
 *       stack.push(value)
 *
 *   - For the /push request, the JSON body will already have been parsed by
 *     the body parser above.  You don't need to do anything special.  Just
 *     verify that req.body.values exists.
 */

var stack = [];

/**
 * (You shouldn't have to change anything ABOVE here.)
 */

/*
 * YOUR WORK GOES HERE!
 *
 * Note...
 * The API above has endpoint names of the form "/test/____".
 *
 * The endpoint names below will not include "/test", so they'll be things
 * like "/pop", or "/push".
 */

/**
 * Start the server on the indicated port.
 *
 * (You shouldn't have to change anything BELOW here.)
 */

app.listen(port, function() {
   console.log("listening on port", port);

   /**
    * Now, the server is up.
    *
    * Next, if there is a command-line argument, then we'll run that
    * as a test command via make (and then exit).
    *
    * We're doing it this way, because this will be easy to automate in
    * the CI environment.
    */

   switch ( process.argv.length ) {
      case 2:
	 // OK.  There's nothing to do here.  Just leave the server running.
	 break;
      case 3:
	 console.log("launching tests: make", process.argv[2]);
	 runTest(process.argv[2]);
	 break;
      default:
	 // This is an error.
	 console.error("invalid arguments");
	 process.exit(1);
   }
});

var childProcess = require("child_process");

/**
 * Launch a child process to run make, copying its output (stdout and stderr) to
 * our output.
 *
 * On "close", exit with whatever exit code the child process exited with.
 */

runTest = function(target) {
   make = childProcess.spawn("make", [target]);

   make.stdout.on("data", function(data) {
      console.log(data.toString().trimEnd());
   });

   make.stderr.on("data", function(data) {
      console.error(data.toString().trimEnd());
   });

   make.on("close", function(code) {
      process.exit(code);
   });
}
