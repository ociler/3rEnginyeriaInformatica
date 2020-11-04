console.log("5"+2)
console.log("5"-2)
console.log(5+[1,2,3])

var x //nvm si poses let o var
console.log(x)

if(typeof x == "undefined")
    console.log("XD")
else
    console.log("encara mes XD")

if(x == null) console.log("es null xd")

console.log("6" == 6)
console.log(Boolean(undefined))

let person = {name : "Cholvi",
              age: 20,
              uwu: {
                  owo: "UwU",
                  uwuwu: "OwO"
              }
}

for(let i in person) {
    console.log("Esaes la propiedah " + i + " con valoh " + person[i])
    if(typeof person[i] == "object") {
        for(let j in person[i])
        console.log("Esaes la propiedah " + j + " de " + i + " con valoh " + person[i][j])
    }
}