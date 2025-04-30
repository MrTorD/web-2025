<?php

const Extension = ".jpg";

function checkParams($json) : bool {
    if ($_FILES['img']['type'] != 'image/jpeg' || $_FILES['img']['error'] != 0 || $_FILES['json']['error'] != 0) {
        return false;
    }
    if (!is_int($json['created_by']) || $json['created_by'] <= 0) {
        return false;
    }
    if (!is_int($json['likes']) || $json['likes'] < 0) {
        return false;
    }
    if (!is_string($json['title']) || strlen($json['title']) > 200) {
        return false;
    }
    return true;
}

function generateName($json) : string {
    return $json['created_by'].time();
}


$method = $_SERVER['REQUEST_METHOD'];
if ($method == "POST") {
    require_once("php/functionsSQL.php");
    $connection = connectDatabase();
    $json = [];
    $json = json_decode(file_get_contents($_FILES['json']['tmp_name']), true);

    if (checkParams($json)) {
        $name = generateName($json);
        $img = $name.Extension;
        $json['img'] = $img;
        move_uploaded_file($_FILES['img']['tmp_name'], PathToImg.$img); 
        /*echo $title = $json['title'].' ';
        echo $likes = $json['likes'].' ';
        echo $created_by = $json['created_by'].' ';
        echo $img = $json['img'].' ';*/
        echo savePostToDatabase($connection, $json);
    } else {
        echo "Неверный запрос";
    }

}  else {
    echo "Отправка только методом POST";
}  

?>