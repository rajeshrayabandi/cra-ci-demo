node {

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {	 

        // Build the docker image with the tag "sample-app"
	sh 'docker build -t sample-app .'

        // Export the docker image as sample-app.tar file
	sh 'docker save -o sample-app.tar sample-app:latest'	    
    }

    stage('Push image') {
	    
        // Push the image
        sh 'scp -o StrictHostKeyChecking=No sample-app.tar root@92.168.1.120:/root'
        
        // Stop the running container
        sh 'ssh -o StrictHostKeyChecking=No root@192.168.1.120 docker stop sample-container'
            
        // Remove the running container   
        sh 'ssh -o StrictHostKeyChecking=No root@92.168.1.120 docker rm sample-container'
        
        // Remove the current image 
        sh 'ssh -o StrictHostKeyChecking=No root@92.168.1.120 docker rmi sample-app'
            
        // Load the new image
        sh 'ssh -o StrictHostKeyChecking=No root@92.168.1.120 docker load -i sample-app.tar'
            
        // Run the container
        sh 'ssh -o StrictHostKeyChecking=No root@92.168.1.120 docker run -d --name sample-container -p 9126:9126 --restart=always sample-app'    
    }

    stage('Remove image from Jenkins') {

        // Remove the exported file
        sh 'rm sample-app.tar'

        // Remove the docker image from Jenkins server 
        sh 'docker rmi sample-app'  
    }
}
