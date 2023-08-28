<template>
    <div id="repertoire">
        <titles title="Афиша"/>
        <div id="repertoire_wrapper">
            <router-link v-for="(billboard, index) in billboards"
                :key="billboard.id_billboard"
                class="block_repertoire"
                :class="{revers: (index % 2 === 0)}"
                :to="'/billboard/' + billboard.id_billboard"
            >
                <img :src="'../upload/' + billboard.image">
                <div class="about_repertoire">
                    <p class="about_repertoire_title">{{ billboard.title }}</p>
                    <p class="about_repertoire_author">{{ billboard.author }}</p>
                    <p class="description">{{ billboard.description }}</p>
                    <p class="time">длительность {{ billboard.duration }} минут</p>
                    <p class="date">{{ date_format(billboard.date_time) }}</p>
                    <p class="place">{{ billboard.place }}</p>
                </div>
            </router-link>
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
                billboards: []
            }
        },
        methods: {
            connect_db: function() {
                this.$http.get("/billboardAPI")
                    .then(function(res) {
                        this.billboards = res.body
                    })
            },
            date_format: function(date) {
                let formatter_Date = new Date(date)

                let day = formatter_Date.getDate()
                let month = formatter_Date.toLocaleString('ru',{month: 'long'})
                let year = formatter_Date.getFullYear()
                let weekday = formatter_Date.toLocaleString('ru',{weekday: 'long'})
                let Hours = formatter_Date.getHours()
                let minutes = formatter_Date.getMinutes()

                return `${day} ${month} ${year}, в ${Hours}:${minutes}`
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>