<template>
    <div id="main">
        <form v-on:submit="post_method" id="form">
            <div id="draggble" draggable="true" @@dragover.prevent @drop.stop.prevent="onDrop">
                <img :src="srcc" alt="" @dragover.prevent @drop.stop.prevent="onDrop">
                <input type="file" name="file" id="file" accept="image/*" @change="loadPreview">
            </div>
            <input type="text" name="name" placeholder="Имя и Фамилия">
            <textarea name="description" cols="30" rows="10" placeholder="Описание"></textarea>
            <input type="datetime-local" name="birthday" :value="date_get()">
            <div>
                <label for="real">Состоит ли в антрепризе </label>
                <input type="checkbox" name="real" checked>
            </div>
            <button type="submit">отправить</button>
        </form>
        <div>
            <div id="mini_repertoire1">
                <div v-for="person in persons"
                    class="block_mini_repertoire"
                >
                    <img :src="'../upload/' + person.image" onerror="this.src = '../upload/not_found.png'">
                    <div>
                        <p class="mini_repertoire_title">{{ person.name }}</p>
                        <p class="mini_repertoire_title mini_repertoire_author">{{ new Date(person.birthday).toLocaleDateString() }}, ({{ Math.trunc((new Date() - new Date(person.birthday))/(24 * 3600 * 365.25 * 1000)) }})</p>
                        <p class="mini_repertoire_text">{{ person.description }}</p>
                        <p>{{ person.real === 1 ? "участник антрепризы" : "не участник антрепризы" }}</p>
                    </div>
                    <button @click="delete_method(person.id_person)">удалить</button>
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
                persons: []
            }
        },
        methods: {
            loadPreview: function(){
                let sf = document.querySelector("input[type='file']").files[0]
                let self = this
                let reader = new FileReader()
                reader.onload = function(re){
                    self.srcc = re.target.result
                }
                reader.readAsDataURL(sf)
            },
            onDrop: function(event){
                event.preventDefault()
                const file = event.dataTransfer.files
                document.querySelector("input[type='file']").files = file
                this.loadPreview()          
            },
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                console.log(form)
                let formData = new FormData(form)
                this.$http.post("/personAPI", formData)
                    .then(function(res) {
                        this.connect_db()
                        form.reset()
                    })
            },
            delete_method: function(id) {
                this.$http.delete(`/personAPI/${id}`)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            date_get: function() {
                let date = new Date().toISOString().replace('T', ' ').split('.')[0].slice(0,-3)
                return date
            },
            connect_db: function() {
                this.$http.get("/personAllAPI")
                    .then(function(res) {
                        this.persons = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>