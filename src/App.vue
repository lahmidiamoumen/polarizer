<template>
  <div v-if="isDrizzleInitialized" id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <ActiveAccount/>
    <ContractData/>
    <Authorized/>
    <Proposals/>
  </div>
  <div v-else>
        <el-container style="margin: 0 auto">
          <el-header height="">
            <!-- Header content -->
          </el-header>
          <el-container >
            <el-aside width="200px">
              <!-- Aside content -->
            </el-aside>
            <el-container >
              <el-main height="">
                  <el-button type="text" size="mini" v-loading.fullscreen.lock="true" ></el-button>             
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
import ContractData from './components/ContractData.vue'
import Proposals from './components/Proposals.vue'
import ActiveAccount from './components/ActiveAccount.vue'
import Authorized from './components/Authorized.vue'

import { mapGetters } from 'vuex'


export default {
  name: 'App',
  computed: mapGetters('drizzle', ['isDrizzleInitialized']),
  components: {
    Proposals,
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
