<?php

include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["idTask"])) {

    $idTask = $_POST["idTask"];

    if (isset($_POST["taskName"]) && isset($_POST["description"])) {
        $taskName = $_POST["taskName"];
        $description = $_POST["description"];

        $query = "UPDATE `tasks` SET `taskName`=?, `description`=? WHERE `idTask`=?";

        $stmt = mysqli_prepare($con, $query);
        
        mysqli_stmt_bind_param($stmt, "ssi", $taskName, $description, $idTask);
    }
    else if (isset($_POST["taskName"])) {
        $taskName = $_POST["taskName"];

        $query = "UPDATE `tareas` SET `taskName`=? WHERE `idTask`=?";

        $stmt = mysqli_prepare($con, $query);
        
        mysqli_stmt_bind_param($stmt, "si", $taskName, $idTask);
    }
    
    else {
        $description = $_POST["description"];

        $query = "UPDATE `tasks` SET `description`=? WHERE `idTask`=?";

        $stmt = mysqli_prepare($con, $query);
        
        mysqli_stmt_bind_param($stmt, "si", $description, $idTask);
    }

    if (isset($_POST["taskName"]) || isset($_POST["description"])) {

        $exe = mysqli_stmt_execute($stmt);

        $arr = [];

        if ($exe) {
            $arr["success"] = "true";
        } else {
            $arr["success"] = "false";
            $arr["error"] = mysqli_error($con);
        }

        mysqli_stmt_close($stmt);
    }
} else {
    $arr["success"] = "false";
}