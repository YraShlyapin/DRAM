<template>
    <div id="main">
        <div>
            <div id="mini_repertoire1">
                <div v-for="image in images"
                    class="block_mini_repertoire"
                >
                    <img :src="'../upload/' + image" onerror="this.src = '../upload/not_found.png'">
                    <a :href="'../upload/' + image" download class="download">скачать</a>
                    <button @click="delete_method(image)">удалить</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    module.exports = {
        data: function() {
            return {
                images: [],
            }
        },
        methods: {
            delete_method: function(name) {
                this.$http.delete(`/imageAPI/${name}`)
                this.connect_db()
                    
            },
            connect_db: function() {
                this.$http.get("/imageAPI")
                    .then(function(res) {
                        this.images = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>