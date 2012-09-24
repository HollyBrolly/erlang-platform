#!/bin/bash

ERL_VERSION=R15B01
KERL_ERL_NAME=r15b01

ROOT_DIR=`pwd`
PROJECT_PATH=$ROOT_DIR/r15b01-cowboy
REBAR_PATH=$ROOT_DIR/deps/rebar
OUR_ERL_PATH=$ROOT_DIR/deps/$KERL_ERL_NAME

clear
mkdir deps
pushd deps

echo "Downloading kerl..."

curl -O https://raw.github.com/spawngrid/kerl/master/kerl
chmod a+x ./kerl

echo "Setting up Erlang R15B01"

./kerl build $ERL_VERSION $KERL_ERL_NAME
./kerl install $KERL_ERL_NAME $OUR_ERL_PATH

popd # not in the deps dir anymore

. $OUR_ERL_PATH/activate

echo "Setting up directories and moving files"

for d in "ebin,src,include,priv"
do
  mkdir -p $PROJECT_PATH/$d
done
mkdir -p $REBAR_PATH
cp rebar.config $PROJECT_PATH/rebar.config

echo "Getting rebar"

git clone git://github.com/basho/rebar.git $REBAR_PATH
pushd $REBAR_PATH
make
cp $REBAR_PATH/rebar $PROJECT_PATH/rebar
popd

echo "Retrieving dependencies and compiling"
pushd $PROJECT_PATH
./rebar get-deps
./rebar compile
popd

echo "========================================================================="
echo "You're set and redy to go in ${PROJECT_PATH}"
echo "If your Erlang version isn't $ERL_VERSION, run"
echo "   . $OUR_ERL_PATH/activate"
echo "========================================================================="
