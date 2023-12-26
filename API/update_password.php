<?php

include("dbconnection.php");
$con = dbconnection();

    if (isset($_FILES['pictogram1']) && isset($_FILES['pictogram2']) && isset($_FILES['pictogram3']) && isset($_POST['idStudent'])) {
        $pictogram1 = $_FILES['pictogram1']['name'];
        $pictogram2 = $_FILES['pictogram2']['name'];
        $pictogram3 = $_FILES['pictogram3']['name'];
        $idStudent = $_POST['idStudent'];

        $pictogram1Path = 'images/students/passwords/' . $pictogram1;
        $tmp_name1 = $_FILES['pictogram1']['tmp_name'];
        move_uploaded_file($tmp_name1, $pictogram1Path);

        $pictogram2Path = 'images/students/passwords/' . $pictogram2;
        $tmp_name2 = $_FILES['pictogram2']['tmp_name'];
        move_uploaded_file($tmp_name2, $pictogram2Path);

        $pictogram3Path = 'images/students/passwords/' . $pictogram3;
        $tmp_name3 = $_FILES['pictogram3']['tmp_name'];
        move_uploaded_file($tmp_name3, $pictogram3Path);

        $query = "UPDATE `passwordStudent` SET `pictogram1`=?, `pictogram2`=?, `pictogram3`=? WHERE `idStudent`=?";

        $stmt = mysqli_prepare($con, $query);

        mysqli_stmt_bind_param($stmt, "sssi", $pictogram1, $pictogram2, $pictogram3, $idStudent);

        $exe = mysqli_stmt_execute($stmt);

        $arr = [];

        if ($exe) {
            $arr["success"] = "true";
            $arr["idStudent"] = mysqli_insert_id($con);
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