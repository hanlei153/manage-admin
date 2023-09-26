<template>
    <router-view></router-view>
    <LoginForm msg="Welcome to Your Vue.js App"/>
</template>



<script>
  export default {
    name: 'App'
  }
</script>

<style>
  #app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: rgb(255, 255, 255);
  
  }
  /* 谷歌浏览器 */
  *::-webkit-scrollbar {display: none};
  /* 火狐浏览器 */
  * {
    scrollbar-width: none;
  }
  /* IE | Edge */
  * {
    -ms-overflow-style: none;
  }
</style>
