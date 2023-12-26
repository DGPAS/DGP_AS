<?php

include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["idStudent"]) && isset($_POST["idTask"])) {
    $idStudent = $_POST["idStudent"];
    $idTask = $_POST["idTask"];
} else {
    echo json_encode(["success" => false, "error" => "No idTasks provided"]);
    return;
}

$query1 = "DELETE FROM `agenda` WHERE `idTask`=? AND `idStudent`=?";
$stmt1 = mysqli_prepare($con, $query1);

if (!$stmt1) {
    echo json_encode(["success" => false, "error" => "Error in prepared statement: " . mysqli_error($con)]);
    return;
}

mysqli_stmt_bind_param($stmt1, "ii", $idTask, $idStudent);
$exe1 = mysqli_stmt_execute($stmt1);

$arr = [];
if ($exe1) {
    $arr["success"] = true;
} else {
    $arr["success"] = false;
    $arr["error"] = mysqli_error($con);
}

mysqli_stmt_close($stmt1);

echo json_encode($arr);

?>
