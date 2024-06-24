package kr.co.soaff.user;

public interface UserFindService {
    UserVO idFindCheck(UserVO vo);
    UserVO pwFindCheck(UserVO vo);
    int pwNewCheck(UserVO vo);
    int pwNewInsert(UserVO vo);
}
