const slider_selector = ".posts__post__slider"
const left_button_selector = ".posts__post__slider__left-button"
const right_button_selector = ".posts__post__slider__right-button"
const image_selector = ".posts__post__slider__image"
const indicatorClassName = "posts__post__slider__indicator"

const home = document.getElementById("home")
const profile = document.getElementById("profile")
const add = document.getElementById("add")

home.onclick = function() {
    window.location.replace("home.php") 
}  
profile.onclick = function() {
    window.location.replace("profile")
}
add.onclick = function() {
    window.location.replace("addPost")
}

function updateSliders() {

    const sliders = document.querySelectorAll(slider_selector)

    for (let slider of sliders) {
        const left_button = slider.querySelector(left_button_selector)
        const right_button = slider.querySelector(right_button_selector)
        const images = slider.querySelectorAll(image_selector)
        let index = 1;
        let maxIndex = images.length

        let indicator = document.createElement("button")

        indicator.className = indicatorClassName
        indicator.setAttribute("disabled", "")
        
        showImg(index)

        if (maxIndex == 1) {
            left_button.style.display = "none"
            right_button.style.display = "none"
            indicator.style.display = "none"
        } else {
            left_button.style.display = "flex"
            right_button.style.display = "flex"
            indicator.style.display = "flex"
        }

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
            slider.appendChild(indicator)
        }
    }
}

document.addEventListener("DOMContentLoaded", updateSliders())