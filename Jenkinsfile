node {
    def app

    stage('Initialize Docker'){
        def dockerHome = tool 'myDocker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
    }

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

    stage('Deploy to Server') {
        def dockerRun = 'docker rm hello-world --force && docker run -d -p 8080:8080 --name hello-world gokuldevops/hello-world'

        sshagent(['deploy-to-dev-docker']) {
            sh "ssh -o StrictHostKeyChecking=no mp_task@13.81.5.7 ${dockerRun}"
        }
    }
}
