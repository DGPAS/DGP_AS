<?php

include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["idTasks"])) {
    $idTasks = $_POST["idTasks"];
} else {
    echo json_encode(["success" => false, "error" => "No idTasks provided"]);
    return;
}

$query1 = "DELETE FROM `steps` WHERE idTask=?";
$query2 = "DELETE FROM `tasks` WHERE idTasks=?";
$stmt1 = mysqli_prepare($con, $query1);
$stmt2 = mysqli_prepare($con, $query2);

if (!$stmt1 || !$stmt2) {
    echo json_encode(["success" => false, "error" => "Error in prepared statement: " . mysqli_error($con)]);
    return;
}

mysqli_stmt_bind_param($stmt1, "i", $idTasks);
$exe1 = mysqli_stmt_execute($stmt1);

mysqli_stmt_bind_param($stmt2, "i", $idTasks);
$exe2 = mysqli_stmt_execute($stmt2);

$arr = [];
if ($exe1 && $exe2) {
    $arr["success"] = true;
} else {
    $arr["success"] = false;
    $arr["error"] = mysqli_error($con);
}

mysqli_stmt_close($stmt1);
mysqli_stmt_close($stmt2);

echo json_encode($arr);

?>
