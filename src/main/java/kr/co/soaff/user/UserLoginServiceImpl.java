package kr.co.soaff.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public  class UserLoginServiceImpl implements UserLoginService{
    @Autowired
    UserLoginMapper mapper;

    @Override
    public UserVO login(UserVO vo) {
        return mapper.login(vo);
    }
}
