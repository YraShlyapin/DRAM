<template>
    <div id="person">
        <titles title="Труппа"/>
        <div id="person_wrapper">
            <div v-for="person in persons"
                :key="person.id_person"
                class="block_person"
                @click="style_set(person.id_person)"
            >
                <img :src="'../upload/' + person.image" onerror="this.src = '../upload/not_found.png'">
                <div class="about_person">
                    <p class="name">{{ person.name }}<!--, {{ years(person.birthday) }} --></p>
                    <p class="text">{{ person.description }}</p>
                </div>
            </div>
        </div>
        <div class="block_person_view" @click.self="null_style">
                <div class="block_person_view_wrapper">
                    <img :src="'../upload/' + current_person.image" onerror="this.src = '../upload/not_found.png'">
                    <div class="about_person">
                        <p class="name">{{ current_person.name }}</p>
                        <!--<p>{{ birthday(person.birthday) }}</p>-->
                        <p class="text">{{ current_person.description }}</p>
                        <p class="role">{{ current_cast.length > 0 ? "Задействован(-a) в спектаклях:\n" : "Скоро появятся в спектаклях"  }}<router-link v-if="current_cast" v-for="cast in current_cast":to="'/repertoire/' + cast.id_repertoire">{{cast.title}} - {{cast.role_person}}<br></router-link></p>
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
                casts: [],
                current_cast: [],
                current_person: {}
            }
        },
        methods: {
            connect_db: async function() {
                this.set_title("Труппа")
                await this.$http.get("/personAPI")
                    .then(function(res) {
                        this.persons = res.body
                    })
                await this.$http.get("/castAPI")
                    .then(function(res) {
                        this.casts = res.body
                    })
                return 0 
            },
            style_set: function(id){
                this.current_cast = this.casts.filter(e => e.id_person == id)
                this.current_person = this.persons.find(e => e.id_person == id)
                if (this.current_person){
                    document.querySelector(".block_person_view").classList.add('active_block_person')
                    document.querySelector('html').classList.add('lock_person')
                }
            },
            null_style: function(){
                document.querySelector(".active_block_person").classList.remove("active_block_person")
                document.querySelector('html').classList.remove('lock_person')
            }
        },
        mounted: async function() {
            await this.connect_db()
            if (this.$route.params.id){
                let id = this.$route.params.id
                this.$router.push("/persons")
                this.style_set(id)
            }
        },
        async beforeRouteUpdate(to, from, next)  {
            await this.connect_db()
            if (this.$route.params.id){
                let id = this.$route.params.id
                this.$router.push("/persons")
                this.style_set(id)
            }
            next()
        }
    }
</script>