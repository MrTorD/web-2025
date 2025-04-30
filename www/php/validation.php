<?php

function validateUser(array $user) : bool {
    if (!is_int($user['id']) || $user['id'] <= 0) {
        return false;
    }
    if (!is_string($user['name']) || strlen($user['name']) > 200) {
        return false;
    }
    if (!is_string($user['avatar']) || strlen($user['avatar']) > 200) {
        return false;
    }
    if (!is_string($user['description']) || strlen($user['description']) > 200) {
        return false;
    }

    return true;
}

function validatePosts(array $posts) : bool {
    foreach ($posts as $post) {
        if (!is_int($post['post_id']) || $post['post_id'] <= 0) {
            return false;
        }
        if (!is_int($post['created_by']) || $post['created_by'] <= 0) {
            return false;
        }
        if (!is_int($post['likes']) || $post['likes'] < 0) {
            return false;
        }
        if (!is_int($post['timestamp']) || $post['timestamp'] < 946674000 || $post['timestamp'] > 4102434000) {
            return false;
        }
        if (!is_string($post['img']) || strlen($post['img']) > 200) {
            return false;
        }
        if (!is_string($post['title']) || strlen($post['title']) > 200) {
            return false;
        }
    }
    return true;
}
?>