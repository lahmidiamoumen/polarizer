<template>
<div>
    <el-divider></el-divider>
        <el-row>
            <el-col :span="20"><p>Candidates</p></el-col>
            <el-col :span="4" right>
                <el-button type="text" @click="dialogVisible = true">New Proposal</el-button>
            </el-col>
        </el-row>
        <el-dialog
            title="New proposal"
            :visible.sync="dialogVisible"
            width="30%">
            <el-input
                type="textarea"
                :rows="2"
                placeholder="description..."
                v-model="poroposals.descption">
            </el-input>
            <br>
            <br>
            
            <div v-for="(con, index) in poroposals.candidate" :key="index">
                <br>
                <el-row :gutter="10">
                    <el-col :span="21">
                            <el-input placeholder="condidate suggestion..." v-model="propos[index]" clearable></el-input>
                    </el-col>
                    <el-col :span="1">
                        <el-button type="danger" icon="el-icon-delete" size="default" @click="removeOption(index)">
                        </el-button>
                    </el-col>
                </el-row>
            </div>
            <el-row  :gutter="10">
                <br>
                   <el-button type="primary" size="default" icon="el-icon-plus" width="100" plain @click="addOption(index)" align-right>
                       Add new condidate
                    </el-button>
            </el-row>
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
            propos: [],
            poroposals: {
                description: '',
                candidate: ['']
            }
        }
    },
    methods: {
        addProposals(){
            this.drizzleInstance
            .contracts['Election']
            .methods['addProposals']
            .cacheSend(this.propos, this.poroposals.description)
            this.dialogVisible = false
        },
        addOption() {
            this.poroposals.candidate.push('');
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