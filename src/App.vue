<template>
  <v-app v-if="isDrizzleInitialized">
    <v-app-bar
      app
      color="primary"
      dark
    >
     <v-btn
        href="#"
        text
      >
        <span class="mr-2">Polarizer</span>
      </v-btn>
      <div class="d-flex align-center"></div>

      <v-spacer></v-spacer>

     
    </v-app-bar>

    <v-main>
      <br>
      <br>
      <ActiveAccount/>
        <Proposals/>
        <ContractData/>
        <Authorized/>
    </v-main>
  </v-app>
  <v-app  v-else>
    Waiting...
  </v-app>
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
