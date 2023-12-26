<?php

include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["idTask"])) {

    $idTask = $_POST["idTask"];

    $currentDate = date('Y-m-d');

    $query = "UPDATE `agenda` SET `done`=1, `dateDone`=? WHERE `idTask`=?";

    $stmt = mysqli_prepare($con, $query);
        
    mysqli_stmt_bind_param($stmt, "si",$currentDate,$idTask);
    

    $exe = mysqli_stmt_execute($stmt);

    $arr = [];

    if ($exe) {
        $arr["success"] = "true";
    } else {
        $arr["success"] = "false";
        $arr["error"] = mysqli_error($con);
    }

    mysqli_stmt_close($stmt);
} else {
    $arr["success"] = "false";
}