package kr.co.soaff.statistics.items;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soaff.review.ReviewVO;

@Service
public class ItemsServiceImpl implements ItemsService {
	@Autowired
	private ItemsMapper mapper;

	@Override
	public Map<String, Object> list(ItemsVO vo) {

		Map<String,Object> map = new HashMap();
        
        // 총개수 
     	int total = mapper.count(vo);
     	map.put("total", total);
     		
     	// 총 페이지수 
     	int totalPage = 1;
     	if(vo.getEntries() != 0) {
	     	totalPage = total / vo.getEntries();
	     	if(total %  vo.getEntries() > 0) {
	     			totalPage++;
	     	}
     	}
     	map.put("totalPage", totalPage);
     		
     	// 페이지 네이션 정보 
     	int endPage=(int) (Math.ceil(vo.getPage() / 10.0)*10);
     	int startPage=endPage-9;
     	if(endPage>totalPage) {
     			endPage=totalPage;
     		}
     	boolean isPrev= startPage>1;
     	boolean isNext = endPage < totalPage;

     	map.put("startPage", startPage);
     	map.put("endPage", endPage);
    	map.put("isPrev", isPrev);
     	map.put("isNext", isNext);
     		

    	List<ItemsVO> list = mapper.list(vo);
    	map.put("list", list);
		return map;
	}

}
