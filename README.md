Seed App
========

Provides bare bones setup for a frontend environment build on the following:

* architecture - wire.js
* data models - backbone.js
* view models - knockout.js
* testing - jasmine

Requires the following to be installed already:

* node (for fronend)
* pip (for backend)
* mongo (for backend)

Backend environment
------------------

To setup and run the server:

    cd backend
    pip install -r requirements.txt
    ./manage.py runserver 0.0.0.0:8000


Frontend environment
------------------

Grunt is used to compile coffeescript and run the unit tests in jasmine.
Npm is used to install grunt and packages used by grunt.
Bower is used to install JS packages for use in the browser.

To setup the initial environment:

    npm install

This will install grunt, bower and all the various dependencies. It will also call `bower` to install its packages.

After all packages are installed, to compile all coffeescript and run unit tests run the below. It then watches for changes and runs itself again.

    grunt

To understand how the frontend works, look at the `README.md` in `frontend`
