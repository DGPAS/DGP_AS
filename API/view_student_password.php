
<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
include("dbconnection.php");
$con=dbconnection();

if (isset($_GET["idStudent"])) {
    $idStudent = $_GET["idStudent"];

    $query = "SELECT `pictogram1`, `pictogram2`,`pictogram3` FROM `passwordStudent` WHERE `idStudent` = ? LIMIT 1";

    // Preparar la sentencia
    $stmt = mysqli_prepare($con, $query);

    // Vincular parámetros
    mysqli_stmt_bind_param($stmt, "i", $idStudent);

    // Ejecutar la sentencia
    $exe = mysqli_stmt_execute($stmt);

    if (!$exe) {
        $arr["success"] = "false";
        $arr["error"] = "Error en la consulta: " . mysqli_error($con);
        die('Error en la consulta: ' . mysqli_error($con));
    }

    $arr["success"] = "true";

    $result = mysqli_stmt_get_result($stmt);

    $arr["data"] = mysqli_fetch_assoc($result);

    // Cerrar la sentencia preparada
    mysqli_stmt_close($stmt);
    
} else {
    $arr["success"] = "false";
}

print(json_encode($arr));
?>