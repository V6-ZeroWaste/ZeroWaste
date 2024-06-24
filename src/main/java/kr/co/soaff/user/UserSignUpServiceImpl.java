package kr.co.soaff.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public  class UserSignUpServiceImpl implements UserSignUpService{
    @Autowired
    UserSignUpMapper mapper;

    @Override
    public int idCheck(UserVO vo) {
        return mapper.idCheck(vo);
    }

    @Override
    public boolean userSignUp(UserVO vo) {
        return mapper.userSignUp(vo) == 0 ? false : true;
    }

}
