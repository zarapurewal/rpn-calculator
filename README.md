Fork and clone this repo.

When you are done, push your work back to the `master` branch in your project on GitLab.

### Node modules

This is an node project.  It depends upon a number of node modules.

To install the necessary node modules, use:

    $ npm install

`npm` is the *node package manager*.  This creates a directory `node_modules` containing all of the node
modules which are required for this project.

The `make` targets in this directory try to ensure that `npm install` has been run, but it's probably best not
to rely on that.

### Task 1

Extend the implementation in `index.js` such that it implements the RPN-calculator API described in
[static/README.md](static/README.md).

Ensure that `make rpn` (which runs the RPN calculator tests) succeeds.

### Task 2

Do not proceed to this task until you have successfully completed task 1.

Complete the `.gitlab-ci.yml` CI config files such that the `random` **and** `rpn` tests
are run (and pass!) when you push your work to GitLab.

Check under "CI/CD" / "Jobs" on GitLab.  Fix any issues which arise (although there really shouldn't be any).

### Task 3

Do not proceed to this task until you have successfully completed task 1 (task 2 doesn't matter).

Look at the bottom of the `Makefile` in this directory, specifically the targets `up`, `docker` and `down`.

I will run these three targets as:

```
$ make up
$ make docker
$ make down
```

- `up` uses `docker compose` to bring up a docker container.
- `docker` runs the same RPN tests as before, but this time against an existing server running on port 8000; this will be your server running inside a docker container.
- `down` brings the docker container down again.

Your task is to:

1. complete the `Dockerfile` in this directory such that if defines a docker image containing your RPN app;
   don't forget to include the necessary `node_modules` in your image, and
2. complete the `docker-compose.yml` file in this directory to bring up a container running your image.

You should map port 8000 on localhost to whichever port your app is listening on inside the container
(probably also port 8000).

This task is very similar to one of the tasks in last week's "docker demo" repo.
