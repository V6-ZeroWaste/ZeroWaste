package kr.co.soaff.item;

import kr.co.soaff.review.ReviewVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ItemMapper {
    List<ItemVO> list(ItemVO vo);
    ItemVO detail(ItemVO vo);
    int count(ItemVO vo);

}
