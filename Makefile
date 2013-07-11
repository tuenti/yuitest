all: java javascript

java:
	@echo "Making Java"
	cd java && ant -q

js: javascript

javascript:
	@echo "Making Javascript"
	cd javascript && ant -q -Dlint.skip=true -Dcoverage.skip=true

javatest: testjava

testjava:
	@echo "Running Java JUnit tests"
	cd java && ant test

testjavascript: testjs

jstest: testjs
testjs:
	@echo "Testing Javascript"
	./travis/travis.sh

npm:
	@echo "Making NPM Package"
	cd javascript && ant npmbuild

test: testjava testjs

deb: java testjava
	@echo "Making debian package"
	mkdir -p debian/usr/share/java \
	  && cp java/build/yuitest-*.jar debian/usr/share/java \
	  && dpkg-deb --build ./debian debian/yuitest_0.7.9-tuenti2.deb

distclean:
	rm debian/usr -rf
	rm debian/*.deb -f

.PHONY: java javascript test testjava testjs js testjavascript
