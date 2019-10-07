# jenkins-master-with-docker

To run the Jenkins with Docker installed.

Jenkins ver. 2.190.1


	docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jaganthoutam/jenkins-master-docker

