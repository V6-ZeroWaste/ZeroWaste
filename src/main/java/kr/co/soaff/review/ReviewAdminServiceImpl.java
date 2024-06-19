package kr.co.soaff.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.soaff.qna.QnaVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewAdminServiceImpl implements ReviewAdminService {
	@Autowired
	ReviewAdminMapper mapper;
	
	@Override
	public Map<String,Object> list(ReviewVO vo) {
		Map<String,Object> map = new HashMap();
//		// 시작인덱스
//		int startIdx = (vo.getPage() - 1) * 10;
//		vo.setStartIdx(startIdx); // sql문에 파라미터로 넣어줌
//		List<QnaVO> list = qnaItemMapper.list(vo); // 목록

		int startIdx = (vo.getPage()-1) * 20;
		vo.setStartIdx(startIdx);

        // 총개수 
     	int total = mapper.count(vo);
     	map.put("total", total);
     		
     	// 총 페이지수 
     	int totalPage = total / 20;
     	if(total % 20 > 0) {
     			totalPage++;
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
     		

    	List<ReviewVO> list = mapper.list(vo);
    	map.put("list", list);
		return map;
	}

	@Override
	public ReviewVO detail(ReviewVO vo) {
		ReviewVO data = mapper.detail(vo);
		return data;
	}

	 @Override
	    public int updateStatus(ReviewVO vo) {
	        return mapper.updateStatus(vo);
	    }

}
