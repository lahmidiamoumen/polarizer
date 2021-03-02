<template>
<el-row :gutter="0">
    <br>
    <el-col :span="14" :offset="5">
        <el-card shadow="hover" :body-style="{ padding: '20px' }">
        <div slot="header">
            <span>Proposals</span>
        </div>
        <!-- <table v-for="(contractName, index) in contractNames" :key="index">
            <tr>
                <td><div>{{convert(contractName)}}</div></td>
                <td>{{contractVotes[index]}}</td>
                <td><el-button type="primary" size="small" plain :loading="loading" @click="onVote(index)" :disabled="voted">Vote</el-button></td>
            </tr>
        </table> -->
        
        <div v-for="(porp,index) in contractProposals" :key="porp[0]+index">
            <br>
            
            <el-card shadow="hover"  :body-style="{ padding: '20px' }">
                <div slot="header">
                    <span>{{convert(porp[1])}}</span>
                </div>
                <table>
                    <tr>
                        <td>Creator</td>
                        <td>{{porp[0]}}</td>
                    </tr>
                        <tr v-for="(votes, index2) in porp[2]" :key="index2">
                            <td>  {{convert(porp[3][index2])}}</td>
                            <td>{{porp[2][index2]}}</td>
                            <td><el-button @click="onVote(index,index2)" size="small" >Vote</el-button></td>
                        </tr>   
                </table>
                
 
                
            </el-card>
        </div>
        
    </el-card>
    </el-col>
</el-row>

    
</template>
<script>
import { mapGetters } from 'vuex'
const contract = 'Election'
export default {
    name: 'ContractData',
    
    created() {
        this.$store.dispatch('drizzle/REGISTER_CONTRACT', {
            contractName: contract,
            method:'getproposals',
            methodArgs:[],
        });
    },
    
    computed:{
        ...mapGetters('contracts',['getContractData']),
        ...mapGetters("drizzle", ["isDrizzleInitialized", "drizzleInstance"]),

        contractProposals (){            
            return this.getContractData({
                contract:contract,
                method: 'getproposals'
            })
        },
        
    },
    methods: {
        
        onVote(index,index2){
            this.drizzleInstance
            .contracts[contract]
            .methods['vote']
            .cacheSend(index,index2)
        },
        convert(byte32) {
            return (typeof byte32 === 'undefined' || byte32 === '' || byte32 === '0x00') ? 'Empty content!' : this.drizzleInstance.web3.utils.hexToUtf8(byte32.toString(16))
        },
    },
    data() {
        return {
            vars:'',
            loading: false,
            choices: [],
            condidates:[],
            description: ''
        }
    }
    
}
</script>