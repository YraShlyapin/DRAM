<template>
    <div class='err404'>
        Увы, но странички по ссылке:<br>{{ this.$route.path }}<br>не существует<br>
        Ошибка 404
    </div>
</template>
<script>
    module.exports = {
        mounted(){
            this.set_title("Ошибка 404")
        },
    }
</script>