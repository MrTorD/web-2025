const modal_selector = ".modal" 
const exit_src = "images/cross.png"
const exit_ClassName = "modal__exit-button"
const slider_indicator_selector = ".posts__post__slider__indicator"
const modal_Indicator_ClassName = "modal__slider__indicator"
const slider_Indicator_ClassName = "posts__post__slider__indicator"

function modal() {
    const sliders = document.querySelectorAll(slider_selector)
    const modal = document.querySelector(modal_selector)
    const temp = document.createElement("div")

    for (let slider of sliders) {
        const exit = document.createElement("img")
        exit.setAttribute("src", exit_src)
        exit.className = exit_ClassName
        slider.prepend(exit)
        const indicator = slider.querySelector(slider_indicator_selector)

        const images = slider.querySelectorAll(image_selector)
        
        let isNotInModal = {value: false}

        for (let image of images) {
            image.onclick = function() {
                if (!isNotInModal.value) {
                    isNotInModal.value = true
                    exit.style.display = "inline"
                    modal.style.display = "inline-flex"
                    indicator.className = modal_Indicator_ClassName
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
            indicator.className = slider_Indicator_ClassName
        }
        function handler(event) {
            if (event.key == "Escape") {
                        isNotInModal.value = false
                temp.replaceWith(slider)
                exit.style.display = "none"
                modal.style.display = "none"
                indicator.className = slider_Indicator_ClassName 
            }
        }
    }
}

document.addEventListener("DOMContentLoaded", modal())