<template>
    <div id="main">
        <img :src="src" alt="">
        <form v-on:submit="post_method" id="df">
            <input type="file" name="file" id="file" accept="image/*" @change="loadPreview">
            <input type="text" name="title">
            <input type="text" name="author">
            <input type="text" name="description">
            <input type="number" name="duration" min="0" max="255" step="1">
            <button type="submit">отправить</button>
        </form>
    </div>
</template>
<style scoped>
#df{
    display: flex;
    flex-direction: column;
    width: 35vw;
}
</style>
<script>
    module.exports = {
        data: function() {
            return {
                src: "https://dummyimage.com/1096x1065/777/000"
            }
        },
        methods: {
            loadPreview: function(e){
                let sf = e.target.files[0]
                let self = this
                let reader = new FileReader()
                reader.onload = function(re){
                    self.src = re.target.result
                }
                reader.readAsDataURL(sf)
            },
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                console.log(form)
                let formData = new FormData(form)
                this.$http.post("/repertoireAPI", formData)
            }
        }
    }
</script>