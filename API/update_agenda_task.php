<?php

include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["idTask"]) && isset($_POST["idStudent"])) {

    $idTask = $_POST["idTask"];
    $idStudent = $_POST["idStudent"];

    
    if (isset($_POST["done"]) && isset($_POST["dateStart"]) && isset($_POST["dateEnd"])) {
        $done = $_POST["done"];
        $dateStart = $_POST["dateStart"];
        $dateEnd = $_POST["dateEnd"];

        $query = "UPDATE `agenda` SET `done`=?, `dateStart`=?, `dateEnd`=? WHERE `idTask`=? AND `idStudent`=?";

        $stmt = mysqli_prepare($con, $query);
        
        mysqli_stmt_bind_param($stmt, "issii", $done, $dateStart, $dateEnd, $idTask, $idStudent);
    }
    else if (isset($_POST["done"])) {
        $done = $_POST["done"];
        $query = "UPDATE `agenda` SET `done`=? WHERE `idTask`=? AND `idStudent`=?";

        $stmt = mysqli_prepare($con, $query);
        
        mysqli_stmt_bind_param($stmt, "iii", $done, $idTask, $idStudent);
    }
    else if (isset($_POST["dateStart"])) {
        $dateStart = $_POST["dateStart"];
        $query = "UPDATE `agenda` SET `dateStart`=? WHERE `idTask`=? AND `idStudent`=?";

        $stmt = mysqli_prepare($con, $query);
        
        mysqli_stmt_bind_param($stmt, "sii", $dateStart, $idTask, $idStudent);
    }
    else {
        $dateEnd = $_POST["dateEnd"];
        $query = "UPDATE `agenda` SET `dateEnd`=? WHERE `idTask`=? AND `idStudent`=?";

        $stmt = mysqli_prepare($con, $query);
        
        mysqli_stmt_bind_param($stmt, "sii", $dateEnd, $idTask, $idStudent);
    }
    
    if (isset($_POST["done"]) || isset($_POST["dateStart"]) || isset($_POST["dateEnd"])) {
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