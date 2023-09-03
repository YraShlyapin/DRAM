<template>
    <div id="main">
        <form v-on:submit="post_method" id="form">
            <select name="id_repertoire" >
                <option v-for="repertoire in repertoires"
                    :value="repertoire.id_repertoire"
                >
                    {{ repertoire.title }}
                </option>
            </select>
            <input type="datetime-local" name="date_time" :value="date_get()">
            <input type="text" name="place" placeholder="Место">
            <input type="text" name="src_on_map" placeholder="ссылка на карту">
            <button type="submit">отправить</button>
        </form>
        <div>
            <div id="mini_repertoire1">
                <div v-for="billboard in billboards"
                    class="block_mini_repertoire"
                >
                    <img :src="'../upload/' + billboard.image" onerror="this.src = '../upload/not_found.png'">
                    <div>
                        <p class="mini_repertoire_title">{{ billboard.title }}</p>
                        <p class="mini_repertoire_title mini_repertoire_author">{{ date_format(billboard.date_time) }}</p>
                        <p class="mini_repertoire_text">{{ billboard.place }}</p>
                        <p class="mini_repertoire_text">{{ billboard.src_on_map }}</p>
                    </div>
                    <button @click="delete_method(billboard.id_billboard)">удалить</button>
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
                repertoires: [],
                billboards: []
            }
        },
        methods: {
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                console.log(form)
                let formData = new FormData(form)
                this.$http.post("/billboardAPI", formData)
                    .then(function(res) {
                        this.connect_db()
                        form.reset()
                    })
            },
            delete_method: function(id) {
                this.$http.delete(`/billboardAPI/${id}`)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            connect_db: function() {
                this.$http.get("/billboardAPI")
                    .then(function(res) {
                        this.billboards = res.body
                    })

                this.$http.get("/repertoireAPI")
                    .then(function(res) {
                        this.repertoires = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>