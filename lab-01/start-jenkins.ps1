# Levanta Jenkins LTS (JDK 21) en Docker, accesible solo en http://127.0.0.1:8081

# Volumen administrado por Docker para persistir la configuración, jobs y builds
docker volume create jenkins_home

# Contenedor en segundo plano; se reinicia solo salvo que se detenga manualmente
docker run -d --name jenkins --restart unless-stopped `
  -p 127.0.0.1:8081:8080 `
  -v jenkins_home:/var/jenkins_home `
  jenkins/jenkins:lts-jdk21

Write-Host "Jenkins: http://127.0.0.1:8081"
Write-Host "Contraseña inicial (cuando termine de arrancar):"
Write-Host "  docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword"
