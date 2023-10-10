<template>
    <div id="main">
        <form v-show="!edite_mode" v-on:submit="post_method" id="form">
            <div id="draggble" draggable="true" @@dragover.prevent @drop.stop.prevent="onDrop">
                <img :src="srcc" @dragover.prevent @drop.stop.prevent="onDrop">
                <input type="file" ref="image_input" name="file" id="file" accept="image/*" @change="loadPreview">
            </div>
            <textarea name="description" cols="30" rows="10" placeholder="Описание награды"></textarea>
        </form>
    </div>
</template>
<script>
    module.exports = {
        data: function() {
            return {
                srcc: "../upload/not_found.png",
                awards: [],
                /*edite_mode: false,
                comp_edite: {},
                id_edite: 0*/
            }
        },
        methods: {
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                if (form.id_repertoire.value == ''){
                    return
                }
                let formData = new FormData(form)
                this.$http.post("/awardsAPI", formData)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            loadPreview(){
                let sf = this.$refs.image_input.files[0]
                let self = this
                let reader = new FileReader()
                reader.onload = function(re){
                    self.srcc = re.target.result
                }
                reader.readAsDataURL(sf)
            },
            async connect_db() {
                this.$http.get("/awardsAPI")
                    .then(function(res) {
                        this.awards = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>