package org.notalgodemons.tokenservice;

import com.twilio.Twilio;
import com.twilio.base.ResourceSet;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.rest.api.v2010.account.MessageReader;
import org.notalgodemons.tokenservice.wrappers.EIP20;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.web3j.crypto.Credentials;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;
import org.web3j.tx.Contract;
import org.web3j.tx.ManagedTransaction;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

@SpringBootApplication
public class TokenserviceApplication {

    @Qualifier("getCreatorWallet")
    @Autowired
    private String creatorWallet;
    @Qualifier("getContractAddress")
    @Autowired
    private String contractAddress;

    private EIP20 eip20;
    private Web3j web3j;

    public static final String ACCOUNT_SID = "";
    public static final String AUTH_TOKEN = "";
    public static MessageReader messageReader;

    public static void main(String[] args) {
        SpringApplication.run(TokenserviceApplication.class, args);
    }

    @PostConstruct
    public void init() {
        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
        messageReader = Message.reader()
                .setTo(new com.twilio.type.PhoneNumber("+12059534747"));

        web3j=Web3j.build(new HttpService("https://rpc-mumbai.matic.today"));
        Credentials creatorCredentials=Credentials.create(creatorWallet);
        eip20=eip20.load(contractAddress,web3j, creatorCredentials, ManagedTransaction.GAS_PRICE, Contract.GAS_LIMIT);

    }

    @Bean
    public Web3j getWeb3j() {
        return web3j;
    }
    @Bean
    public EIP20 getEip20Creator() {
        return eip20;
    }

}
