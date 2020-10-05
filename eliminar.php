<div>

    <?php
    include('conn.php');

    $id = $_GET['ci'];

    $sql = " delete from cliente where ci=" . $id . ";";

    $conn=conectar();

   if ($conn!=null){
      $conn->query($sql);
      echo(mysqli_info($conn));
      $num = $conn->affected_rows;
      echo("Numero de Filas Afectadas--> $num");
       $conn->close();
    }
  
    header("location:index.php");

    ?>



</div>