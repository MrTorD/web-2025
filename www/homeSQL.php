<?php
    require_once("php/functionsSQL.php");
    $connection = connectDatabase();
?>
<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Лента</title>
        <link href="css/home.css" rel="stylesheet">      
    </head>
    <body>
        <div>
            <?php
                if (!isset($_GET['id'])) {
                    $posts = findPostsInDatabase($connection); 
                } else {
                    $id = $_GET['id'];
                    try {
                        $posts = findUserPostsInDatabase($connection, $id);
                    } catch (RunTimeException) {
                        $posts = findPostsInDatabase($connection);
                    }
                }

                foreach ($posts as $post) {
                    include("php/sampleSQL.php");
                }         
            ?>
        </div>    
    </body>
</html>