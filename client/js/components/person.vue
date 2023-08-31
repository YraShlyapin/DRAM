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
                    <p class="name">{{ person.name }}, {{ Math.trunc((new Date() - new Date(person.birthday))/(24 * 3600 * 365.25 * 1000)) }}</p>
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
                        <p>{{ new Date(person.birthday).toLocaleDateString() }}, ({{ Math.trunc((new Date() - new Date(person.birthday))/(24 * 3600 * 365.25 * 1000)) }})</p>
                        <p class="text">{{ person.description }}</p>
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
            style_set: function(id){
                document.querySelectorAll(".block_person_view")[id].classList.add('active_block_person')
                document.querySelector('html').classList.add('lock_person')
            },
            null_style: function(){
                document.querySelector(".active_block_person").classList.remove("active_block_person")
                document.querySelector('html').classList.remove('lock_person')
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>