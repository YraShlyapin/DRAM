<template>
    <div id="person">
        <titles title="Труппа"/>
        <div id="person_wrapper">
            <div v-for="(person,ind) in persons"
                :key="person.id_person"
                class="block_person"
                @click="style_set(ind)"
            >
                <img :src="'../upload/' + person.image" onerror="this.src = '../upload/not_found.png'">
                <div class="about_person">
                    <p class="name">{{ person.name }}, {{ years(person.birthday) }}</p>
                    <p class="text">{{ person.description }}</p>
                </div>
            </div>
        </div>
        <div v-for="person in persons"
                :key="person.id_person"
                class="block_person_view"
                @click="null_style"
            >
                <div class="block_person_view_wrapper">
                    <img :src="'../upload/' + person.image" onerror="this.src = '../upload/not_found.png'">
                    <div class="about_person">
                        <p class="name">{{ person.name }}</p>
                        <p>{{ birthday(person.birthday) }}</p>
                        <p class="text">{{ person.description }}</p>
                        <p class="role">{{ get_info(person.id_person) }}</p>
                    </div>
                </div>
            </div>
    </div>
</template>
<script>
    import titles from "./samples/title.vue"

    module.exports = {
        components: {
            titles
        },
        data: function() {
            return {
                persons: [],
                casts: []
            }
        },
        methods: {
            connect_db: function() {
                this.set_title("Труппа")
                this.$http.get("/personAPI")
                    .then(function(res) {
                        this.persons = res.body

                        
                    })
                this.$http.get("/castAPI")
                    .then(function(res) {
                        this.casts = res.body
                    })
            },
            style_set: function(id){
                document.querySelectorAll(".block_person_view")[id].classList.add('active_block_person')
                document.querySelector('html').classList.add('lock_person')
            },
            null_style: function(){
                document.querySelector(".active_block_person").classList.remove("active_block_person")
                document.querySelector('html').classList.remove('lock_person')
            },
            get_info(id_person){
                let arr = this.casts.filter((el) => {
                    return el.id_person == id_person
                })
                let str = ``
                if (arr[0]){
                    str = `Задействован(-a) в спектаклях:\n`
                    for (let obj of arr){
                        str += `${obj.title} - ${obj.role_person ? obj.role_person : 'не задано'}\n`
                    }
                }else {
                    str = `Не задействован в спектаклях`
                }
                return str
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>