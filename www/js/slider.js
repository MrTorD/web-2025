{
const left_button = document.querySelector(".posts__post__slider__left-button")
const right_button = document.querySelector(".posts__post__slider__right-button")

const images =  document.querySelectorAll(".posts__post__slider__image")

let index = 1;
let maxIndex = images.length


let indicator = document.createElement("button")

indicator.className = "posts__post__slider__indicator"
indicator.setAttribute("disabled", "")


parent = document.querySelector(".posts__post__slider")

showImg(index)
changeIndicator(index)

left_button.onclick = function() {
    (index > 1) ? index-- : index = maxIndex
    showImg(index)
    changeIndicator(index)
}

right_button.onclick = function() {
    (index < maxIndex) ? index++ : index = 1
    showImg(index)
    changeIndicator(index)
}

function showImg(index) {
    for (let i = 1; i <= maxIndex; i++) {
        (i != index) ? images[i - 1].style.display = "none" : images[i - 1].style.display = "flex" 
    }
}

function changeIndicator(index) {
    indicator.innerHTML = index + '/' + maxIndex
    parent.appendChild(indicator)

}

}


