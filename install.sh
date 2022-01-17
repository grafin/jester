#!/usr/bin/env bash

POSITIONAL_ARGS=()
SCRIPT_PATH="$(dirname "$(readlink -f "$0")")"
INSTALL_PATH="/srv/www/jester"
JS_SRC_PATH="${SCRIPT_PATH}/src"
JS_DIST_PATH="${SCRIPT_PATH}/dist/js"
CSS_SRC_PATH="${SCRIPT_PATH}/src/css"
CSS_DIST_PATH="${SCRIPT_PATH}/css"
HTML_SRC_PATH="${SCRIPT_PATH}/src/html"
HTML_DIST_PATH="${SCRIPT_PATH}/html"
WWW_USER="www-data"
WWW_GROUP="www-data"

while [[ $# -gt 0 ]]; do
  case $1 in
    -i|--installpath)
      INSTALL_PATH="$2"
      shift # past argument
      shift # past value
      ;;
    -u|--user)
      WWW_USER="$2"
      shift # past argument
      shift # past value
      ;;
    -g|--group)
      WWW_GROUP="$2"
      shift # past argument
      shift # past value
      ;;
    -h|--help)
      echo "@TODO"
      exit 0;
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

# Build JS
tsc && cp ${JS_SRC_PATH}/*.js ${JS_DIST_PATH} \
sudo mkdir -p "${INSTALL_PATH}" && \
sudo cp ${HTML_DIST_PATH}/*.html "${INSTALL_PATH}" && \
sudo mkdir "${INSTALL_PATH}/js" && \
sudo cp ${JS_DIST_PATH}/*.js "${INSTALL_PATH}/js" && \
sudo mkdir "${INSTALL_PATH}/css" && \
sudo cp ${CSS_DIST_PATH}/*.css "${INSTALL_PATH}/css" && \
sudo chown -R "${WWW_USER}:${WWW_GROUP}" "${INSTALL_PATH}"
