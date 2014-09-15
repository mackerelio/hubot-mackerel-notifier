test: coffee-dep js
	@find test -name '*_test.coffee' | xargs -n 1 -t coffee

js: coffee-dep
	@coffee -c --bare -o lib src/

remove-js:
	@rm -fr lib/

bundler-dep:
	@test `which bundle` || echo 'You need bundler to do bundle install... makes sense?'

npm-dep:
	@test `which npm` || echo 'You need npm to do npm install... makes sense?'

coffee-dep:
	@test `which coffee` || echo 'You need to have CoffeeScript in your PATH.\nPlease install it using `npm install coffee-script`.'

.PHONY: all
