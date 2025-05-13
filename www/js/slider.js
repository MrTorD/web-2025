{
const home = document.getElementById("home")
const profile = document.getElementById("profile")
const add = document.getElementById("add")

home.onclick = function() {
    window.location.replace("home") 
}  
profile.onclick = function() {
    window.location.replace("profile")
}
add.onclick = function() {
    window.location.replace("addPost")
}

function slider() {

    const sliders = document.querySelectorAll(".posts__post__slider")

    for (let slider of sliders) {
        const left_button = slider.querySelector(".posts__post__slider__left-button")
        const right_button = slider.querySelector(".posts__post__slider__right-button")
        const images = slider.querySelectorAll(".posts__post__slider__image")
        let index = 1;
        let maxIndex = images.length


        let indicator = document.createElement("button")

        indicator.className = "posts__post__slider__indicator"
        indicator.setAttribute("disabled", "")
        
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
            slider.appendChild(indicator)
        }


    }

}

slider()
}