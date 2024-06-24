package kr.co.soaff.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public  class UserFindServiceImpl implements UserFindService{
    @Autowired
    UserFindMapper mapper;

    @Override
    public UserVO idFindCheck(UserVO vo) {
        return mapper.idFindCheck(vo);
    }

    @Override
    public UserVO pwFindCheck(UserVO vo) {
        return mapper.pwFindCheck(vo);
    }

    @Override
    public int pwNewCheck(UserVO vo) {
        return mapper.pwNewCheck(vo);
    }

    @Override
    public int pwNewInsert(UserVO vo) {
        return mapper.pwNewInsert(vo);
    }
}
