{
const sliders = document.querySelectorAll(".posts__post__slider")
const modal = document.querySelector(".modal")

const temp = document.createElement("div")



for (let slider of sliders) {
    const exit = document.createElement("img")
    exit.setAttribute("src", "images/cross.png")
    exit.className = "modal__exit-button"
    slider.prepend(exit)
    const indicator = slider.querySelector(".posts__post__slider__indicator")

    const images = slider.querySelectorAll(".posts__post__slider__image")
    
    let isNotInModal = {value: false}

    for (let image of images) {
        image.onclick = function() {
            if (!isNotInModal.value) {
                isNotInModal.value = true
                exit.style.display = "inline"
                modal.style.display = "inline-flex"
                indicator.className = "modal__slider__indicator"
                slider.after(temp)
                modal.append(slider)
                document.addEventListener("keydown", handler)
            } 
        }
    }

    exit.onclick = function exit_Modal() {
        isNotInModal.value = false
        temp.replaceWith(slider)
        exit.style.display = "none"
        modal.style.display = "none"
        indicator.className = "posts__post__slider__indicator"  
    }
    function handler(event) {
        if (event.key == "Escape") {
                    isNotInModal.value = false
            temp.replaceWith(slider)
            exit.style.display = "none"
            modal.style.display = "none"
            indicator.className = "posts__post__slider__indicator"  
        }
    }
    

}

}    
