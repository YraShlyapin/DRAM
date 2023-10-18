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
                <img :src="'../upload/' + billboard.image" onerror="this.src = '../upload/not_found.png'">
                <div class="about_repertoire">
                    <p class="about_repertoire_title">{{ billboard.title }}</p>
                    <p class="about_repertoire_title about_repertoire_author">{{ billboard.author }}</p>
                    <p class="about_repertoire_title about_repertoire_author" v-show="billboard.marker">{{ billboard.marker }}</p>
                    <p class="description">{{ billboard.description }}</p>
                    <p class="time">{{ time_format(billboard.duration) }}</p>
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
                this.set_title("Афиша")
                this.$http.get("/billboardAPI")
                    .then(function(res) {
                        this.billboards = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>