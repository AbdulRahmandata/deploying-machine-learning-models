#!/usr/bin/env bash
export IS_DEBUG=${DEBUG:-false}
# running our gunicorn command to start our flask application, this is the similar to the command used for in the prock file for the heroku set up.
exec gunicorn -b :${PORT:-5000} --access-logfile - --error-logfile - run:application