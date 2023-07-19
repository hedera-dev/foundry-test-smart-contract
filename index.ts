import { Client, AccountId, PrivateKey, Hbar } from "@hashgraph/sdk";
import fs from "fs";
import dotenv from "dotenv";
import { deployContract } from "./services/hederaSmatContractService";
 
dotenv.config();
// create your client
const accountIdString = process.env.OPERATOR_ACCOUNT_ID;
const privateKeyString = process.env.OPERATOR_PRIVATE_KEY;

if (accountIdString === undefined || privateKeyString === undefined ) { throw new Error('account id and private key in env file are empty')}

 
const operatorAccountId = AccountId.fromString(accountIdString);
const address = operatorAccountId.toSolidityAddress();
const operatorPrivateKey = PrivateKey.fromString(privateKeyString);
 
const client = Client.forTestnet().setOperator(operatorAccountId, operatorPrivateKey);
client.setDefaultMaxTransactionFee(new Hbar(100));

// read the bytecode
const bytecode = fs.readFileSync("binaries/contracts_TodoList_sol_TodoList.bin");

const hederaFoundryExample = async () => {    
    // Deploy contract
    const gasLimit = 3_000_000;
    const [contractId] = await deployContract(client, bytecode, gasLimit);
    console.log(`Check it out on Hashscan!`);
    console.log(`https://hashscan.io/testnet/contract/${contractId}`);
    console.log(address);

    client.close();
}

hederaFoundryExample();