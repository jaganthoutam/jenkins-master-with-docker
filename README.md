# jenkins-master-with-docker

To run the Jenkins with Docker installed.

	mkdir -p /data/jenkins_home

Jenkins ver. latest


	docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jaganthoutam/jenkins-master-docker


To run the K8s Deployment.

       kubectl apply -f https://raw.githubusercontent.com/jaganthoutam/jenkins-master-with-docker/master/jenkins.yaml


To DO:


Default User/Pass : admin/password

	Create k8s Secrets to use Password.
