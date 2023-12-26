<?php
include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["taskName"]) && isset($_POST["description"]) && isset($_POST["video"])) {
    $taskName = $_POST["taskName"];
    $description = $_POST["description"];
    $video = $_POST["video"];

    $query = "INSERT INTO `tasks`(`taskName`, `description`, `video`) VALUES (?, ?, ?)";

    $stmt = mysqli_prepare($con, $query);

    mysqli_stmt_bind_param($stmt, "sss", $taskName, $description, $video);

    $exe = mysqli_stmt_execute($stmt);

    $arr = [];

    if ($exe) {
        $arr["success"] = "true";
        $arr["idTask"] = mysqli_insert_id($con); // Añade al array el idTareas (mysqli_insert_id devuelve el valor de una columna AUTO_INCREMENT actualizada, en nuestro caso idTareas)
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
