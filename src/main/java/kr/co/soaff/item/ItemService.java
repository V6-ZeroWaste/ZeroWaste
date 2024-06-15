package kr.co.soaff.item;

import java.util.List;
import java.util.Map;

public interface ItemService {
    Map<String, Object> list(ItemVO vo);
    ItemVO detail(ItemVO vo);
    int count(ItemVO vo);
}
