<?php

const PathToImg = "images/";

function connectDatabase(): PDO {
    $dsn = 'mysql:host=127.0.0.1;dbname=blog';
    $user = 'user';
    $password = '123';
    return new PDO($dsn, $user, $password);
}

function changeLikeState(PDO $connection, $post_id, $user_id) {
    $query = <<< SQL
            SELECT 
                post_id
            FROM    
                blog.likes
            WHERE 
                liked_by = $user_id    
            SQL;

    $statement = $connection->query($query);
    $like = $statement->fetch(PDO::FETCH_ASSOC);

    if ($like == null) {
        $query = <<< SQL
                INSERT INTO
                    blog.likes(
                        post_id,
                        liked_by
                    )
                VALUES(
                    $post_id,
                    $user_id
                )
                SQL;
        $isLiked = false;        
    } else {
        $query = <<< SQL
                DELETE FROM
                    blog.likes
                WHERE
                    liked_by = $user_id    
                SQL;
        $isLiked = true;        
    }

    $statement = $connection->exec($query);

    return $isLiked;
    
}

function deletePostFromDataBase(PDO $connection, $post_id) {
    $query = <<< SQL
            DELETE FROM
                blog.post
            WHERE
                post_id = $post_id
            ;        
            SQL;
    $statement = $connection->exec($query); 

    $query = <<< SQL
        DELETE FROM
            blog.images
        WHERE
            post_id = $post_id
        ;        
        SQL;
    $statement = $connection->exec($query);        
}

function savePostToDatabase(PDO $connection, array $postParams) : int {
    $title = $postParams['title'];
    $likes = $postParams['likes'];
    $created_by = $postParams['created_by'];
    $images = $postParams['images'];
    $query = <<< SQL
            INSERT INTO 
                blog.post(
                    title,
                    likes,
                    created_by
            )    
            VALUES(
                :title,
                :likes,
                :created_by
            );
            SQL;
   
    $statement = $connection->prepare($query);
    
    $statement->execute([
        ':title' => $postParams['title'],
        ':likes' => $postParams['likes'],
        ':created_by' => $postParams['created_by'],
    ]);

    $postId = (int)$connection->LastInsertId();  

    saveImages($connection, $images, $postId);

    return (int)$connection->LastInsertId();
}

function saveImages(PDO $connection, $images, $post_id) {
    $query = <<< SQL
            INSERT INTO 
                blog.images(
                    post_id,
                    img
            )    
            VALUES(
                :post_id,
                :img
            );
            SQL;
    
    $statement = $connection->prepare($query);

    foreach($images as $img) {
        $statement->execute([
            ':post_id' => $post_id,
            'img' => $img
        ]);
    }
}

function findPostsInDatabase(PDO $connection) : array {    
    $query = <<< SQL
            SELECT 
                post_id,
                title,
                created_by,
                created_at,
                name,
                avatar,
                likes
            FROM
                blog.post
                JOIN blog.user ON blog.user.id = blog.post.created_by
            ;        
            SQL;
    $statement = $connection->query($query);
    $posts = $statement->fetchAll(PDO::FETCH_ASSOC);

    if (!$posts) {
        throw new RunTimeException("Post with id $id not found");
    }

    $query = <<< SQL
            SELECT 
                post_id,
                img
            FROM
                blog.images
            ;        
            SQL;

    $statement = $connection->query($query);
    $images = $statement->fetchAll(PDO::FETCH_ASSOC);

    foreach ($posts as &$post) {
        $post['images'] = [];
        foreach ($images as $image) {
            if ($post['post_id'] == $image['post_id']) {
                array_push($post['images'], $image['img']);
            }
        }
    }

    return $posts;
}
function findPostInDatabase(PDO $connection, $id) : array {
    $query = <<< SQL
            SELECT 
                title,
                created_by,
                created_at,
                name,
                avatar,
                likes
            FROM
                blog.post
                JOIN blog.user ON blog.user.id = blog.post.created_by
            WHERE
                post_id = $id    
            ;        
            SQL;
    $statement = $connection->query($query);
    $post = $statement->fetch(PDO::FETCH_ASSOC);
    if (!$post) {
        throw new RunTimeException("Post with id $id not found");
    }

    $query = <<< SQL
            SELECT 
                img
            FROM
                blog.images    
            WHERE
                post_id = $id    
            ;
            SQL;
    $statement = $connection->query($query);
    $images = $statement->fetchAll(PDO::FETCH_ASSOC);
    if (!$images) {
        throw new RunTimeException("Images not found");
    }

    $post['images'] = [];
    foreach ($images as $image) {
        array_push($post['images'], $image['img']);
    }

    return $post;
}
function findUserPostsInDatabase(PDO $connection, $user_id) : array {
    $query = <<< SQL
            SELECT 
                title,
                created_by,
                created_at,
                img,
                name,
                avatar,
                likes
            FROM
                blog.post
                JOIN blog.user ON blog.user.id = blog.post.created_by
            WHERE
                created_by = $user_id    
            ;        
            SQL;
    $statement = $connection->query($query);
    $row = $statement->fetchAll(PDO::FETCH_ASSOC);
    if (!$row) {
        throw new RunTimeException("Post with id $user_id not found");
    }
    return $row ?: null;
}

function findUserInDatabase(PDO $connection, int $id) : array {
    $query = <<< SQL
            SELECT 
                name,
                avatar,
                description
            FROM
                blog.user
            WHERE 
                id = $id    
            ;        
            SQL;
    $statement = $connection->query($query);
    $row = $statement->fetch(PDO::FETCH_ASSOC);
    if (!$row) {
        throw new RunTimeException("Post with id $id not found");
    }
    return $row ?: null;
}
?>
