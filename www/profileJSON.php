<?php
    function findUserWithId(array $users, int $id) {
        foreach ($users as $user) {
            if ($user['id'] == $id) {
                return $user;
            }
        }
        return null;
    }

    function countUserPosts(array $posts, array $user) : int {
        $counter = 0;
        foreach ($posts as $post) {
            if ($post['created_by'] == $user['id']) {
                $counter++;
            }
        }
        return $counter;
    }

    function redirectHome() {
        header("Location:homeJSON.php");
        exit();
    }
?>

<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Профиль</title>
        <link href="css/profile.css" rel="stylesheet">
    </head>
    <body>
        <?php
            $id = isset($_GET['id']) ? $id = $_GET['id'] : redirectHome();
            $users = json_decode(file_get_contents("json/users.json"), true);
            
            $user = findUserWithId($users, $id) != null ? $user = findUserWithId($users, $id) : redirectHome();

            require_once("php/validation.php");
            if (!validateUser($user)) {
                exit("Неверно переданные параметры пользователя");
            } 
            
            $posts = json_decode(file_get_contents("json/posts.json"), true);

            if (!validatePosts($posts)) {
                exit("Неверно переданные параметры постов");
            }
        ?>    
        <img class="avatar" src="<?php echo $user['avatar']?>" height="123" width="123">
        <h1><?php echo $user['name']; ?></h1>
        <p class="description"><?php echo $user['description']?></p> 
        <div class="num_posts">
            <img class="post_img" src="images/posts.png" height="16" width="16">
            <p class="text_posts"><?php echo countUserPosts($posts, $user) ?> поста(ов)</p>
        </div>
        <div class="pictures">
            <?php
                foreach ($posts as $post) {
                    if ($post['created_by'] == $user['id']) {
                        echo "<img style='margin-right: 5px' src='{$post['img']}'>";
                    }
                }
            ?>
        </div>
    </body>
</html>