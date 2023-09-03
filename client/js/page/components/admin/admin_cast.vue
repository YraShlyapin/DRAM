<template>
    <div id="main">
        <form v-on:submit="post_method" id="form">
            <select name="id_repertoire">
                <option value="" disabled selected hidden>выберить спектакль из репертуара</option>
                <option v-for="repertoire in repertoires"
                    :value="repertoire.id_repertoire"
                >
                    {{ repertoire.title }}
                </option>
            </select>
            <select name="id_person">
                <option value="" disabled selected hidden>выберить человека</option>
                <option v-for="person in persons"
                    :value="person.id_person"
                >
                    {{ person.name }}
                </option>
            </select>
            <input type="text" name="role_person" placeholder="Роль">
            <div>
                <label for="is_head">Руководитель </label>
                <input type="checkbox" name="is_head">
            </div>
            <button type="submit">отправить</button>
        </form>
        <select v-model="id_filter_repertoire">
            <option value="false">все</option>
            <option v-for="repertoire in repertoires"
                :value="repertoire.id_repertoire"
            >
                {{ repertoire.title }}
            </option>
        </select>
        <select v-model="id_filter_person">
            <option value="false">все</option>
            <option v-for="person in persons"
                :value="person.id_person"
            >
                {{ person.name }}
            </option>
        </select>

        <div>
            <div id="mini_repertoire1">
                <div v-for="cast in filter_func_person(filter_func_repertoire(casts))"
                    class="block_mini_repertoire"
                >
                    <img :src="'../upload/' + cast.image" onerror="this.src = '../upload/not_found.png'">
                    <div>
                        <p class="mini_repertoire_title">{{ cast.title }}</p>
                        <p class="mini_repertoire_title mini_repertoire_author">{{ cast.name }} - {{ cast.role_person }}</p>
                        <p class="mini_repertoire_text">{{ cast.is_head == 1 ? 'Руководящий' : 'Актер' }}</p>
                    </div>
                    <button @click="delete_method(cast.id_cast)">удалить</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    module.exports = {
        data: function() {
            return {
                repertoires: [],
                persons: [],
                casts: [],
                id_filter_repertoire: false,
                id_filter_person: false
            }
        },
        methods: {
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                console.log(form)
                if (form.id_repertoire.value == '' || form.id_person.value == ''){
                    return
                }
                let formData = new FormData(form)
                this.$http.post("/castAPI", formData)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            delete_method: function(id) {
                this.$http.delete(`/castAPI/${id}`)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            filter_func_repertoire(arr) {
                if (this.id_filter_repertoire) {
                    let idi = this.id_filter_repertoire
                    return arr.filter(
                        (el) => {
                            return el.id_repertoire === idi
                        }
                    )
                }
                return arr
            },
            filter_func_person(arr) {
                if (this.id_filter_person) {
                    let idi = this.id_filter_person
                    return arr.filter(
                        (el) => {
                            console.log(el.id_person === idi)
                            return el.id_person === idi
                        }
                    )
                }
                return arr
            },
            async connect_db() {
                this.$http.get("/repertoireAPI")
                    .then(function(res) {
                        this.repertoires = res.body
                    })
                this.$http.get("/personAllAPI")
                    .then(function(res) {
                        this.persons = res.body
                    })
                this.$http.get("/castAPI")
                    .then(function(res) {
                        this.casts = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>