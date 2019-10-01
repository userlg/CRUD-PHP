<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Formulario</title>
</head>

<body>

    <div>
        <form method="POST">
            <div>
                <label>nombre</label>
                <input type="text" name="nombre" required>
                <hr>
            </div>

            <div>
                <label>apellido</label>
                <input type="text" name="apellido" required>
                <hr>
            </div>


            <div>
                <label>telefono</label>
                <input type="phone" name="telefono" required>
                <hr>
            </div>


            <div>
                <label>direccion</label>
                <input type="text" name="direccion" required>
                <hr>
            </div>

            <input type="submit" value="Enviar">
            <a href="index.php">Regresa</a>

        </form>

    </div>

    <?php
    include('conn.php');
    error_reporting(0);
    $name = $_POST['nombre'];
    $ln = $_POST['apellido'];
    $phone = $_POST['telefono'];
    $direccion = $_POST['direccion'];
    $conn = conectar();
    $hoy = date("Y-m-d ");

    if ($name != null) {
        $sql = "insert into cliente (nombre,apellido,telefono,direccion,fecha_insert) values ('" . $name . "','" . $ln . "','" . $phone . "','" . $direccion . "','" . $hoy . "');";

        $conn->query($sql);
        
        echo(mysqli_info($conn));
        header("location:index.php");
    }
    #echo ($sql);
    
    $conn->close();



    ?>

</body>

</html>