all: example/demo.swf

example/demo.swf: src/* example/demo.as
	mxmlc example/demo.as --debug=true -static-link-runtime-shared-libraries=true -sp example/ -sp src/ -o example/demo.swf
