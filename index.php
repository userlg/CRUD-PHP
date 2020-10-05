<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>My Crud</title>
</head>

<body>
    <?php
    include('conn.php');
    $i = 1;
    $conn = conectar();

    $sql = "select ci,nombre,apellido from cliente";

    $resultado =  $conn->query($sql);
    
    $conn->query($sql);

    echo($conn->info);
    
    ?>

    <div>
        <a href="agregar.php">Nuevo</a>

        <table>
            <thead>
                <tr>
                    <th>Numero</th>
                    <th>CI</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($filas = $resultado->fetch_assoc()) {     ?>
                    <tr>
                        <td> <?php echo ($i); ?></td>
                        <td><?php echo ($filas['ci']); ?></td>
                        <td><?php echo ($filas['nombre']); ?></td>
                        <td><?php echo ($filas['apellido']); ?></td>
                        <td>
                            <a href="editar.php?ci=<?php echo ($filas['ci']) ;?>">Editar</a>
                            <a href="eliminar.php?ci=<?php echo($filas['ci']); ?>">Eliminar</a>
                        </td>
                    </tr>
                <?php $i++;
                }

                $resultado->free();
                $conn->close();
                #$conn = null;

                if (!$conn) {
                    echo ("Conexion  Cerrada");
                }
                ?>
            </tbody>
        </table>

    </div>

</body>

</html>