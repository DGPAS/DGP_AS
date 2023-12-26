<?php
include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["idTask"]) && isset($_POST["idStudent"]) && isset($_POST["dateStart"]) && isset($_POST["dateEnd"])) {
    $idTask = $_POST["idTask"];
    $idStudent = $_POST["idStudent"];
    $dateStart = $_POST["dateStart"];
    $done = 0;
    $dateEnd = $_POST["dateEnd"];

    $query = "INSERT INTO `agenda`(`idTask`, `idStudent`, `done`, `dateStart`, `dateEnd`) VALUES (?, ?, ?, ?, ?)";

    $stmt = mysqli_prepare($con, $query);

    mysqli_stmt_bind_param($stmt, "iiiss", $idTask, $idStudent, $done, $dateStart, $dateEnd);

    $exe = mysqli_stmt_execute($stmt);

    $arr = [];

    if ($exe) {
        $arr["success"] = "true";
        $arr["idTareas"] = mysqli_insert_id($con); // Añade al array el idTareas (mysqli_insert_id devuelve el valor de una columna AUTO_INCREMENT actualizada, en nuestro caso idTareas)
    } else {
        $arr["success"] = "false";
        $arr["error"] = mysqli_error($con);
    }

    mysqli_stmt_close($stmt);

} else {
    $arr["success"] = "false";
}

print(json_encode($arr));
?>
