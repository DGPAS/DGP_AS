<?php

include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["steps"]) && isset($_POST["idTask"])) {
    
    $taskId = $_POST["idTask"];
    $steps = json_decode($_POST["steps"], true);

    // Obtener los IDs de la tabla steps que corresponden a la tarea actual
    $query_existing_ids = "SELECT `id`, `numStep` FROM `steps` WHERE `idTask`=?";
    $stmt_existing_ids = mysqli_prepare($con, $query_existing_ids);
    mysqli_stmt_bind_param($stmt_existing_ids, "i", $taskId);
    $exe_existing_ids = mysqli_stmt_execute($stmt_existing_ids);

    if (!$exe_existing_ids) {
        $arr["success"] = "false";
        $arr["error"] = "Error en la consulta SELECT: " . mysqli_error($con);
        die('Error en la consulta SELECT: ' . mysqli_error($con));
    }

    $result_existing_ids = mysqli_stmt_get_result($stmt_existing_ids);

    // Guardar los IDs existentes en un array asociativo
    $existing_ids = [];
    while ($row_existing_ids = mysqli_fetch_assoc($result_existing_ids)) {
        $existing_ids[$row_existing_ids["numStep"]] = $row_existing_ids["id"];
    }

    mysqli_stmt_close($stmt_existing_ids);

    // Recorrer los steps proporcionados y actualizar o insertar según sea necesario
    foreach ($steps as $step) {
        $stepNum = $step['numStep'];
        $description = $step['description'];
        $image = $step['image'];

        if (isset($existing_ids[$stepNum])) {
            // El paso ya existe, actualizar
            $id_to_update = $existing_ids[$stepNum];
            $query_update = "UPDATE `steps` SET `description`=?, `image`=? WHERE `id`=?";
            $stmt_update = mysqli_prepare($con, $query_update);
            mysqli_stmt_bind_param($stmt_update, "ssi", $description, $image, $id_to_update);
            $exe_update = mysqli_stmt_execute($stmt_update);

            if (!$exe_update) {
                $arr["success"] = "false";
                $arr["error"] = "Error en la consulta UPDATE: " . mysqli_error($con);
                die('Error en la consulta UPDATE: ' . mysqli_error($con));
            }

            mysqli_stmt_close($stmt_update);
        } else {
            // El paso no existe, insertar nuevo
            $query_insert = "INSERT INTO `steps` (`numStep`, `description`, `image`, `idTask`) VALUES (?, ?, ?, ?)";
            $stmt_insert = mysqli_prepare($con, $query_insert);
            mysqli_stmt_bind_param($stmt_insert, "issi", $stepNum, $description, $image, $taskId);
            $exe_insert = mysqli_stmt_execute($stmt_insert);

            if (!$exe_insert) {
                $arr["success"] = "false";
                $arr["error"] = "Error en la consulta INSERT: " . mysqli_error($con);
                die('Error en la consulta INSERT: ' . mysqli_error($con));
            }

            mysqli_stmt_close($stmt_insert);
        }
    }

    // Eliminar los steps que están en la base de datos pero no en la lista `steps`
    foreach ($existing_ids as $stepNum => $id_to_delete) {
        $delete_this_step = true;

        foreach ($steps as $step) {
            if ($step['numStep'] == $stepNum) {
                $delete_this_step = false;
                break;
            }
        }

        if ($delete_this_step) {
            $query_delete = "DELETE FROM `steps` WHERE `id`=?";
            $stmt_delete = mysqli_prepare($con, $query_delete);
            mysqli_stmt_bind_param($stmt_delete, "i", $id_to_delete);
            $exe_delete = mysqli_stmt_execute($stmt_delete);

            if (!$exe_delete) {
                $arr["success"] = "false";
                $arr["error"] = "Error en la consulta DELETE: " . mysqli_error($con);
                die('Error en la consulta DELETE: ' . mysqli_error($con));
            }

            mysqli_stmt_close($stmt_delete);
        }
    }

    $arr["success"] = "true";

} else {
    $arr["success"] = "false";
}

echo json_encode($arr);

?>
