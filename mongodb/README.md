# A simple container for MongoDB

Please find mongodb at https://github.com/mongodb/mongo

Docs at https://docs.mongodb.com/

Please define PASSWD as an env variable if you wish authentication.

You may run this using:

    docker run -d --net host -e tcx/mongodb
or

    docker run -d --net host -e PASSWD=MySuPeRdUpErPaSsW0rD tcx/mongodb
