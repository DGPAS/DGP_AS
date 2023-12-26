
<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
include("dbconnection.php");
$con=dbconnection();

// $currentDate = date('Y-m-d');

if (isset($_GET["idStudent"])) {
    $idStudent = $_GET["idStudent"];

    // Join of both tables to get all the task attributes that belongs to the student with idStudent 
    $query = "SELECT agenda.id, agenda.idStudent, tasks.taskName, tasks.description, tasks.thumbnail, tasks.video, 
                    agenda.idTask, agenda.done, agenda.dateStart, agenda.dateEnd FROM `agenda` INNER JOIN `tasks`
                    ON agenda.idTask = tasks.idTask WHERE agenda.idStudent = ?";

    // Preparar la sentencia
    $stmt = mysqli_prepare($con, $query);

    // Vincular parámetros
    mysqli_stmt_bind_param($stmt, "i", $idStudent);

    // Ejecutar la sentencia
    $exe = mysqli_stmt_execute($stmt);

    if (!$exe) {
        die('Error en la consulta: ' . mysqli_error($con));
    }

    $result = mysqli_stmt_get_result($stmt);


    while($row=mysqli_fetch_assoc($result))
    {
        $arr[]=$row;
    }

    // Cerrar la sentencia preparada
    mysqli_stmt_close($stmt);
    
} else {
    die('Error en la consulta: ' . mysqli_error($con));}

print(json_encode($arr));
?>