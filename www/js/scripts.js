function isPrimeNumber(nums) {
   if (typeof nums == "number") {
        if (isPrime(nums)) {
            return `${nums} - простое число`
        } else  {
            return `${nums} - не простое число`
        } 
   } else if (typeof nums == "object") {
        let Primes = []
        let NotPrimes = []
        nums.forEach(element => {
            if (isPrime(element)) {
                Primes.push(element)
            } else {
                NotPrimes.push(element)
            }
        })
        return `${Primes} - простые числа; ${NotPrimes} - не простые числа`
   } else {
        console.log ("Аргумент должен быть числом или массивом")
   }
   function isPrime(num) {
    for (let i = 2; i < num; i++) {
        if (num % i == 0) {
            return false
        }
    }
    return true
}
}

function countVowels(str) {
   
    if (typeof str == "string") {
        const vowels = ["а", "е", "ё", "и", "о", "у", "ы", "э", "ю", "я"]
        let foundedVowels = []
        
        str = str.toLowerCase()

        for (let i = 0; i < str.length; i++) {
            if (vowels.includes(str[i])) { 
                foundedVowels.push(str[i])
            }
        }

        if (foundedVowels.length !== 0) {
            let vowelsString = foundedVowels[0]
            for (let i = 1; i < foundedVowels.length; i++) {
                vowelsString += `, ${foundedVowels[i]}`
            }    
            return `${foundedVowels.length} (${vowelsString})`
        } else {
            return "0"
        } 
    } else {
        console.log("Ошибка. Аргумент должен быть строкой")
    }    
}

function uniqueElements(array) {

    if (typeof array == "object") {

        let obj = {}

        array.forEach(element => {
            if (!(element in obj)) {
                obj[element] = 1
            } else {
                obj[element] += 1
            }
        })
        return obj
    } else {
        console.log("Ошибка. Аргумент должен быть массивом")
    }
}

function mergeObjects (obj1, obj2) {

    if (typeof obj1 == "object" && typeof obj2 == "object") {
        for (let key in obj1) {
            if(obj2[key] === undefined) {
                obj2[key] =  obj1[key]
            }
        }
        return obj2
    } else {
        console.log("Ошибка. Аргументы должны быть объектами")
    }
}

function createArrayNames(array) {
    if (typeof array == "object") {
        const names = array.map(array => array.name);
        return names
    } else {
        console.log("Ошибка. Аргумент должен быть массивом")
    }
}

function mapObject(obj, callback) {
    if (typeof obj == "object" && typeof callback == "function") {
        for (let key in obj) {
            obj[key] = callback(obj[key])
        }
        return obj
    } else {
        console.log("Аргументы должны быть соответственно объектом и функцией")
    }
}

function generatePassword(length) {
    
    if (typeof length == "number" && length >= 4) {
        
        const lowLetters = "abcdefghijklmnopqrstuvwxyz"
        const upperLetters = "ABCEFGHIJKLMNOPQRSTUVWXYZ"
        const digits = "0123456789"
        const specialSymbols = "!@#$%^&*()_+=-/.%?"
        const allSymbols = lowLetters + upperLetters + digits + specialSymbols

        let password = ""

        for (let i = 0; i < length; i++) {
            password += allSymbols[(Math.floor(allSymbols.length * Math.random()))]
        }

        let NecessaryPart = lowLetters[Math.floor(lowLetters.length * Math.random())] + upperLetters[Math.floor(upperLetters.length * Math.random())] 
        + digits[Math.floor(digits.length * Math.random())] + specialSymbols[Math.floor(specialSymbols.length * Math.random())]

        let InsertionPoint = Math.floor((password.length - 4) * Math.random())

        password = password.replace(password[InsertionPoint] + password[InsertionPoint + 1] + password[InsertionPoint + 2] + password[InsertionPoint + 3], NecessaryPart)
        
        return password
    
    } else {
        console.log("Ошибка. Длина должна быть числом не менее 4")
    }
}

function mapAndFilterArray(array, map, filter) {
    if (typeof array == "object" && typeof map == "function" && typeof filter == "function") {
        array = array.map(map)
        array = array.filter(filter)
        return array 
    } else {
        console.log("Неверно переданные аргументы")
    }
}