<template>
<div class="app-container">
    <el-row :gutter="20">
        <el-col :span="16" :offset="4">
            <el-divider></el-divider>
        </el-col>
    </el-row>    
    <el-row :gutter="20">
        <el-col :span="16" :offset="4">
            <el-button plain  @click="dialogVisible = true">New Proposal</el-button>
        </el-col>
    </el-row>
    
    
   
    
    <el-dialog
        title="New proposal"
        :visible.sync="dialogVisible"
        width="30%">
        <h5 style="float: left;margin: 6px; margin-left:6px">Describe your proposal</h5>
        <el-input
            type="textarea"
            :rows="3"
            placeholder="write somthing..."
            v-model="poroposals.description">
        </el-input>
        <div v-for="con in poroposals.candidate" :key="'_'+con.key">
            <el-row style="marging-top: 8px" :gutter="6">
                <h5 style="float: left;margin: 6px; margin-left:6px"> Poroposal suggestion {{index + 1}} </h5>    
                <el-col :span="20">
                    <el-input placeholder="..." v-model="con.value" clearable></el-input>
                </el-col>
                <el-col :span="2">
                    <el-button type="danger" icon="el-icon-delete" size="default" :disabled="index < 2" @click="removeOption(index)">
                    </el-button>
                </el-col>
            </el-row>
        </div>
        <br>
        <el-button type="primary" size="default" icon="el-icon-plus" style="width: 100%" plain @click="addOption(index)" >
            Add new condidate
        </el-button>
        <span slot="footer" class="dialog-footer">
            <el-button @click="dialogVisible = false">Cancel</el-button>
            <el-button type="primary" @click="addProposals">Confirm</el-button>
        </span>
    </el-dialog>
</div>

</template>

<script>
import { mapGetters } from 'vuex'

export default {
    name:'Proposals',
    computed:{
        ...mapGetters("drizzle", ["drizzleInstance"]),
        
    },
    data(){
        return{
            dialogVisible:false,
            proposBt : [],
            poroposals: {
                description: '',
                candidate: [{kye: 12222,value: ''},{kye: 123312,value: ''}]
            }
        }
    },
    methods: {
        fromAscii(value) {
            return this.drizzleInstance.web3.utils.utf8ToHex(value)
        },
        pushToByte32(){
            for (let i = 0; i < this.poroposals.candidate.length; i++) {
               this.proposBt.push(this.fromAscii(this.poroposals.candidate[i].value))
            }
            console.log(this.proposBt)
        },
        addProposals(){
            this.pushToByte32()
            this.drizzleInstance
            .contracts['Election']
            .methods['addProposals']
            .cacheSend(this.proposBt, this.fromAscii(this.poroposals.description))
            // reset
            this.poroposals.description = ''
            this.poroposals.candidate = [{kye: 12222,value: ''},{kye: 123312,value: ''}]
            this.dialogVisible = false
            this.proposBt = []
        },
        addOption() {
            this.poroposals.candidate.push({key: Date.now(),value:''});
        },
        removeOption(index) {
            if(this.poroposals.candidate.length<=2) {
                alert('We need at least two fields')
            } else {
                this.poroposals.candidate.splice(index, 1);
            }
        },  
    },
        
}
</script>