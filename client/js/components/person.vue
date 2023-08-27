<template>
    <div id="person">
        <titles title="Труппа"/>
        <div id="person_wrapper">
            <div class="block_person" @click="style_set">
                <img src="https://dummyimage.com/777x800/777/000" alt="">
                <div class="about_person">
                    <p class="name">Матвей Семагин</p>
                    <!-- <p>17 лет</p> -->
                    <p class="text">Владимир Золотарь родился в Ленинграде. В 1999 году окончил СПГАТИ (курс Геннадия Тростянецкого). Является основателем Санкт-Петербургского театра Михаила Чехова и одним из соучредителей Союза Правых театров России. Возглавлял в разные театры в Перми, Омске, Нижнем Новгороде, Барнауле.
                    </p>
                </div>
            </div>
            <div class="block_person" @click="style_set">
                <img src="https://dummyimage.com/777x800/777/000" alt="">
                <div class="about_person">
                    <p class="name">Матвей Семагин</p>
                    <!-- <p>17 лет</p> -->
                    <p class="text"> Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum totam cum minus sed cupiditate illo, porro odit delectus earum fugit quos voluptate est quod adipisci in non, iste ullam quaerat quisquam consequuntur! Dicta, reiciendis hic. Excepturi eveniet beatae mollitia odio sunt maiores iure facere, inventore, autem a harum tempore? Architecto, saepe! Non aperiam repellat officiis ab soluta impedit voluptates ea! Vel aut cumque, sunt eum esse minima delectus debitis obcaecati sed veritatis maxime eligendi iure itaque nobis repellendus unde, aspernatur suscipit commodi cum sequi deleniti? Commodi maxime nostrum natus possimus ipsam, blanditiis animi temporibus modi aperiam aliquam esse repellendus iure?</p>
                </div>
            </div>
            <div class="block_person" @click="style_set">
                <img src="https://dummyimage.com/777x800/777/000" alt="">
                <div class="about_person">
                    <p class="name">Матвей Семагин</p>
                    <!-- <p>17 лет</p> -->
                    <p class="text"> Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum totam cum minus sed cupiditate illo, porro odit delectus earum fugit quos voluptate est quod adipisci in non, iste ullam quaerat quisquam consequuntur! Dicta, reiciendis hic. Excepturi eveniet beatae mollitia odio sunt maiores iure facere, inventore, autem a harum tempore? Architecto, saepe! Non aperiam repellat officiis ab soluta impedit voluptates ea! Vel aut cumque, sunt eum esse minima delectus debitis obcaecati sed veritatis maxime eligendi iure itaque nobis repellendus unde, aspernatur suscipit commodi cum sequi deleniti? Commodi maxime nostrum natus possimus ipsam, blanditiis animi temporibus modi aperiam aliquam esse repellendus iure?</p>
                </div>
            </div>
            <div class="block_person" @click="style_set">
                <img src="https://dummyimage.com/777x800/777/000" alt="">
                <div class="about_person">
                    <p class="name">Матвей Семагин</p>
                    <!-- <p>17 лет</p> -->
                    <p class="text"> Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum totam cum minus sed cupiditate illo, porro odit delectus earum fugit quos voluptate est quod adipisci in non, iste ullam quaerat quisquam consequuntur! Dicta, reiciendis hic. Excepturi eveniet beatae mollitia odio sunt maiores iure facere, inventore, autem a harum tempore? Architecto, saepe! Non aperiam repellat officiis ab soluta impedit voluptates ea! Vel aut cumque, sunt eum esse minima delectus debitis obcaecati sed veritatis maxime eligendi iure itaque nobis repellendus unde, aspernatur suscipit commodi cum sequi deleniti? Commodi maxime nostrum natus possimus ipsam, blanditiis animi temporibus modi aperiam aliquam esse repellendus iure?</p>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    let titles = require("./samples/title.vue")

    module.exports = {
        components: {
            titles
        },
        methods: {
            style_set: function({ target }){
                let person = document.querySelector(".active_block_person")
                
                let tg = target
                
                while (!tg.classList.contains("block_person")){
                    tg = tg.parentNode
                }

                if (person === tg){
                    if (person !== null) person.classList.remove("active_block_person")
                } else{
                    if (person !== null) person.classList.remove("active_block_person")
                    tg.classList.add("active_block_person")
                }
            }
        }
    }
</script>