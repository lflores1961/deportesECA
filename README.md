# Deportes ECA

Esta aplicacion es para la administracion de deportes de
la Escuela de la Ciudad de Aguascalientes
por [Luis Fernando Flores Oviedo] (https://luisflores.wordpress.com)

## Instrucciones
Clonar el repositorio, luego instalar las gems necesarias con:

```
$bundle install --without production
```
A continuacion migrar la base de datos:

```
$rails db:migrate
```
Finalmente correr la bateria de pruebas para verificar que todo
esta correcto.

```
$rails test
```
Si las pruebas pasan, podra correr la aplicacion en un servidor
local.
```
$rails server
```

* Ruby version: 2.3.1
* Rails version: 5.0.0.1
