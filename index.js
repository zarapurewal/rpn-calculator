
const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const port = process.env.PORT || 8000;

/**
 * Example of a different API
 *
 * You can copy the ideas here to write your own API.
 *
 * This is an example of a random number generator.  The HTTP endpoints are:
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
 *    Return a random number.
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
        && 0 < req.body.maximum ) {
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
 *     validate req.body.values, much like the POST request above.
 *
 * The details of the required API are defined in static/index.(ascii|html).
 */

var stack = [];

/**
 * (You shouldn't have to change anything ABOVE here.)
 */

/*
 * YOUR WORK GOES **BELOW** HERE!
 *
 * Note...
 * The API above has endpoint names of the form "/test/____" (because it's just a demo).
 *
 * The endpoint names below will not include "/test", so they'll be things like "/pop",
 * or "/push".
 */






/**
 * YOUR WORK GOES **ABOVE** HERE.
 *
 * (You shouldn't have to change anything BELOW here.)
 *
 * Start the server on the indicated port.
 */

app.listen(port, function() {
   console.log("listening on port", port, "...");

  /**
   * If there are any addititional arguments, then they are a test command to run.
   * Run that command then exit when it exits.
   *
   * This makes it easy to start the server, run the tests, then exit.
   */
   argv = process.argv.slice(2);
   if ( 0 < argv.length ) {
      console.log("launching tests:", argv);

      childProcess = require("child_process");
      proc = childProcess.spawn(argv[0], argv.slice(1));  // Run a command as a sub-process.
      proc.stdout.pipe(process.stdout);                   // Pipe its output to standard output.
      proc.stderr.pipe(process.stderr);                   // Pipe its errors to standard error.

      proc.on("close", function(code) {
         console.log("tests exited:", code);
         process.exit(code);                              // Exit when the tests exit.
      });
   }
});
