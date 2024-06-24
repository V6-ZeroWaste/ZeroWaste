package kr.co.soaff.mail;

import lombok.Data;

@Data
public class Verification {
    private String key;
    private String insertKey;
    private String email;
}
