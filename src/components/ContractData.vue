<template>
    <el-card shadow="always" :body-style="{ padding: '20px' }">
        <div slot="header">
            <span>Strored Data</span>
        </div>
        {{contractData}}
        
        <drizzle-contract
            contractName="Election"
            method="condidates"
            label="Condidate"
            :methodArgs="[0]"
            />
    </el-card>
</template>
<script>
import { mapGetters } from 'vuex'
const data = {
    contractName:'Election',
    method:'condidates',
    methodArgs:[0],
}
export default {
    name: 'ContractData',
    created() {
        this.$store.dispatch('drizzle/REGISTER_CONTRACT', data);
    },
    computed:{
        ...mapGetters('contracts',['getContractData']),
        contractData(){
            return this.getContractData({
                contract:data.contractName,
                method:data.method
            })
        }
    }
}
</script>