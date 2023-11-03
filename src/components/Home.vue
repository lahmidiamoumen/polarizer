<template>
    <div>
    </div>
</template>
<script>
import { mapGetters } from 'vuex'
const Stealth = require('stealth_eth');
const coiunkey = require('coinkey');
var payloadKeyPair = coiunkey.createRandom()
var scanKeyPair = coiunkey.createRandom()

export default {
    name: 'Home',
     computed:{
        ...mapGetters("drizzle", ["drizzleInstance"]),
    },
    created(){

    },
    methods:{
        initStealth(){
            let stealth;
            stealth = new Stealth({
                payloadPrivKey: payloadKeyPair.privateKey,
                payloadPubKey: payloadKeyPair.publicKey,
                scanPrivKey: scanKeyPair.privateKey,
                scanPubKey: scanKeyPair.publicKey
            });
            stealth.toString();
        }
    }
    
}
</script>