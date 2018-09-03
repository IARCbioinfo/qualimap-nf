#!/bin/bash
cd ~/project/
git config --global user.email "delhommet@students.iarc.fr"
git config --global user.name "Circle CI_$CIRCLE_PROJECT_REPONAME_$CIRCLE_BRANCH"
git add .
git status
git commit -m "circleCI deployment [skip ci]"
git push origin $CIRCLE_BRANCH

curl -H "Content-Type: application/json" --data "{\"source_type\": \"Branch\", \"source_name\": \"$CIRCLE_BRANCH\"}" -X POST https://registry.hub.docker.com/u/iarcbioinfo/qualimap-nf/trigger/fca437ec-43b6-43c0-b314-b94611ebf9b2/
