[download_image_create_starter]: assets/images/download_image_create_starter.800x600.png
[run_container_build_start_web]: assets/images/run_container_build_start_web.800x400.png
[running_starter_web]: assets/images/running_starter_web.800x700.png

You work on Linux? Most of the tools needed for developing a Jekyll Web like
`J1 Template` are already installed or if missing quite easy to install. No
wonder, Linux support developers at it's best.

Creating a fully equipped Jekyll developing enviroment may take a while
anyway. If you don't want to mixup e.g. already installed applications like
Python, Ruby or NodeJS on your existing OS, you can go for J1 Images.

As mentioned, on _Linux_, all languages and tools are fully supported, mostly
installed already in their latest versions. Unfortuneatly, this is **not**
the case on _Windows_ or _OSX_. On _MacOS_, users will find some of the
developing tools installed but mostly in unusable, quite old versions.

**MacOS** and **Windows*** users **not** out here! You are welcome to use
Docker for creating a quite current development environment based on **Docker
containers**.

And you're done less than 15 minutes ..

# J1 Images

`J1 Images` is a Ruby project to create and manage **Docker Images** for
developing and running static **Jekyll Webs**. The images created are
optimized for the `J1 Template` project but can be used for **all** Jekyll
based web sites as well.

`J1 Images` supports all Docker images needed for all development and run-time
processes.
The image contains, beside of the RubyGem `Jekyll` and `J1 Template` all
development dependencies like Git, the languages Ruby, Python and NodeJS plus
a set of helpful applications ready to use.

## Core engine

The core engine to create Docker images for `J1 Template` is
[docker-template](https://github.com/envygeeks/docker-template), a RubyGem
written by Jordon Bedwell ([envygeeks](https://envygeeks.io/)). Please find
all details how to use `docker-template` in general with the
[Wiki pages](https://github.com/envygeeks/docker-template/wiki)
for your reference.

If you're interested in the **official** Docker images for Jekyll, have a
look at [Docker Hub](https://hub.docker.com/r/jekyll/jekyll/) for the Docker
images **jekyll/jekyll**.

> **NOTE**
> The official Docker Image **jekyll/jekyll** for Jekyll **cannot** be
> used to create and manage web sites based on J1 Template.

## Quickstart

To use Docker images, to create a Docker container for managing a J1 Web a
installation of the Docker software is needed. Check the pages
[docs@docker](https://docs.docker.com/) how to get an installation package
for your platform, if not already installed.

To start using J1 Images immediately, already generated images are available
at [jekyllone](https://hub.docker.com/u/jekyllone/) at Docker Hub:

*   `jekyllone/j1image` - Image to create Docker images for the `J1 template` project from the scratch
*   `jekyllone/j1app` - Image to run J1 Template based Web sites as an Docker App
*   [jekyllone/j1base](https://hub.docker.com/r/jekyllone/j1base/) - Base image, all core software bundled,
only selected RubyGem included
*   [jekyllone/j1](https://hub.docker.com/r/jekyllone/j1/) - Fully equipped image based on `jekyllone/j1base`
but includes all Rubies needed to run and develop a web site

> **NOTE**:
> The image `jekyllone/j1app` is currently under construction and **not**
> available, yet.


### Create and run a Web

To start the fastest way, the Docker image [jekyllone/j1](https://hub.docker.com/r/jekyllone/j1/)
can be used to create **and** run a so-called **starter web**. Starter webs are
J1 site skeletons containing a bunch of examples how to use J1 Template for
your new web site.

Create a folder for your new J1 Webs and change to that directory, e.g.
**j1webs**.

```bash
docker run --rm \
  --volume=$PWD:/j1/data \
  -it jekyllone/j1:latest \
  j1 generate starter
```

The download of the image `jekyllone/j1:latest` from Docker Hub is starting
and, if finished, a site scaffold is created in a subfolder named
**starter**.

Change to that folder and run:

```bash
docker run --rm \
  --volume=$PWD:/j1/data \
  --publish=35729:35729 --publish=40000:40000 \
  -it jekyllone/j1:latest \
  j1 serve --incremental --livereload
```

Open a web browser and point to that URL. If you're working locally on the
host, use `localhost` for the **hostname**

> `http://localhost:40000/`

or the hostname <hostname>, e.g. ubuntu, if you work on a **remote**
system

> `http://<hostname>:40000/`

_Running starter web in a browser_
![Running starter web in a browser][running_starter_web]

Voila - you're done! In less than 15 minutes you got a development environment
installed based on latest versions with no burden.

Have fun!

## Developing J1 Template

The section **Quickstart** was focussing on a **run-time** environment to
develop a web site based on J1 Template. To modify or extend the template
system, the Docker image **jekyllone/j1** can be used as well. All components
needed are included ready to use.

To develop the template, clone the Github project `j1_template_mde` to your
local J1 Web folder **j1web**:

```sh
docker run --rm \
  --user $(id -u $(whoami)) \
  --volume=$PWD:/j1/data \
  -it jekyllone/j1:latest \
  git clone https://github.com/jekyll-one/j1_template_mde_dev.git
```

Change to the newly created directory **j1_template_mde_dev** and initialize
the development environment for the first use.

```sh
docker run --rm \
  --user $(id -u $(whoami)) \
  --volume=$PWD:/j1/data \
  -it jekyllone/j1:latest \
  yarn setup
```

Setting up the project (for the first use) will take a while - have a break!

> **NOTE**:
> J1 Template is using a multiplatform interface based on NodeJS and NPM. All
> development tasks are NPM scripts configured with the NodeJS project file
> `package.json` in the project's root folder. All other components are
> organized as **lerna** packages can be found in the folder `packages`.

To develop J1 Template, the toplevel scripts manages what needs to be done.
For more details see the project [J1 Template](https://github.com/jekyll-one/j1_template_mde_dev)
on Github.

Once the setup process has finished:

```sh
...
starter_web: Bundle complete! 39 Gemfile dependencies, 108 gems now installed.
starter_web: Bundled gems are installed into `/usr/local/bundle`
starter_web: Configuration file: _config.yml
starter_web:             Source: .
starter_web:        Destination: _site
starter_web:  Incremental build: enabled
starter_web:       Generating...
starter_web:        Jekyll Feed: Generating feed for posts
starter_web:          AutoPages: Disabled/Not configured in site.config.
starter_web:         Pagination: Complete, processed 1 pagination page(s)
starter_web:                     done in 37.685 seconds.
starter_web:  Auto-regeneration: disabled. Use --watch to enable.
lerna success run Ran npm script 'jekyllb' in packages:
lerna success - starter_web
```

All template ressources for development are created **and** a starter web
has been build for checking your modifications like `Liquid` templates or
`Javascipt` and `CSS` assets.

To run the build-in starter web for development, simply run:

```sh
docker run --rm \
  --volume=$PWD:/j1/data \
  --publish=35729:35729 --publish=41000:41000 \
  -it jekyllone/j1:latest \
  yarn site
```

This starts a new container named **develop** based on jekyllone/j1:latest
image; the hostname of your development app is set to **j1develop**.

```sh
$ lerna run --parallel --scope starter_web develop
lerna info version 2.11.0
lerna info scope starter_web
lerna info run in 1 package(s): npm run develop
starter_web: $ run-p -s develop:*
starter_web: Configuration file: _config.yml
starter_web: ℹ ｢wds｣: Project is running at http://0.0.0.0:41000/
starter_web: ℹ ｢wds｣: webpack output is served from /assets/themes/j1/core/js
starter_web: ℹ ｢wds｣: Content not from webpack is served from /j1/data/packages/400_starter_web/_site
starter_web:             Source: .
starter_web:        Destination: _site
starter_web:  Incremental build: enabled
starter_web:       Generating...
starter_web:        Jekyll Feed: Generating feed for posts
starter_web:          AutoPages: Disabled/Not configured in site.config.
starter_web:         Pagination: Complete, processed 1 pagination page(s)
starter_web:                     done in 5.694 seconds.
starter_web:  Auto-regeneration: enabled for '.'
starter_web: ℹ ｢wdm｣:    229 modules
starter_web: ℹ ｢wdm｣: Compiled successfully.
```

The project is running at `http://0.0.0.0:41000/`. If started on your
local host, point your browser to this URL to access that web:

> `http://localhost:41000/`

If you are developing on a remote host, go for the following section
**Developing on a remote Host**.

### Developing on a remote Host

For Javascript development, J1 Template is using **Webpack V4**. If you plan
to develop on a remote system (or on a host e.g. behind a Proxy), WP's host
checking needs to be **disabled** by setting the environment variable
`DISABLE_WP_HOST_CHECK` to `true`.

Run the site like so:

```sh
docker run --rm \
  --env DISABLE_WP_HOST_CHECK=true \
  --volume=$PWD:/j1/data \
  --publish=35729:35729 --publish=41000:41000 \
  -it jekyllone/mydev:latest \
  yarn site
```

If `DISABLE_WP_HOST_CHECK` is set to `true`, it's possible to use a remote
host for development.

Use the URL:

> `http://<hostname>:41000/`

to access the web on your remote system.

> **WARNING**
> Be aware that this setting may cause **security issues** and should be
> used only, if you know what you're doing.

## Creating your own Docker images

You can create J1 Docker images for your needs. If you've addedd additional
RubyGems for example, go for section **Update Images for RubyGems**. If you
plan to modify or (completely) re-create the base image go for section
**Built J1 Images**.

### Update Images for RubyGems

Docker images for J1 should be updated, if a larger number of RubyGems has
been changed (e.g. the versions) or if added new ones.

The easiest method to create your own image is to run your site based on the
J1 Image **jekyllone/j1base:latest** to recreate **all** RubyGems or based on
the current development image **jekyllone/j1:latest** to update for newer
or additional Rubies.

The software bundled by J1 Images contains an adapted **bundler** to install
any dependencies that you list inside of your `Gemfile`, matching the versions
you have in your `Gemfile.lock`; including Jekyll if you have a version that
does not match the version of the J1 Images you are using.

The update process is quite easy and use the capabilities of Docker to create
new images based on existing containers using `docker commit`. First create
a new container as a base temporarely, then commit this container to a new
image of your choice.

#### Update for a single Gemfile

Change to the folder that contains your modified Gemfile:

```sh
docker run \
  --name temp_container \
  --volume=$PWD:/j1/data \
  -it jekyllone/j1:latest \
  bundle install
```

And commit the temp container for your new image:

```sh
docker commit temp_container <your_project/your_image_name_your_version>
```

#### Update for all Gemfiles in a Web

In order to update an image for Gemfiles across your project, run a clean task
using the J1 base image for your modified web:

```sh
docker run  \
  --name temp_container \
  --volume=$PWD:/j1/data \
  -it jekyllone/j1base:latest \
  yarn site
```


## Build J1 Images

You can build images or any specific tag of an image running

```sh
docker run --rm \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --volume=$PWD:/j1/data \
  -it jekyllone/j1images \
  j1 build <repo_name>:<tag>
```

It's simple like that to build images!

Example:

```sh
docker run --rm \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --volume=$PWD:/j1/data \
  -it jekyllone/j1images \
  j1 build j1base:latest
```

### Reset a Build

```sh
docker run --rm \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --volume=$PWD:/j1/data \
  -it jekyllone/j1images \
  j1 clean
```

### Remove <none> images after Build

This will print you all untagged images

```sh
docker images ls -a | grep "^<none>" | awk "{print $3}"
```

This filtering also works for dangling volumes. To remove all those images
run:

```sh
docker rm $(docker images ls -a | grep "^<none>" | awk "{print $3}")
```

```sh
docker image ls -a | grep -v "^<none>"
```

## Explore an Image

To have a look inside an image, run a container using a bash (shell):

```sh
docker run --rm \
  --name j1_container \
  --hostname j1_container \
  --volume=$PWD:/j1/data \
  -it jekyllone/j1:latest \
  bash
```

or if a GUI is more convinient, the buildin _Midnight Commander_ can be used
to explore

```sh
docker run --rm \
  --name j1_container \
  --hostname j1_container \
  --volume=$PWD:/j1/data \
  -it jekyllone/j1:latest \
  mc
```

## What are none-none images?

See: [What are Docker none:none images?](https://www.projectatomic.io/blog/2015/07/what-are-docker-none-none-images/)
See: [dockviz](https://github.com/justone/dockviz)

docker image ls -f dangling=true -q

docker image rm -f $(docker image ls -f dangling=true -q)


## Untagged images

```sh
docker image ls -a | grep "^<none>" | awk "{print $3}"
docker image ls -a | grep "^<none>" | sed 's/  */ /g' | cut -d" " -f 3
```

This filtering also works for dangling volumes. To remove all those images
run:

```sh
docker image rm --force $(docker image ls -a | grep "^<none>" | awk "{print $3}") --force
docker image rm --force $(docker image ls -a | grep "^<none>" | sed 's/  */ /g' | cut -d" " -f 3)
```

## Format the output of docker commands

docker images --format '{{.Size}}\t{{.Repository}}:{{.Tag}}\t{{.ID}}' | sort -r | column -t
