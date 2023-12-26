<?php

function dbconnection()
{
    $con = mysqli_connect("localhost", "root", "password", "D-ability");

    if (!$con) {
        die('Error de conexión: ' . mysqli_connect_error());
    }

    // Definir la variable $exe aquí para evitar el error de "Undefined variable"
    $exe = mysqli_query($con, "SELECT 1");

    if (!$exe) {
        die('Error en la consulta: ' . mysqli_error($con));
    }

    return $con;
}

?>
