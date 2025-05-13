{

const titles = document.querySelectorAll(".posts__post__title")

for (let title of titles) {

    isMore = {value: true}

    if (title.scrollHeight > title.clientHeight) {
        let button = document.createElement("button")
        button.className = "posts__post__title__more"
        button.innerHTML = "ещё"
        button.addEventListener("click", handler)
        title.after(button)
    }

    function handler(event) {
        button = event.currentTarget
        if(isMore.value) {
            button.innerHTML = "свернуть"
            title.style.setProperty("-webkit-line-clamp", "100")
            isMore.value = false
        } else {
            button.innerHTML = "ещё"
            title.style.setProperty("-webkit-line-clamp", "2")
            isMore.value = true
        }

    }

}

}

