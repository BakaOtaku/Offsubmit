package org.notalgodemons.tokenservice.api;

import com.twilio.Twilio;
import com.twilio.base.ResourceSet;
import com.twilio.rest.api.v2010.account.Message;
import io.ipfs.api.IPFS;
import io.ipfs.api.MerkleNode;
import io.ipfs.api.NamedStreamable;
import org.notalgodemons.tokenservice.TokenserviceApplication;
import org.notalgodemons.tokenservice.wrappers.Course;
import org.notalgodemons.tokenservice.wrappers.EIP20;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.web3j.crypto.Credentials;
import org.web3j.crypto.ECKeyPair;
import org.web3j.crypto.Keys;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.methods.response.TransactionReceipt;
import org.web3j.tx.Contract;
import org.web3j.tx.ManagedTransaction;
import org.web3j.tx.Transfer;
import org.web3j.utils.Convert;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.security.InvalidAlgorithmParameterException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.util.ArrayList;
import java.util.List;

// ssh -R 80:localhost:8080 ssh.localhost.run
@RestController
public class Eduthon {

    @Qualifier("getCreatorWallet")
    @Autowired
    private String creatorWallet;
    @Qualifier("getContractAddress")
    @Autowired
    private String contractAddress;
    @Autowired
    private Web3j web3j;
    @Autowired
    private EIP20 eip20Creator;

    public String newWallet() throws InvalidAlgorithmParameterException, NoSuchAlgorithmException, NoSuchProviderException {
        ECKeyPair ecKeyPair= Keys.createEcKeyPair();
        BigInteger privateKeyInDec=ecKeyPair.getPrivateKey();
        String privateKeyInHex=privateKeyInDec.toString(16);
        return privateKeyInHex;
    }


    @RequestMapping("/newStudentWallet")
    public String newStudentWallet()  {
        try{
//            Web3j web3j = Web3j.build(new HttpService("url"));
            String privateKey = newWallet();
            Credentials credentials = Credentials.create( privateKey );
            TransactionReceipt transactionReceipt = Transfer.sendFunds(web3j, Credentials.create(creatorWallet),credentials.getAddress(),new BigDecimal("0.01"), Convert.Unit.ETHER).send();
            return privateKey+" "+credentials.getAddress();
        }
        catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    @RequestMapping("/submit/{privateKey}/{courseAddress}/{fileHash}")
    public String submit(@PathVariable String privateKey, @PathVariable String courseAddress, @PathVariable String fileHash) {
        try {
            Credentials credentials = Credentials.create(privateKey);
            Course course = Course.load(courseAddress,web3j,credentials, ManagedTransaction.GAS_PRICE, Contract.GAS_LIMIT);
            TransactionReceipt transactionReceipt = course.submit(fileHash).sendAsync().get();
            return transactionReceipt.getTransactionHash();
        }
        catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    @RequestMapping(value = "/fileHashMatch",method = RequestMethod.POST)
    public String hashFile(@RequestParam("file") MultipartFile file, @RequestParam("comparisonHash") String comparisonHash) {
        File temp= null;
        try {
//            System.out.println(Arrays.toString(file.getBytes()));
            temp = File.createTempFile("hashed",".sha");
            file.transferTo(temp);
            MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
            FileInputStream fis = new FileInputStream(temp);

            byte[] data = new byte[1024];
            int read = 0;
            while ((read = fis.read(data)) != -1) {
                sha256.update(data, 0, read);
            };
            byte[] hashBytes = sha256.digest();

            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < hashBytes.length; i++) {
                sb.append(Integer.toString((hashBytes[i] & 0xff) + 0x100, 16).substring(1));
            }

            String fileHash = sb.toString();
            if (fileHash.equals(comparisonHash)) {
                return "verified";
            }
            else {
                return "notVerified";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    @RequestMapping (value = "/encrypt", method = RequestMethod.POST)
    public String encryptFile(@RequestParam("file") MultipartFile file) {
        try {
            File tempIn = File.createTempFile("xyz",".pdf");
            String secretKey="";
            for (int i = 0; i < 16; i++) {
                secretKey+=(int)(Math.random()*10);
            }

            file.transferTo(tempIn);

            SecretKeySpec key = new SecretKeySpec(secretKey.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, key);

            FileInputStream inputStream = new FileInputStream(tempIn);
            byte[] inputBytes = new byte[(int) tempIn.length()];
            inputStream.read(inputBytes);

            byte[] outputBytes = cipher.doFinal(inputBytes);
//            System.out.println(Arrays.toString(outputBytes));
            File tempOut = File.createTempFile("encrypted",".enc");
            FileOutputStream outputStream = new FileOutputStream(tempOut);
            outputStream.write(outputBytes);

            inputStream.close();
            outputStream.close();

            IPFS ipfs = new IPFS("/dnsaddr/ipfs.infura.io/tcp/5001/https");
            NamedStreamable.InputStreamWrapper is = new NamedStreamable.InputStreamWrapper(new FileInputStream(tempOut));
            MerkleNode response = ipfs.add(is).get(0);
            String responseHash = response.hash.toBase58();
            System.out.println("Hash (base 58): " + response.name.get() + " - " + response.hash.toBase58());

            System.out.println("File successfully encrypted!");

            return (secretKey+" "+responseHash);

        }
        catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    @RequestMapping(value = "/twillioTest", method = RequestMethod.POST)
    public String twillioTest() {
        try {
            ResourceSet<Message> messages = Message.reader()
                    .setTo(new com.twilio.type.PhoneNumber("+12059534747"))
                    .limit(20)
                    .read();

            List<String> AL = new ArrayList<>();
            for (Message record : messages) {
                AL.add(record.getBody());
            }
            System.out.println(AL.get(0));
            String respMessage = AL.get(0);
            respMessage=respMessage.trim();
//            String respMessage="97d8cb40d55f97fa4a9dcbb9d89b159128b95043edfd835467553f3b5c69d7af 0x5BA3Ad623fFcAF030760405a10eBF44fB04eD774 hi";
            String privateKey = respMessage.substring(0, respMessage.indexOf(':'));
            String courseAddress = respMessage.substring(respMessage.indexOf(':')+1, respMessage.lastIndexOf(':'));
            String fileHash = respMessage.substring(respMessage.lastIndexOf(':')+1);
            String transactionHash = submit(privateKey,courseAddress,fileHash);
            System.out.println(transactionHash);
            return transactionHash;
        }
        catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    @RequestMapping(value = "/ipfsStore",method = RequestMethod.POST)
    public String ipfsStore(@RequestParam("file") MultipartFile file) {
        File temp = null;
        try {
            temp = File.createTempFile("hashed",".sha");
            file.transferTo(temp);
            IPFS ipfs = new IPFS("/dnsaddr/ipfs.infura.io/tcp/5001/https");
            NamedStreamable.InputStreamWrapper is = new NamedStreamable.InputStreamWrapper(new FileInputStream(temp));
            MerkleNode response = ipfs.add(is).get(0);
            String responseHash = response.hash.toBase58();
            System.out.println("Hash (base 58): " + response.name.get() + " - " + response.hash.toBase58());
            return responseHash;
        }
        catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }
}