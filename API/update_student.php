<?php

include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["idStudent"]) && isset($_POST["firstName"]) && isset($_POST["lastName"]) && isset($_POST["text"]) && isset($_POST["audio"]) && isset($_POST["video"])) {

    $idStudent = $_POST["idStudent"];
    $name = $_POST["firstName"];
    $lastName = $_POST["lastName"];
    $text = $_POST["text"];
    $audio = $_POST["audio"];
    $video = $_POST["video"];

    $query = "UPDATE `student` SET `firstName`=?, `lastName`=?, `text`=?, `audio`=?, `video`=? WHERE `id`=?";

    $stmt = mysqli_prepare($con, $query);
        
    mysqli_stmt_bind_param($stmt, "ssiiii", $name, $lastName, $text, $audio, $video, $idStudent);    

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