NAME=udemy-ml-api-student # make sure this var is updated to the heroku app name
COMMIT_ID=$(shell git rev-parse HEAD) # reference for the current git commit id, usefully character string to use to tag our docker images, we can alsways track them to their git commit


build-ml-api-heroku: # creating our image from the docker filepassing the env vars in linux syntax, because all run in CI. won't work locally,  we are taging -t the heroku registry and the heroku app name
	docker build --build-arg PIP_EXTRA_INDEX_URL=${PIP_EXTRA_INDEX_URL} -t registry.heroku.com/$(NAME)/web:$(COMMIT_ID) .

push-ml-api-heroku: # take our built images and push it to the heroku registry, using heroku app name and commit id
	docker push registry.heroku.com/${HEROKU_APP_NAME}/web:$(COMMIT_ID)
