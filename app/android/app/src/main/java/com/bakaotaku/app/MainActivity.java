package com.bakaotaku.app;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.PowerManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

import java.util.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;


public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "exam";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    try{
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler((call, result) -> {
            final Map<String,Object> arguments = call.arguments();
          if (call.method.equals("decrypt-AES")) {
              String pass = (String) arguments.get("password");
              String input = (String) arguments.get("inputPath");
              String output = (String) arguments.get("outputPath");
            decryptedFile(pass,input,output);
            result.success("success==");
          }
        });
    }
    catch (Exception e) {
    System.out.println(e.getMessage());
    }
  }

  public void decryptedFile(String secretKey, String fileInputPath, String fileOutPath)
            {
    
        MessageDigest md = null;
        try{
        md  = MessageDigest.getInstance("MD5");
        
        SecretKeySpec key = new SecretKeySpec(secretKey.getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, key);

        File fileInput = new File(fileInputPath);
        FileInputStream inputStream = new FileInputStream(fileInput);
        byte[] inputBytes = new byte[(int) fileInput.length()];
        inputStream.read(inputBytes);

        byte[] outputBytes;
        outputBytes = cipher.doFinal(inputBytes);
        
        File fileEncryptOut = new File(fileOutPath);
        FileOutputStream outputStream = new FileOutputStream(fileEncryptOut);
        outputStream.write(outputBytes);

        inputStream.close();
        outputStream.close();

        System.out.println("File successfully decrypted!");
        System.out.println("New File: " + fileOutPath);

        System.out.println("Hooray!!! ALL is PERFECT!!! :)");

        } catch (Exception e) {
          System.out.println(e.getMessage());
        }
    }
}
