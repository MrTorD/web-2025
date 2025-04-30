<?php

const PathToImg = "images/";

function connectDatabase(): PDO {
    $dsn = 'mysql:host=127.0.0.1;dbname=blog';
    $user = 'user';
    $password = '123';
    return new PDO($dsn, $user, $password);
}
function savePostToDatabase(PDO $connection, array $postParams) : int {
    $title = $postParams['title'];
    $likes = $postParams['likes'];
    $created_by = $postParams['created_by'];
    $img = $postParams['img'];
    $query = <<< SQL
            INSERT INTO 
                blog.post(
                    title,
                    likes,
                    created_by,
                    img
            )    
            VALUES(
                :title,
                :likes,
                :created_by,
                :img
            );    
            SQL;
   
    $statement = $connection->prepare($query);
    
    $statement->execute([
        ':title' => $postParams['title'],
        ':likes' => $postParams['likes'],
        ':created_by' => $postParams['created_by'],
        ':img' => $postParams['img']
    ]);

    return (int)$connection->LastInsertId();    
}


function findPostsInDatabase(PDO $connection) : array {    
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
            ;        
            SQL;
    $statement = $connection->query($query);
    $row = $statement->fetchAll(PDO::FETCH_ASSOC);
    if (!$row) {
        throw new RunTimeException("Post with id $id not found");
    }
    return $row ?: null;
}
function findPostInDatabase(PDO $connection, $id) : array {
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
                post_id = $id    
            ;        
            SQL;
    $statement = $connection->query($query);
    $row = $statement->fetchAll(PDO::FETCH_ASSOC);
    if (!$row) {
        throw new RunTimeException("Post with id $id not found");
    }
    return $row ?: null;
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
