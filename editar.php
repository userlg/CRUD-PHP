<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Editar</title>
    <?php
    include('conn.php');

    error_reporting(0);

    $id = $_GET['ci'];

    $sql = "select * from cliente where ci = " . $id . ";";

    $conn = conectar();

    #echo ($sql);
    #echo ($id);
    $resultado = $conn->query($sql);

    $filas = $resultado->fetch_assoc();

    if ($filas) {
        $name = ($filas['NOMBRE']);
        $ln = ($filas['APELLIDO']);
        $phone = ($filas['TELEFONO']);
        $address = ($filas['DIRECCION']);
        $today = date("Y-m-d ");
    }



    ?>
</head>

<body>

    <div>
        <form method="POST">

            <input type="hidden" name="id" value="<?php echo ($filas['CI']); ?>">

            <div>
                <label>nombre</label>
                <input type="text" name="nombre" required value="<?php echo ($name); ?>">
                <hr>
            </div>

            <div>
                <label>apellido</label>
                <input type="text" name="apellido" required value="<?php echo ($ln); ?>">
                <hr>
            </div>


            <div>
                <label>telefono</label>
                <input type="phone" name="telefono" required value="<?php echo ($phone); ?>">
                <hr>
            </div>


            <div>
                <label>direccion</label>
                <input type="text" name="direccion" required value="<?php echo ($address) ?>">
                <hr>
            </div>

            <input type="submit" value="Actualizar">
            <a href="index.php">Regresa</a>

        </form>

        <?php
        $resultado->free();
        $conn->close();
        $name = "";
        $id = $_POST['id'];
        $name = $_POST['nombre'];
        $ln = $_POST['apellido'];
        $phone = $_POST['telefono'];
        $address = $_POST['direccion'];
        $conn = conectar();
        $sw = 1;

        $sql2 = "update cliente set NOMBRE ='" . $name . "', APELLIDO= '" . $ln . "' ,TELEFONO='" . $phone . "', DIRECCION='" . $address . "' , fecha_insert='" . $today . "'  where ci = " . $id . ";";

        #Prueba de la consulta que se imprime para verificar el query que se esta introduciendo
        #  echo($sql2);
        if ($name  || $ln || $phone || $address) {
            $conn->query($sql2);
            echo(mysqli_info($conn));
            if ($name) {
                header("location:index.php");
            }
        }

        $conn->close();



        ?>


</body>

</html>