
import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource/dist/vue-resource'

import ElementUI from 'element-ui'
import locale from 'element-ui/lib/locale/lang/en'

import JourneyMap from './journey_map.vue'

Vue.use(VueResource)
Vue.use(ElementUI, { locale })

const app = new Vue({
  el: '#app',
  components: { JourneyMap },
})
