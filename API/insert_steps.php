<?php
include("dbconnection.php");
$con = dbconnection();

$arr = [];

if (!$con) {
    $arr["success"] = "false";
    $arr["error"] = "Error de conexión a la base de datos";
} elseif (isset($_POST["numStep"]) && isset($_POST["idTask"]) && isset($_POST["description"]) && isset($_POST["image"])) {
    $numStep = $_POST["numStep"];
    $idTask = $_POST["idTask"];
    $description = $_POST["description"];
    $image = $_POST["image"];

    // Sentencia preparada
    $query = "INSERT INTO `steps`(`numStep`, `description`, `image`, `idTask`) VALUES (?, ?, ?, ?)";

    // Preparar la sentencia
    $stmt = mysqli_prepare($con, $query);

    if ($stmt) {
        // Vincular parámetros
        mysqli_stmt_bind_param($stmt, "issi", $numStep, $description, $image, $idTask);

        // Ejecutar la sentencia
        $exe = mysqli_stmt_execute($stmt);

        if ($exe) {
            $arr["success"] = "true";
        } else {
            $arr["success"] = "false";
            $arr["error"] = "Error en la inserción: " . mysqli_stmt_error($stmt);
        }

        // Cerrar la sentencia preparada
        mysqli_stmt_close($stmt);
    } else {
        $arr["success"] = "false";
        $arr["error"] = "Error en la preparación de la sentencia: " . mysqli_error($con);
    }
} else {
    $arr["success"] = "false";
    $arr["error"] = "Parámetros insuficientes";
}

print(json_encode($arr));
?>
