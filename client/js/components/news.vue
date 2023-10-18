<template>
    <div id="repertoire">
        <titles title="Новости"/>
        <div id="repertoire_wrapper" style="margin-bottom: 50px;">
            <div v-for="(one_news, index) in news"
                class="block_repertoire_news"
                :class="{revers: (index % 2 === 0)}"
            >
                <p class="description">{{ one_news.description }}</p>
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
                news: []
            }
        },
        methods: {
            connect_db: function() {
                this.set_title("Новости")
                this.$http.get("/newsAPI")
                    .then(function(res) {
                        this.news = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>