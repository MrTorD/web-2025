{

const slider = document.querySelector(".posts__post__slider")
const images = document.querySelectorAll(".posts__post__slider__image")
const modal = document.querySelector(".modal")
const indicator = document.querySelector(".posts__post__slider__indicator")
const post = document.querySelector(".posts__post")
const likes = document.querySelector(".posts__post__likes")

const exit_button = document.createElement('img')
exit_button.setAttribute("src", "images/cross.png")
exit_button.className = "modal__exit-button"

exit_button.onclick = function() {
    slider.className = "posts__post__slider"
    modal.style.display = "none"
    indicator.className = "posts__post__slider__indicator"
    post.insertBefore(slider, likes)
}

for (let image of images) {
    image.onclick = function() {
        slider.className = "modal__slider"
        modal.append(exit_button)
        modal.append(slider)
        modal.style.display = "inline-flex"
        indicator.className = "modal__slider__indicator"
    }    
}

}
