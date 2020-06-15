CHART_REPO := http://jenkins-x-chartmuseum:8080
NAME := zeebe-operate
OS := $(shell uname)

CHARTMUSEUM_CREDS_USR := $(shell cat /builder/home/basic-auth-user.json)
CHARTMUSEUM_CREDS_PSW := $(shell cat /builder/home/basic-auth-pass.json)

init:
	helm init --client-only

setup: init
	helm repo add jenkins-x http://chartmuseum.jenkins-x.io
	#helm repo add releases ${CHART_REPO}

build: clean setup
	helm dependency build zeebe-operate
	helm lint zeebe-operate

install: clean build
	helm upgrade ${NAME} zeebe-operate --install

upgrade: clean build
	helm upgrade ${NAME} zeebe-operate --install

delete:
	helm delete --purge ${NAME} zeebe-operate

clean:
	rm -rf zeebe-operate/charts
	rm -rf zeebe-operate/${NAME}*.tgz
	rm -rf zeebe-operate/requirements.lock

release: clean build
ifeq ($(OS),Darwin)
	sed -i "" -e "s/version:.*/version: $(VERSION)/" zeebe-operate/Chart.yaml

else ifeq ($(OS),Linux)
	sed -i -e "s/version:.*/version: $(VERSION)/" zeebe-operate/Chart.yaml
else
	exit -1
endif
	helm package zeebe-operate
	curl --fail -u $(CHARTMUSEUM_CREDS_USR):$(CHARTMUSEUM_CREDS_PSW) --data-binary "@$(NAME)-$(VERSION).tgz" $(CHART_REPO)/api/charts
	rm -rf ${NAME}*.tgz
	jx step changelog  --verbose --version $(VERSION) 
