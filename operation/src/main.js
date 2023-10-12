import { createApp } from 'vue'
import App from './App.vue'
import router from './router';
import store from './store';
import * as ElementPlusIconsVue from '@element-plus/icons-vue';
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css'
import * as echarts from 'echarts'
import zhCn from 'element-plus/dist/locale/zh-cn.mjs'

const app = createApp(App);
app.use(router);
app.use(store);
app.use(ElementPlus, { locale: zhCn });
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
  }
app.config.globalProperties.$echarts = echarts
app.mount('#app');