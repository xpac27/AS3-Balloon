all: example/demo.swf

example/demo.swf: src/com/xpac27/layout/* example/demo.as
	mxmlc example/demo.as --debug=true -static-link-runtime-shared-libraries=true -sp example/ -sp src/ -o example/demo.swf
