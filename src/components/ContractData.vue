<template>
<el-row :gutter="0">
    <br>
    <el-col :span="14" :offset="5">
        <el-card shadow="hover" :body-style="{ padding: '20px' }">
        <div slot="header">
            <span>Proposals</span>
        </div>
        <table v-for="(contractName, index) in contractNames" :key="index">
            <tr>
                <td><div>{{convert(contractName)}}</div></td>
                <td>{{contractVotes[index]}}</td>
                <td><el-button type="primary" size="small" plain :loading="loading" @click="onVote(index)" :disabled="voted">Vote</el-button></td>
            </tr>
        </table>

        <table v-for="(proposal, index) in contractProposals" :key="index">
            <tr>
                <td>{{proposal.description}}</td>
                <td>{{proposal.condidate_name}}</td>
                <td>{{proposal.condidate_voteCount}}</td>
            </tr>
        </table>
        
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
        this.$store.dispatch('drizzle/REGISTER_CONTRACT', {
            contractName: contract,
            method:'getproposals',
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
        contractProposals(){
            return this.getContractData({
                contract:contract,
                method: 'getproposals'
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
            voted: false,
            condidates:[],
            description: ''
        }
    }
    
}
</script>