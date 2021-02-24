<template>
  <div v-if="isDrizzleInitialized" id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <ActiveAccount/>
    <ContractData/>
    <Authorized/>
    <HelloWorld msg="Welcome to Your Vue.js App"/>
  </div>
  <div v-else>
        <el-container style="margin: 0 auto">
          <el-header height="">
            <!-- Header content -->
          </el-header>
          <el-container >
            <el-aside width="200px">
              <!-- Aside content -->
              Connection to blockchain
            </el-aside>
            <el-container >
              <el-main height="">
                  <el-button type="primary" size="default" v-loading.fullscreen.lock="true"></el-button>             
              </el-main>
              <el-footer height="">
                <!-- Footer content -->
              </el-footer>
            </el-container>
          </el-container>
        </el-container>
        </div>

</template>

<script>
import HelloWorld from './components/HelloWorld.vue'
import ContractData from './components/ContractData.vue'
import ActiveAccount from './components/ActiveAccount.vue'
import Authorized from './components/Authorized.vue'

import { mapGetters } from 'vuex'


export default {
  name: 'App',
  computed: mapGetters('drizzle', ['isDrizzleInitialized']),
  components: {
    HelloWorld,
    ActiveAccount,
    ContractData,
    Authorized
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
