# KC Dragón Ball App

## Proyecto creado por Juan Carlos Rubio Casas
## 29-09-2024 

Proyecto practica final de modulo "Fundamentos Swift" del BootCamp "Desarrollo de aplicaciones móviles" de KeepCoding

La aplicación consta:
- Vista login
- Vista héroes
- Vista detalle de heroe
- De tener el héroe transformaciones, vista de transformaciones
- Detalle de transformación
- Reproductor MP3 con musica relacionada con Dragón Ball tras conseguir un login exitoso.

Tanto el login, como los datos de las diferentes vistas, se obtienen mediante un request HTTPS contra el API Dragón Ball de KeepCoding
- El login, se realiza mediante una autentificaron basic, realizada mediante usuario y clave previamente registrados en la API. Este login retorna un token de sesión.
- Las vistas se descargan mediante una petición POST HTTPS usando como medio de autentificación el token obtenido en el login

El proyecto también cuenta con sus propios test, los cuales nos permiten verificar y entender el funcionamiento de:
- Login
- getHeroes
- getTransformation
- playMusic y stropMusic del reproductor MP3

### Requisitos:
- **iOS 14+**
- **Xcode 12+**
- **Swift 5.0+**

### Contacto:
Agradezco su atención y quedo a su entera disposición en rubiocasasjuancarlos@gmail.com
