FROM jenkins/jenkins:latest
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
COPY casc.yml /var/jenkins_home/casc.yml
