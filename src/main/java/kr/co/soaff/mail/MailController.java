package kr.co.soaff.mail;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/email")
public class MailController {

    @Autowired
    private MailManager mailManager;

    @PostMapping("/sendMail")
    @ResponseBody
    public String sendMail(@RequestBody String email) throws Exception {
        System.out.println(email);
        UUID uuid = UUID.randomUUID();
        String key = uuid.toString().substring(0, 7);
        String sub = "인증번호 입력을 위한 메일 전송";
        String con = "인증 번호 : " + key;
        mailManager.send(email, sub, con);
        key = SHA256Util.getEncrypt(key, email);
        return key;
    }

    @PostMapping("/checkMail")
    @ResponseBody
    public String checkMail(@RequestBody Verification verification) throws Exception {
        String insertKey=verification.getInsertKey();
        String email=verification.getEmail();
        String key=verification.getKey();
        System.out.println(insertKey);
        System.out.println(email);
        System.out.println(key);
        insertKey = SHA256Util.getEncrypt(insertKey, email);
        if(key.equals(insertKey)){
            return "1"; // 성공
        }
        else{
            return "0"; // 실패
        }
    }
}
