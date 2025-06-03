const login_input_id = "email"
const password_input_id = "password"
const submit_selector = ".login-page__form__button"
const error_selector = ".login-page__form__error"

const loginApiURL = "../api/login.php"
const SuccessRedirect = "home.php"

const login_input = document.getElementById(login_input_id)
const password_input = document.getElementById(password_input_id)
const submit = document.querySelector(submit_selector)
const error = document.querySelector(error_selector)

const error_max_height = 100

submit.addEventListener('click', function(event) {
    event.preventDefault();
})
submit.addEventListener('click', logination)

async function logination() {

    const login = login_input.value
    const password = password_input.value

    let json = {
        login,
        password
    };
    json = JSON.stringify(json)

    blob = new Blob([json], {type: "application/json"})
    
    let formData = new FormData()
    formData.append('json', blob)

    const response = await fetch(loginApiURL, {
        method: "POST",
        body: formData
    })

    if(response.ok) {
        window.location.replace(SuccessRedirect)
    } else {
        createErrorWindow()
    }

    function createErrorWindow() {
        let height = 0
        error.style.display = "flex"

        interval = setInterval(upscaleHeight, 10)

        function upscaleHeight() {
            if (height <= error_max_height) {
                height++;
                error.style.setProperty("height", `${height}px`)
            } else {
                clearInterval(interval)
            }
        }

    }
}