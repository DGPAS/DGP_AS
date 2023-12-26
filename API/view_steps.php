
<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
include("dbconnection.php");
$con=dbconnection();

if (isset($_GET["idTask"])) {
    $idTask = $_GET["idTask"];

    $query = "SELECT * FROM `steps` WHERE `idTask` = ?";

    // Preparar la sentencia
    $stmt = mysqli_prepare($con, $query);

    // Vincular parámetros
    mysqli_stmt_bind_param($stmt, "i", $idTask);

    // Ejecutar la sentencia
    $exe = mysqli_stmt_execute($stmt);

    if (!$exe) {
        die('Error en la consulta: ' . mysqli_error($con));
    }

    $result = mysqli_stmt_get_result($stmt);

    $arr=[];
    while($row=mysqli_fetch_assoc($result))
    {
        $arr[]=$row;
    }

    // Cerrar la sentencia preparada
    mysqli_stmt_close($stmt);
    
} else {
    die('Error en la consulta: ' . mysqli_error($con));
}

print(json_encode($arr));
?>