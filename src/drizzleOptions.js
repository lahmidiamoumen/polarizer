import Election from './contracts/Election.json'

const options = {
  web3: {
    block: false,
    fallback: {
      type: 'HTTP',
      url: 'HTTP://127.0.0.1:8545'
    } 
  },
  contracts: [Election],
  polls: {
    accounts: 15000
  }
}

export default options
