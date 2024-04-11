package com.red.boot.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmailVerificationStore {
	@Autowired
    private static final Map<String, String> emailCodeStore = new HashMap<>();

    public static void storeCode(String email, String code) {
        emailCodeStore.put(email, code);
    }

    public static String getCode(String email) {
        return emailCodeStore.get(email);
    }
}
