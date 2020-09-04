package org.notalgodemons.tokenservice.api;

import com.twilio.Twilio;
import com.twilio.base.ResourceSet;
import com.twilio.rest.api.v2010.account.Message;
import org.notalgodemons.tokenservice.wrappers.Course;

import java.util.ArrayList;
import java.util.List;

public class Example {
    public static final String ACCOUNT_SID = "";
    public static final String AUTH_TOKEN = "";

    public static void main(String[] args) {
        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
        ResourceSet<Message> messages = Message.reader()
            .setTo(new com.twilio.type.PhoneNumber("+"))
            .limit(20)
            .read();

        List<String> AL=new ArrayList<>();
        for(Message record : messages) {
            System.out.println(record.getSid()+" "+record.getBody());
            AL.add(record.getBody());
        }
        System.out.println(AL.get(0));
//        String privateKey = AL.get(0).substring(0,AL.get(0).indexOf(' '));
//        String courseAddress = AL.get(0).substring(AL.get(0).indexOf(' '),AL.get(0).lastIndexOf(' '));
//        String fileHash = AL.get(0).substring(AL.get(0).lastIndexOf(' '));
//
//        Eduthon ed = new Eduthon();
//        System.out.println(ed.submit(privateKey,courseAddress,fileHash));

    }
}
