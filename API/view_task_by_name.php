
<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
include("dbconnection.php");
$con=dbconnection();

if (isset($_POST["name"])) {
    $name = $_POST["name"];

    $query = "SELECT `idTasks` FROM `tasks` WHERE `name` = ?";

    // Preparar la sentencia
    $stmt = mysqli_prepare($con, $query);

    // Vincular parámetros
    mysqli_stmt_bind_param($stmt, "s", $name);

    // Ejecutar la sentencia
    $exe = mysqli_stmt_execute($stmt);

    if (!$exe) {
        $arr["success"] = "false";
        $arr["error"] = "Error en la consulta: " . mysqli_error($con);
        die('Error en la consulta: ' . mysqli_error($con));
    }

    mysqli_stmt_bind_result($stmt, $idTasks);

    // Obtener el resultado
    mysqli_stmt_fetch($stmt);

    $arr["idTasks"] = $idTasks;
    $arr["success"] = "true";

    // Cerrar la sentencia preparada
    mysqli_stmt_close($stmt);
    
} else {
    $arr["success"] = "false";
}

print(json_encode($arr));
?>