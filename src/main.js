import App from './App.vue';
import Vue from 'vue'
import Vuex from 'vuex'

import drizzleVuePlugin from '@drizzle/vue-plugin'
import drizzleOptions from './drizzleOptions'

import locale from 'element-ui/lib/locale/lang/en'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI, { locale })
Vue.use(Vuex)

// Create and configure your Vuex Store
const store = new Vuex.Store({ state: {} })

// Register the drizzleVuePlugin
Vue.use(drizzleVuePlugin, { store, drizzleOptions })

Vue.config.productionTip = false

new Vue({
  store,
  render: h => h(App),
}).$mount('#app')
