function date_format(date){
    let formatter_Date = new Date(date)

    let day = formatter_Date.getDate()
    let month = formatter_Date.toLocaleString('ru',{month: 'long'})
    let year = formatter_Date.getFullYear()
    let weekday = formatter_Date.toLocaleString('ru',{weekday: 'long'})
    let Hours = formatter_Date.getHours()
    let minutes = formatter_Date.getMinutes()

    return `${day} ${month} ${year}, в ${Hours}:${Number(minutes) >=10 ? minutes : '0' + minutes }`
}

function time_format(time) {
    let str = `длительность `
    if (time > 70){
        str += `${~~(time/60)} часов ${time%60} минут`
    } else {
        str += `${time} минут`
    }
    return str
}

function date_get(){
    let date = new Date().toISOString().replace('T', ' ').split('.')[0].slice(0,-3)
    return date
}

function loadPreview(){
    let sf = document.querySelector("input[type='file']").files[0]
    let self = this
    let reader = new FileReader()
    reader.onload = function(re){
        self.srcc = re.target.result
    }
    reader.readAsDataURL(sf)
}
function onDrop(event){
    event.preventDefault()
    const file = event.dataTransfer.files
    document.querySelector("input[type='file']").files = file
    this.loadPreview()          
}

function years(date){
    let years = Math.trunc((new Date() - new Date(date))/(24 * 3600 * 365.25 * 1000))
    return years
}

function birthday(date){
    let birthday = new Date(date).toLocaleDateString()
    
    return `${birthday}, (${years(date)})`
}

module.exports = {
    install(Vue, options) {
        Vue.prototype.date_format = date_format
        Vue.prototype.time_format = time_format
        Vue.prototype.date_get = date_get
        Vue.prototype.loadPreview = loadPreview
        Vue.prototype.onDrop = onDrop
        Vue.prototype.years = years
        Vue.prototype.birthday = birthday
    }
}