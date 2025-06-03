const leave_button_id = "leave";
const post_id_selector = ".posts__post__header__post-id"
const user_selector = ".posts__sidebar__user"
const edit__selector = ".posts__post__header__edit"
const like_selectorTrue = ".posts__post__likes_true"
const like_selectorFalse = ".posts__post__likes_false"
const TrueLike_ClassName = "posts__post__likes_true"
const FalseLike_ClassName = "posts__post__likes_false"

const likesApiURL = "../api/likes.php"
const editPageURL = "editPost.php?post-id="
const logoutURL = "../api/logout.php"

const post_selector = ".posts__post"
const posts = document.querySelectorAll(post_selector)
const leave_button = document.getElementById(leave_button_id)
const user = document.querySelector(user_selector)

handleBackground()

const editButtons = document.querySelectorAll(edit__selector)

leave_button.onclick = function() {
    window.location.replace(logoutURL)
}

posts.forEach(post => {
    const edit = post.querySelector(edit__selector)
    const post_id = post.querySelector(post_id_selector).innerHTML 
    edit.addEventListener("click", editHander)

    let like = post.querySelector(like_selectorTrue);
    if (like === null) {
        like = post.querySelector(like_selectorFalse)
    }

    like.addEventListener("click", likeHandler)

    function editHander() {
        window.location.replace(editPageURL + post_id)
    }
    async function likeHandler() {
        let json = {
            post_id
        }

        json = JSON.stringify(json);
        blob = new Blob([json], {type: "application/json"})

        let formData = new FormData();
        formData.append('json', blob); 

        const response = await fetch(likesApiURL, {
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
                like.className = TrueLike_ClassName
            } else if (isLiked === "true") {
                likesCount--
                like.className = FalseLike_ClassName
            }
            like.innerHTML = like.innerHTML.slice(0, 2) + likesCount
     
        } else {
            alert("Ошибка. Попробуйте ещё раз.")
        }
    }
});

function handleBackground() {
    letter = user.innerHTML
    let color

    switch(letter) {
        case 'А':
            color = "red"
            break
        case 'Б':
            color = "blue"
            break
        case 'В':
            color = "gray"
            break
        case 'Г':
            color = "green"
            break
        case 'Д':
            color = "orange"
            break
        case 'Е':
            color = "yellow"
            break
        default:
            color = "pink"
    }

    user.style.setProperty("background-color", color)
}



