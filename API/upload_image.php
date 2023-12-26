<?php

include("dbconnection.php");
$con = dbconnection();
$home = getenv('HOME');

    if (isset($_FILES['image']) && isset($_POST['idTask'])) {
        $image = $_FILES['image']['name'];
        $idTask = $_POST['idTask'];

        $imagePath = 'images/' . $image;
        $tmp_name = $_FILES['image']['tmp_name'];

        move_uploaded_file($tmp_name, $imagePath);

        $query = "UPDATE `tasks` SET `thumbnail`=? WHERE `idTask`=?";

        $stmt = mysqli_prepare($con, $query);
        
        mysqli_stmt_bind_param($stmt, "si", $image, $idTask);

        $exe = mysqli_stmt_execute($stmt);

        $arr = [];

        if ($exe) {
            $arr["success"] = "true";
            $arr["idTask"] = mysqli_insert_id($con);
        } else {
            $arr["success"] = "false";
            $arr["error"] = mysqli_error($con);
        }

        mysqli_stmt_close($stmt);
    }
    else {
        $arr["success"] = "false";
        die('Error de paso de parametros: ' . mysqli_error());
    }

print(json_encode($arr));


?>