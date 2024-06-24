package kr.co.soaff.user;

public interface UserSignUpService {
    int idCheck(UserVO vo);
    boolean userSignUp(UserVO vo);
}
