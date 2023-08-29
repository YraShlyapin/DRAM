<template>
    <div id="person">
        <titles title="Труппа"/>
        <div id="person_wrapper">
            <div v-for="person in persons"
                :key="person.id_person"
                class="block_person"
                @click=""
            >
                <img :src="'../upload/' + person.image" onerror="this.src = '../upload/not_found.png'">
                <div class="about_person">
                    <p class="name">{{ person.name }}, {{ Math.trunc((new Date() - new Date(person.birthday))/(24 * 3600 * 365.25 * 1000)) }}</p>
                    <p class="text">{{ person.description }}</p>
                </div>
            </div>
        </div>
        <div v-for="person in persons"
                :key="person.id_person"
                class="block_person_view active_block_person"
                @click=""
            >
                <div class="block_person_view_wrapper ">
                    <img :src="'../upload/' + person.image" onerror="this.src = '../upload/not_found.png'">
                    <div class="about_person">
                        <p class="name">{{ person.name }}, {{ Math.trunc((new Date() - new Date(person.birthday))/(24 * 3600 * 365.25 * 1000)) }}</p>
                        <p class="text">{{ person.description }}</p>
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
        data: function() {
            return {
                persons: []
            }
        },
        methods: {
            connect_db: function() {
                this.$http.get("/personAPI")
                    .then(function(res) {
                        this.persons = res.body
                    })
            },
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
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>