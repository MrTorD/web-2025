const savePostApiURL = "api/savePost.php"

const inputImg_Id = "upload"
const inputText_selector = ".add-post__interface__add-title"
const submit_selector = ".add-post__interface__submit"
const startWindow_selector = ".add-post__interface__window__content"
const image_ClassName = "posts__post__slider__image"
const slider_select = ".posts__post__slider"
const slider_indicator_selector = ".posts__post__slider__indicator"
const add_post_selector = ".add-post__interface"
const success_windows_selector = ".success"

const submitEnabled_Background = "black"
const submitDisabled_Background = "#B4B4B4"

const inputImg = document.getElementById(inputImg_Id)
const inputText = document.querySelector(inputText_selector)
const submit = document.querySelector(submit_selector)
const startWindow = document.querySelector(startWindow_selector)
const slider = document.querySelector(slider_select)
const successWindow = document.querySelector(success_windows_selector)
const addPostWindow = document.querySelector(add_post_selector)

inputImg.addEventListener("change", slideHandler)
submit.addEventListener("click", submitHandler)

let images = []

isAnyPhoto = {value: false}
isAnyTitle = false

setInterval(enableSumbit, 1000, isAnyPhoto)

function slideHandler() {
    isAnyPhoto.value = true
    Array.from(inputImg.files).forEach(element => {
        images.push(element)
        let image = document.createElement("img")
        image.src = window.URL.createObjectURL(element)
        image.className = image_ClassName
        slider.style.display = "flex"
        slider.append(image)
        startWindow.remove()
        updateSlider()
    });
}

function submitHandler() {
    console.log(inputText.value)
    console.log(inputImg.files)
    sendPost(inputText.value, images)
}    

function enableSumbit(isAnyPhoto) {
    if (isAnyPhoto.value && inputText.value != "") {
        submit.disabled = false
        submit.style.setProperty("background-color", submitEnabled_Background)   
    } else {
        submit.disabled = true
        submit.style.setProperty("background-color", submitDisabled_Background)
    }

}

async function sendPost(text, images) {
    let json = {
        "likes": 0,
        "title": text,
    };
    json = JSON.stringify(json)

    blob = new Blob([json], {type: "application/json"})
    
    let formData = new FormData()
    formData.append('json', blob)

    for (let i = 0; i < images.length; i++) {
        formData.append('images[]', images[i])
    }

    const response = await fetch(savePostApiURL, {
        method: "POST",
        body: formData
    })

    if (response.ok) {
        successWindow.style.display = "flex"
        addPostWindow.style.display = "none"
    } else {
        alert("Ошибка, попробуйте ещё раз")
    }
}

function authBySession() {

}
  
function updateSlider() {

    const slider = document.querySelector(slider_selector)

    const left_button = slider.querySelector(left_button_selector)
    const right_button = slider.querySelector(right_button_selector)
    const images = slider.querySelectorAll(image_selector)
    
    let maxIndex = images.length
    let index = maxIndex;

    let indicator

    if (maxIndex < 1) {
        indicator = document.createElement("button")
    } else {
        indicator = slider.querySelector(slider_indicator_selector)
    }

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
