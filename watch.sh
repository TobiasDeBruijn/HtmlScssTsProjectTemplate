#!/bin/sh

sigint_handler()
{
  kill $CP_PID
  kill $TSC_PID
  kill $SASS_PID
  kill $LIVE_SERVER
  exit
}

trap sigint_handler INT TERM

live-server --port=9080 --watch=build/ --open=build/html/index.html &
LIVE_SERVER=$!

npx tsc --watch &
TSC_PID=$!
sass --watch src/css:build/css/ &
SASS_PID=$!

while true; do
  $@ cp -r src/html/* build/html &
  CP_ID=$!
  inotifywait -e modify -e move -e create -e delete -e attrib -r src/html
  kill $CP_PID
done