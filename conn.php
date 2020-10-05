<?php

function conectar()
{
$conn = mysqli_init();

$user="";
$pass="";
$addres="";
$db="";
$port="";

#Conexion tratando a $conn como un objeto

$conn->connect($addres,$user,$pass,$db,$port,'');

$conn->select_db($db);

#$conn = mysqli_connect($addres,$user,$pass,$db,$port) ;


if (!$conn){
    echo "Error al conectar con servidor";
}
else {
   # echo "Conexio exitosa";
}
    
    return $conn;
}
