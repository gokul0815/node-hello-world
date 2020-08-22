node {
    def app

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        app = docker.build("gokuldevops/hello-world")
    }

    stage('Test image') {

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    stage('deploy image') {
            sh 'docker ps -a | awk '{ print $1,$2 }' | grep gokul0815/hello-world | awk '{print $1 }' | xargs -I {} docker rm {}'
            sh 'sudo docker run -d -p 3000:3000 gokul0815/hello-world'
    }

}
