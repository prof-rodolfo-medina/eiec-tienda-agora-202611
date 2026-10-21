# AWS en el curso

## Qué acceso tenemos

La institución indica registrarse en **AWS Educate** con el correo **@comunidadunir.net**: <https://aws.amazon.com/es/education/awseducate/>. AWS Educate ofrece formación gratuita y **laboratorios prácticos guiados** (almacenamiento con S3, cómputo con EC2, redes con VPC, bases de datos con RDS) en entornos controlados y sin tarjeta.

Implicaciones para el diseño del curso:

- Los laboratorios de AWS Educate están pensados para trabajar **en la consola** dentro de un entorno temporal. Por eso la ruta AWS del curso es **manual y guiada**, no un despliegue automatizado desde GitHub Actions.
- La automatización completa (staging → aprobación → producción) se hace en Azure. AWS sirve para practicar el **despliegue inmutable** de la misma imagen de contenedor.

Además, UNIR (Grupo ProEduca) es miembro de **AWS Academy**. Si la coordinación habilita un aula de *AWS Academy Learner Lab* para la asignatura, cada estudiante tendría credenciales temporales de AWS que sí pueden usarse desde el pipeline (caducan al cerrar la sesión del laboratorio y hay que actualizarlas en los secretos).

> Al registrarte, explora qué laboratorios aparecen en tu cuenta. Anota en la bitácora de la semana 1 si ves un laboratorio de cómputo (EC2): lo usaremos en la semana 7.

## Ruta AWS de la semana 7: imagen de GHCR en EC2

1. En la semana 6 publica tu imagen en GHCR y hazla **pública**.
2. En el laboratorio de cómputo, lanza una instancia **Amazon Linux 2023**, tipo pequeño (el que proponga el laboratorio).
3. En *Advanced details → User data* pega `infra/aws/ec2-user-data.sh` con tu imagen.
4. En el *security group* permite HTTP (puerto 80) desde tu IP.
5. Verifica desde tu equipo:

   ```bash
   BASE_URL=http://<IP-pública> bash scripts/smoke_test.sh
   ```

6. Nueva versión = nueva instancia con la etiqueta nueva; verifica y termina la anterior.

## Ideas para el Tema 9 con S3 (opcional)

Publica el informe HTML de cobertura (`make coverage` → `htmlcov/`) como sitio estático en un bucket S3 del laboratorio de almacenamiento: es un artefacto más del pipeline.

## Al terminar

Termina las instancias y vacía los buckets que hayas creado, aunque el entorno del laboratorio sea temporal.
