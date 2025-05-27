const title_selector = ".posts__post__title"
const buttonClassName = "posts__post__title__more"

const titles = document.querySelectorAll(title_selector)

function MoreButton() {
    for (let title of titles) {

        isMore = {value: true}

        if (title.scrollHeight > title.clientHeight) {
            let button = document.createElement("button")
            button.className = buttonClassName
            button.innerHTML = "ещё"
            button.addEventListener("click", handler)
            title.after(button)
        }

        function handler(event) {
            button = event.currentTarget
            if(isMore.value) {
                button.innerHTML = "свернуть"
                title.style.setProperty("height", "auto")
                isMore.value = false
            } else {
                button.innerHTML = "ещё"
                title.style.setProperty("height", "37px")
                isMore.value = true
            }

        }

    }
}

document.addEventListener("DOMContentLoaded", MoreButton)

