.PHONY: all
all: jquery-3.7.1.min.js work/dirty.stamp themes/hexagon/background.png style.css

jquery-3.7.1.min.js:
	curl https://code.jquery.com/jquery-3.7.1.min.js > ./jquery-3.7.1.min.js

# thanks https://stackoverflow.com/questions/31278902/how-to-shallow-clone-a-specific-commit-with-depth-1
work/checkout.stamp:
	mkdir -p work; \
	cd work; \
	git init; \
	git remote add e6 https://github.com/e621ng/e621ng/ ; \
	git fetch --depth 1 e6 398cf26d5af8715261de1b70bb40192e36312782 ; \
	git checkout FETCH_HEAD ; \
	touch checkout.stamp

themes/hexagon/background.png: work/checkout.stamp
	mkdir -p ./themes/hexagon
	cp work/public/images/themes/hexagon/background.png ./themes/hexagon/background.png

# Cba to figure out how to import fontawesome, just remove the usage and hope for the best
work/dirty.stamp: work/checkout.stamp
	echo "@mixin font-awesome-icon { }" > work/app/javascript/src/styles/base/_fontawesome.scss
	touch work/dirty.stamp

style.css: work/dirty.stamp
	npx -y sass@1.86.2 work/app/javascript/src/styles/base.scss style.css
	rm style.css.map

.PHONY: dist clean serve
dist: all
	rm -rf ./work

clean:
	rm -f style.css
	rm -rf ./work
	rm -rf ./themes

serve:
	miniserve -v --index index.html .