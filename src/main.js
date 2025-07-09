/**
 * main.js
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

// Plugins
import { registerPlugins } from '@/plugins'

// Components
import App from './App.vue'

// Composables
import { createApp } from 'vue'

// Styles
import 'unfonts.css'

// Vuetify
import vuetify from './plugins/vuetify'

const app = createApp(App)

// Add global property for asset paths
app.config.globalProperties.$getAssetPath = (path) => {
  const baseUrl = import.meta.env.BASE_URL || '/';
  return baseUrl + path.replace(/^\//, '');
}

app.use(vuetify)

registerPlugins(app)

app.mount('#app')
