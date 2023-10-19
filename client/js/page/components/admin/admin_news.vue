<template>
    <div id="main">
        <form v-if="!edite_mode" v-on:submit="post_method" id="form">
            <input type="text" name="description" placeholder="новость">
            <button type="submit">отправить</button>
        </form>
    </div>
</template>