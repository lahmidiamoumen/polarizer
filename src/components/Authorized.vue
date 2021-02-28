<template>
<el-row :gutter="0">
    <br>
    <el-col :span="14" :offset="5">
    <el-card shadow="hover" :body-style="{ padding: '20px' }">
         <div slot="header">
            <span>Accounts authorized</span>
        </div>
        <el-form :inline="true" :model="authModel" ref="numberValidateForm" label-width="100px" width="500px"  class="demo-form-inline">
            <el-form-item
                label="Address"
                prop="newAuthorize"
                :rules=" [ { required: true, message: 'address is required', trigger: 'blur' }, { min: 42, max: 42, message: 'Length should be 3 to 5', trigger: 'blur' }]"
            > 
                <el-input v-model="authModel.newAuthorize" autocomplete="off"></el-input> 
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click.prevent="submitForm('numberValidateForm')">Add</el-button>
                <el-button @click.prevent="resetForm('numberValidateForm')">Reset</el-button>
            </el-form-item>
        </el-form>
        <div v-for="(cat,n) in getAuthorizedAdd" :key="n">
            <p><span>{{cat}}</span></p>
            <el-divider></el-divider>
        </div>
    </el-card>    
    </el-col>
</el-row>    
</template>

<script>
import { mapGetters } from 'vuex';
  export default {
    computed: {
        ...mapGetters('contracts',['getContractData']),
        ...mapGetters("drizzle", ["isDrizzleInitialized", "drizzleInstance"]),

         getAuthorizedAdd(){
            return this.getContractData({
                contract:'Election',
                method: 'getAuthorized'
            })
        },
    },
    created() {
       this.$store.dispatch('drizzle/REGISTER_CONTRACT', {
           contractName: 'Election',
           method:'getAuthorized',
           methodArgs:[],
       });
    },
  
    data() {
      return {
        authModel:{
            newAuthorize: ''
        },
    
      };
    },
    methods: {
        onAuthorizeCall(){
            this.drizzleInstance
            .contracts['Election']
            .methods['authorize']
            .cacheSend(this.authModel.newAuthorize)
        },
        addAuthorize() {
            // ensure they actually typed something
            if (!this.authModel.newAuthorize) {
                return;
            }
            this.onAuthorizeCall()
            this.authModel.newAuthorize = '';
            this.$notify({
                title: 'Adress added!',
                type: 'success',
                message: 'Address added successfuly!',
                duration: 5000
            })
        },
        submitForm(formName) {
            this.$refs[formName].validate((valid) => {
            if (valid) {
                this.addAuthorize()
            } else {
                console.log('error submit!!');
                return false;
            }
            });
        },
        resetForm(formName) {
            this.$refs[formName].resetFields();
        }
    }
  }
</script>