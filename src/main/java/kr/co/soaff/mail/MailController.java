package kr.co.soaff.mail;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/email")
public class MailController {

    @Autowired
    private MailManager mailManager;

    @PostMapping("/sendMail")
    @ResponseBody
    public String sendMail(@RequestParam String email) throws Exception {
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
    public boolean checkMail(@RequestParam String key, @RequestParam String insertKey, @RequestParam String email) throws Exception {
        insertKey = SHA256Util.getEncrypt(insertKey, email);
        return key.equals(insertKey);
    }
}
