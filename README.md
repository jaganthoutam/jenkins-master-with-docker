# jenkins-master-with-docker

To run the Jenkins with Docker installed.

	mkdir -p /data/jenkins_home

Jenkins ver. latest


	docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jaganthoutam/jenkins-master-docker


To run the K8s Deployment.

Add   node that you want to deply the Jenkins: `kubectl label nodes node2 jenkins=ture` 
	```
        nodeSelector:
          jenkins: "true"                          
        ```
	
       	kubectl apply -f https://raw.githubusercontent.com/jaganthoutam/jenkins-master-with-docker/master/jenkins.yaml


To DO:


Default User/Pass : [admin/password](https://github.com/jaganthoutam/jenkins-master-with-docker/blob/master/Dockerfile#L7)

	Create k8s Secrets to use Password.
