#!/bin/sh

unset GETOPT_COMPATIBLE
OPTIONS=$(getopt -o a:b:c:d:e:f: -- "$@")
eval set -- "$OPTIONS"

while [ $# -gt 0 ]; do
  case $1 in
  -a)
    export RULESET_PATH=$2
    shift
    ;;
  -b)
    export TARGET_PATH=$2
    shift
    ;;
  -c)
    export OUTPUT_FORMAT=$2
    shift
    ;;
  -d)
    export OUTPUT_PATH=$2
    shift
    ;;
  -e)
    export SUCCEED_ALWAYS=$2
    shift
    ;;
  -f)
    export PATHS_IGNORE=$2
    shift
    ;;
  --)
    shift
    break
    ;;
  esac
  shift
done

ARGS="$RULESET_PATH $TARGET_PATH"
if [ $OUTPUT_FORMAT ]; then
  ARGS="$ARGS --format $OUTPUT_FORMAT"
fi
if [ "$SUCCEED_ALWAYS" = "true" ]; then
  ARGS="$ARGS --exit-zero"
fi

for PATH_TO_IGNORE in ${PATHS_IGNORE//,/ }; do
  ARGS="$ARGS --exclude \"$PATH_TO_IGNORE\""
done

echo "[Run]"
echo "command: shisho check $ARGS"
echo "output: $OUTPUT_PATH"

if [ $OUTPUT_PATH ]; then
  /shisho check $ARGS >$OUTPUT_PATH
else
  /shisho check $ARGS
fi
