<template>
<el-row :gutter="0">
    <br>
    <el-col :span="14" :offset="5">
        <el-card shadow="hover" :body-style="{ padding: '20px' }">
        <div slot="header">
            <span>Proposals</span>
        </div>
        <table>
            <tr>
                <td><div>{{convert(contractNames[0])}}</div></td>
                <td>{{contractVotes[0]}}</td>
                <td><el-button type="primary" size="small" plain :loading="loading" @click="onVote(0)" :disabled="voted">Vote</el-button></td>
            </tr>
            <tr>
                <td><div>{{convert(contractNames[1])}}</div></td>
                <td>{{contractVotes[1]}}</td>
                <td><el-button type="primary" size="small" :loading="loading" plain @click="onVote(1)" :disabled="voted">Vote</el-button></td>
            </tr>
            <tr>
                <td><div>{{convert(contractNames[2])}}</div></td>
                <td>{{contractVotes[2]}}</td>
                <td><el-button type="primary" size="small" :loading="loading" plain @click="onVote(2)" :disabled="voted">Vote</el-button></td>
            </tr>
        </table>
        
        
        <!-- <drizzle-contract
            contractName="Election"
            method="condidates"
            label="Condidate"
            :methodArgs="[0]"
            /> -->
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
            method:'getCondidateNames',
            methodArgs:[],
        });
        this.$store.dispatch('drizzle/REGISTER_CONTRACT', {
            contractName: contract,
            method:'getCondidateVotes',
            methodArgs:[],
        });
    },
    computed:{
        ...mapGetters('contracts',['getContractData']),
        ...mapGetters("drizzle", ["isDrizzleInitialized", "drizzleInstance"]),

        contractNames(){
            return this.getContractData({
                contract:contract,
                method: 'getCondidateNames'
            })
        },
        contractVotes(){
            return this.getContractData({
                contract:contract,
                method: 'getCondidateVotes'
            })
        },
    },
    methods: {
        
        onVote(index){
            this.drizzleInstance
            .contracts[contract]
            .methods['vote']
            .cacheSend(index)
            this.voted = true
        },
        convert(byte32) {
            return this.drizzleInstance.web3.utils.hexToUtf8(`${byte32}`)
        },
    },
    data() {
        return {
            loading: false,
            voted: false
        }
    }
    
}
</script>