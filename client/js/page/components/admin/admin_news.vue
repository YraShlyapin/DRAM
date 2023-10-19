<template>
    <div id="main">
        <form v-if="!edite_mode" v-on:submit="post_method" id="form">
            <textarea name="description"  cols="30" rows="10" placeholder="новость"></textarea>
            <button type="submit">отправить</button>
        </form>
        <form v-else v-on:submit="edite_method" id="form">
            <textarea name="description"  cols="30" rows="10" placeholder="новость" :value="comp_edite.description"></textarea>
            <button type="submit">отправить</button>
            <button @click="nullebl" type="button">отмена</button>
        </form>
        <div>
            <div id="mini_repertoire1">
                <div v-for="one_news in news"
                    class="block_mini_repertoire"
                >
                    <div>
                        <p class="mini_repertoire_text" style="display: block;">{{ one_news.description }}</p>
                    </div>
                    <button @click="delete_method(one_news.id_news)">удалить</button>
                    <button @click="edite_scroll(one_news.id_news)">редактировать</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    module.exports = {
        data: function() {
            return {
                srcc: "../upload/not_found.png",
                news: [],
                edite_mode: false,
                comp_edite: {},
                id_edite: 0
            }
        },
        methods: {
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                let formData = new FormData(form)
                formData.append("date", this.date_get())
                this.$http.post("/newsAPI", formData)
                    .then(function(res) {
                        this.connect_db()
                        form.reset()
                    })
            },
            delete_method: function(id) {
                this.$http.delete(`/newsAPI/${id}`)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            edite_method(e) {
                e.preventDefault()
                let form = e.target
                let formData = new FormData(form)
                this.$http.put(`/newsAPI/${this.id_edite}`, formData)
                    .then(function(res) {
                        this.connect_db()
                        form.reset()
                        this.edite_mode = false
                    })
            },
            edite_scroll(id) {
                this.edite_mode = true
                this.comp_edite = this.news.find(
                    (el) => {
                        return el.id_news == id
                    }
                )
                this.id_edite = id

                window.scrollTo({
                    top: 0,
                    left: 0,
                    behavior: 'smooth'
                })
            },
            nullebl(){
                this.edite_mode = false
                this.comp_edite = {}
            },
            async connect_db() {
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