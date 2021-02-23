<template>
  <el-row>
    <el-col :span="8" :offset="8">
      <div class="grid-content bg-purple-dark"></div>
      <el-card shadow="hover">
        <table>
          <tr>
            <td ><b>Account</b></td>
            <td> <p>{{ activeAccount}}</p></td>
          </tr>
          <tr>
            <td><b>Balance</b></td>
            <td><p> {{ activeBalance }}  <i>Wei</i></p></td>
          </tr>
        </table> 
      </el-card>
    </el-col>
</el-row>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ActiveAccount',

  computed: mapGetters('accounts', ['activeAccount', 'activeBalance'])
}
</script>
<style>
table {
  width: 100%;
}
</style>