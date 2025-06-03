<?php
    require_once("php/functionsSQL.php");
    $connection = connectDatabase();

    session_name('auth');
    session_start();
    if ($_SESSION != null) {
        $userId = $_SESSION['user_id'];
        $userName = $_SESSION['user_name'];
    } else {
        header("This user does not exist", true, 401);
        exit();
    }

?>
<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Лента</title>
        <link href="css/home.css" rel="stylesheet">   
        <script defer src="js/home.js"></script>
        <script defer src="js/slider.js"></script>
        <script defer src="js/modal.js"></script>
        <script defer src="js/more.js"></script>   
    </head>
    <body>
        <div class="posts">
            <div class="posts__sidebar">
                <img id="home" class="posts__sidebar__icon" src="images/Home 24.png">
                <img id="profile" class="posts__sidebar__icon" src="images/User 24.png">
                <img id="add" class="posts__sidebar__icon" src="images/Plus 24.png">
                <img id="leave" class="posts__sidebar__icon" src = "images/leave.png">
                <div class="posts__sidebar__user"><?=mb_substr($userName, 0, 1)?></div>
            </div>
            <?php
                if (!isset($_GET['id'])) {
                    $posts = findPostsInDatabase($connection, $userId); 
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
        <div class="modal">
        </div>  
    </body>
</html>