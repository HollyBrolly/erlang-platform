ROOT_DIR := $(realpath .)
PROJECT_PATH := $(ROOT_DIR)/r15b01-cowboy
REBAR_PATH := $(ROOT_DIR)/rebar

all : kerl erlang pre-setup rebar setup

kerl :
	curl -O https://raw.github.com/spawngrid/kerl/master/kerl
	chmod a+x ./kerl

erlang :
	./kerl build R15B01 r15b01
	. r15b01/activate

pre-setup :
	mkdir -p $(PROJECT_PATH)/ebin
	mkdir -p $(PROJECT_PATH)/src
	mkdir -p $(PROJECT_PATH)/inlude
	mkdir -p $(PROJECT_PATH)/priv
	mkdir rebar
	cp rebar.config $(PROJECT_PATH)/rebar.config

rebar :
	git clone git://github.com/basho/rebar.git $(REBAR_PATH)
	pushd $(REBAR_PATH)
	make
	cp $(REBAR_PATH)/rebar $(PROJECT_PATH)/rebar
	popd

setup :
	pushd $(PROJECT_PATH)
	./rebar get-deps
	./rebar compile
	popd
