{

const inputImg = document.getElementById("upload")
inputImg.addEventListener("change", slideHandler)

const inputText = document.querySelector(".add-post__interface__add-title")

const submit = document.querySelector(".add-post__interface__submit")
submit.addEventListener("click", submitHandler)

const startWindow = document.querySelector(".add-post__interface__window__content")

const slider = document.querySelector(".posts__post__slider")

isAnyPhoto = {value: false}
isAnyTitle = false

setInterval(enableSumbit, 1000, isAnyPhoto)

function slideHandler() {
    isAnyPhoto.value = true
    images = inputImg.files
    for (let i = 0; i < images.length; i++) {
        let image = document.createElement("img")
        image.src = window.URL.createObjectURL(images[i])
        image.className = "posts__post__slider__image"
        slider.style.display = "flex"
        slider.append(image)
        startWindow.remove()
        updateSlider()
    }
}

function submitHandler() {
    console.log(inputText.value)
    console.log(inputImg.files)
}    

function enableSumbit(isAnyPhoto) {
    if (isAnyPhoto.value && inputText.value != "") {
        submit.disabled = false
        submit.style.setProperty("background-color", "black")   
    } else {
        submit.disabled = true
        submit.style.setProperty("background-color", "#B4B4B4")
    }

}
    
function updateSlider() {

    const slider = document.querySelector(".posts__post__slider")

    const left_button = slider.querySelector(".posts__post__slider__left-button")
    const right_button = slider.querySelector(".posts__post__slider__right-button")
    const images = slider.querySelectorAll(".posts__post__slider__image")
    
    let maxIndex = images.length
    let index = maxIndex;

    let indicator

    if (maxIndex < 1) {
        indicator = document.createElement("button")
    } else {
        indicator = slider.querySelector(".posts__post__slider__indicator")
    }

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