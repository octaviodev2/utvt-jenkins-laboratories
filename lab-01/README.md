# Lab 01 – Jenkins en Docker y primer "Hola mundo"

## Objetivo
Instalar Jenkins en un contenedor Docker, completar el asistente inicial y crear un job
de tipo **Pipeline** que imprima `¡Hola mundo!`.

## Archivos
| Archivo | Descripción |
|---|---|
| `start-jenkins.sh` / `start-jenkins.ps1` | Crea el volumen `jenkins_home` y levanta el contenedor |
| `Jenkinsfile` | Script del pipeline "Hola Mundo" |
| `jobs/hola-mundo/config.xml` | Configuración del job exportada de Jenkins |
| `console-build-1.log` | Salida de consola de la ejecución #1 |

## Pasos
1. Levantar Jenkins:
   ```bash
   ./start-jenkins.sh        # o .\start-jenkins.ps1 en PowerShell
   ```
2. Abrir http://127.0.0.1:8081 y desbloquear con la contraseña inicial:
   ```bash
   docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
   ```
3. **Install suggested plugins** y crear el primer usuario administrador.
4. **Nueva Tarea** → nombre `Hola Mundo` → tipo **Pipeline**.
5. En *General*: descripción `Hola Mundo` y **Desechar ejecuciones antiguas**
   (Log Rotation: 3 días, máximo 5 ejecuciones).
6. En *Pipeline* → *Pipeline script*, pegar el contenido de `Jenkinsfile`.
7. **Save** → **Construir ahora** → ejecución **#1** → **Console Output**.

## Resultado
```
Started by user Octavio Duarte Villavicencio
[Pipeline] Start of Pipeline
[Pipeline] echo
¡Hola mundo!
[Pipeline] End of Pipeline
Finished: SUCCESS
```

## Importar el job en otra instancia (opcional)
```bash
docker exec -i jenkins mkdir -p "/var/jenkins_home/jobs/Hola Mundo"
docker cp jobs/hola-mundo/config.xml "jenkins:/var/jenkins_home/jobs/Hola Mundo/config.xml"
# Después: Administrar Jenkins → Reload Configuration from Disk
```

## Limpieza
```bash
docker rm -f jenkins
docker volume rm jenkins_home   # borra también jobs y usuarios
```
