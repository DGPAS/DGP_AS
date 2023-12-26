<?php
include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["firstName"]) && isset($_POST["lastName"]) && isset($_POST["picture"]) && isset($_POST["text"]) && isset($_POST["audio"]) && isset($_POST["video"])) {
    $name = $_POST["firstName"];
    $lastName = $_POST["lastName"];
    $picture = $_POST["picture"];
    $text = $_POST["text"];
    $audio = $_POST["audio"];
    $video = $_POST["video"];

    $query = "INSERT INTO `student`(`firstName`, `lastName`, `picture`, `text`, `audio`, `video`) VALUES (?, ?, ?, ?, ?, ?)";

    $stmt = mysqli_prepare($con, $query);

    mysqli_stmt_bind_param($stmt, "sssiii", $name, $lastName, $picture, $text, $audio, $video);


    $exe = mysqli_stmt_execute($stmt);

    $arr = [];

    if ($exe) {
        $arr["success"] = "true";
        $arr["idStudent"] = mysqli_insert_id($con); // Añade al array el idTareas (mysqli_insert_id devuelve el valor de una columna AUTO_INCREMENT actualizada, en nuestro caso idTareas)

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
