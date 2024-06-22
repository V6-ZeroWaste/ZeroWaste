package kr.co.soaff.cart;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CartMapper {

	List<CartVO> list(CartVO vo);

	int updateAmount(CartVO vo);

	int delete(CartVO vo);

	int count(CartVO vo);

}
