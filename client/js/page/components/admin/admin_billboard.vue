<template>
    <div id="main">
        <form v-on:submit="post_method" id="form" v-if="!edite_mode">
            <select name="id_repertoire" >
                <option value="" disabled selected hidden>выберить спектакль из репертуара</option>
                <option v-for="repertoire in repertoires"
                    :value="repertoire.id_repertoire"
                >
                    {{ repertoire.title }}
                </option>
            </select>
            <input type="datetime-local" name="date_time" :value="date_get()">
            <input type="text" name="place" placeholder="Место">
            <input type="text" name="src_on_map" placeholder="ссылка на карту">
            <input type="text" name="marker" placeholder="пометка">
            <button type="submit">отправить</button>
        </form>
        <form v-else v-on:submit="edite_method" id="form">
            <select name="id_repertoire" >
                <option v-for="repertoire in repertoires"
                    :value="repertoire.id_repertoire"
                    :selected="repertoire.id_repertoire == comp_edite.id_repertoire"
                >
                    {{ repertoire.title }}
                </option>
            </select>
            <input type="datetime-local" name="date_time" :value="date_get_edite(comp_edite.date_time)">
            <input type="text" name="place" placeholder="Место" :value="comp_edite.place">
            <input type="text" name="src_on_map" placeholder="ссылка на карту" :value="comp_edite.src_on_map">
            <input type="text" name="marker" placeholder="пометка" :value="comp_edite.marker">
            <button type="submit">отправить</button>
            <button @click="nullebl" type="button">отмена</button>
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
                        <p class="mini_repertoire_text" v-show="billboard.marker">{{ billboard.marker }}</p>
                    </div>
                    <button @click="delete_method(billboard.id_billboard)">удалить</button>
                    <button @click="edite_scroll(billboard.id_billboard)">редактировать</button>
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
                billboards: [],
                edite_mode: false,
                comp_edite: {},
                id_edite: 0
            }
        },
        methods: {
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                console.log(form.date_time.value)
                if (form.id_repertoire.value == ''){
                    return
                }
                let formData = new FormData(form)
                this.$http.post("/billboardAPI", formData)
                    .then(function(res) {
                        this.connect_db()
                        //form.reset()
                    })
            },
            delete_method: function(id) {
                this.$http.delete(`/billboardAPI/${id}`)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            edite_method(e) {
                e.preventDefault()
                let form = e.target
                let formData = new FormData(form)
                this.$http.put(`/billboardAPI/${this.id_edite}`, formData)
                    .then(function(res) {
                        this.connect_db()
                        form.reset()
                        this.edite_mode = false
                    })
            },
            edite_scroll(id) {
                this.edite_mode = true
                this.comp_edite = this.billboards.find(
                    (el) => {
                        return el.id_billboard == id
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