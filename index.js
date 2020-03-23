
const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const port = process.env.PORT || 6541;

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
 * GET /test/random
 *
 *    This returns a random number.  It is an error to request a random
 *    number before the maximum has been set (see above).
 */

var maxRandom = 0;

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
      res.send(`ok, maximum set to: ${maxRandom}\n`);
   }
   else {
      res.status(400).send("bad request (invalid maximum value)\n");
   }
});

// Example GET request (including handling an error case).
//
app.get("/test/random", function(req, res) {
   if (maxRandom == 0) {
      res.status(400).send("bad request (maximum not set)\n");
   }
   else {
      var r = Math.floor(Math.random() * maxRandom);
      console.log("random:", r);
      res.send(JSON.stringify(r) + "\n");
   }
});

/**
 * Serve static files from the directory ./static.
 *
 * Just "index.html" is served from here.
 */

app.use(express.static('./static'));

/**
 * Start the server on the indicated port.
 */

app.listen(port, () => console.log(`Example app listening on port ${port}...`))
