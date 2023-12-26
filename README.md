<?php

include("dbconnection.php");
$con = dbconnection();

if (
    isset($_FILES['pictogram1']) &&
    isset($_FILES['pictogram2']) &&
    isset($_FILES['pictogram3']) &&
    isset($_FILES['pictogram4']) &&
    isset($_FILES['pictogram5']) && 
    isset($_FILES['pictogram6']) &&
    isset($_POST['idStudent']) &&
    isset($_POST['pass'])  // Agregado el campo 'pass'
) {
    $pictogram1 = $_FILES['pictogram1']['name'];
    $pictogram2 = $_FILES['pictogram2']['name'];
    $pictogram3 = $_FILES['pictogram3']['name'];
    $pictogram4 = $_FILES['pictogram4']['name'];
    $pictogram5 = $_FILES['pictogram5']['name'];
    $pictogram6 = $_FILES['pictogram6']['name'];
    $idStudent = $_POST['idStudent'];
    $pass = $_POST['pass'];  // Nuevo campo 'pass'

    $pictogram1Path = 'images/' . $pictogram1;
    $tmp_name1 = $_FILES['pictogram1']['tmp_name'];
    move_uploaded_file($tmp_name1, $pictogram1Path);

    $pictogram2Path = 'images/' . $pictogram2;
    $tmp_name2 = $_FILES['pictogram2']['tmp_name'];
    move_uploaded_file($tmp_name2, $pictogram2Path);

    $pictogram3Path = 'images/' . $pictogram3;
    $tmp_name3 = $_FILES['pictogram3']['tmp_name'];
    move_uploaded_file($tmp_name3, $pictogram3Path);

    $pictogram4Path = 'images/' . $pictogram4;
    $tmp_name4 = $_FILES['pictogram4']['tmp_name'];
    move_uploaded_file($tmp_name4, $pictogram4Path);

    $pictogram5Path = 'images/' . $pictogram5;
    $tmp_name5 = $_FILES['pictogram5']['tmp_name'];
    move_uploaded_file($tmp_name5, $pictogram5Path);

    $pictogram6Path = 'images/' . $pictogram6;
    $tmp_name6 = $_FILES['pictogram6']['tmp_name'];
    move_uploaded_file($tmp_name6, $pictogram6Path);

    $query = "INSERT INTO `passwordstudent`(`idStudent`, `pictogram1`, `pictogram2`, `pictogram3`, `pictogram4`, `pictogram5`, `pictogram6`, `pass`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    $stmt = mysqli_prepare($con, $query);

    mysqli_stmt_bind_param($stmt, "isssssss", $idStudent, $pictogram1, $pictogram2, $pictogram3, $pictogram4, $pictogram5, $pictogram6, $pass);

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
} else {
    $arr["success"] = "false";
    die('Error de paso de parametros: ' . mysqli_error());
}

print(json_encode($arr));

?>
