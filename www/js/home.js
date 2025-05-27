const user_id = 1

const post_id_selector = ".posts__post__header__post-id"
const edit__selector = ".posts__post__header__edit"
const like_selector = ".posts__post__likes_false"
const TrueLike = "posts__post__likes_true"
const FalseLike = "posts__post__likes_false"

const post_selector = ".posts__post"
const posts = document.querySelectorAll(post_selector)

const editButtons = document.querySelectorAll(edit__selector)

posts.forEach(post => {
    const edit = post.querySelector(edit__selector)
    const post_id = post.querySelector(post_id_selector).innerHTML 
    edit.addEventListener("click", editHander)

    const like = post.querySelector(like_selector)
    like.addEventListener("click", likeHandler)

    function editHander() {
        console.log(window.location.replace(`editPost.php?post-id=${post_id}`))
    }
    async function likeHandler() {
        let json = {
            user_id,
            post_id
        }

        json = JSON.stringify(json);
        blob = new Blob([json], {type: "application/json"})

        let formData = new FormData();
        formData.append('json', blob); 

        const response = await fetch("apiLikes.php", {
            method: "POST",
            body: formData
        })

        if(response.ok) {
            let isLiked = await response.text()

            heart = like.innerHTML[0]
            likesCountStr = like.innerHTML.slice(2)

            let likesCount = Number(likesCountStr)

            if (isLiked === "false") {
                likesCount++
                like.className = TrueLike
            } else {
                likesCount--
                like.className = FalseLike
            }
            console.log(like.innerHTML)
            like.innerHTML = like.innerHTML.slice(0, 2) + likesCount
     
        } else {
            alert("Ошибка. Попробуйте ещё раз.")
        }
    }
});



