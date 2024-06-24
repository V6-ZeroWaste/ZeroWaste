package kr.co.soaff.user;

public interface ProfileService {
    int updateInfo(UserVO vo);
    UserVO getInfo(int user_no);
    int deleteCheck(UserVO vo);
    int delete(UserVO vo);
}
