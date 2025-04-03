This is a static recreation of e621's April Fools prank that isn't powered by their Rails server.

Changes:

* Undo stack was increased to 50 levels.
* The "Close Verification" button just clears the canvas and returns to it.
* I don't know your username, so the image is named simply `fursona-verification.png` instead of being prefixed with your name.

To build, type `make dist`, which requires `npx` to be installed. It will clone a copy of e621 into `work` to grab their hexagon background image and build their Sass. The `index.html` and `script.mjs` files were manually pieced together from commit 398cf26d, the last one before the prank was removed on April 2nd.

Serve locally with `make serve`; this uses `miniserve`.