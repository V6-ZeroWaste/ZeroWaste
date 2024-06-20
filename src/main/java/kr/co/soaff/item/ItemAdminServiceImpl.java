package kr.co.soaff.item;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import util.S3Uploader;

@Service
public class ItemAdminServiceImpl implements ItemAdminService {

	@Autowired
	private ItemAdminMapper mapper;
    @Autowired
    private S3Uploader s3Uploader;

	@Override
	public List<ItemVO> list(ItemVO vo) {
		return mapper.list(vo);
	}

	@Override
	public Map<String, Object> index(ItemVO vo) {
		int totalCount = mapper.count(vo); // 총 게시물 수
		// 총 페이지 수
		int totalPage = totalCount / 20;
		if (totalCount % 20 > 0)
			totalPage++;

		// 시작인덱스
		int startIdx = (vo.getPage() - 1) * 20;
		vo.setStartIdx(startIdx); // sql문에 파라미터로 넣어줌
		List<ItemVO> items = mapper.list(vo); // 목록

		// 페이징처리
		int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10); // 끝페이지
		int startPage = endPage - 9; // 시작페이지

		if (endPage > totalPage)
			endPage = totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;

		Map<String, Object> map = new HashMap<>();
		map.put("total", totalCount);
		map.put("totalPage", totalPage);
		map.put("items", items); // 모델에 직접 넣어줘도 됨

		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("isPrev", prev);
		map.put("isNext", next);

		return map;

	}

	@Override
	public ItemVO detail(ItemVO vo) {
		return mapper.detail(vo);
	}

	@Override
	public int insert(ItemVO vo, MultipartFile file, HttpServletRequest request){
		String voDetail = vo.getDetail();
		if(voDetail != null && !voDetail.isEmpty()){
			List<String> strings = extractSrcAttributes(voDetail);
			List<String> uploadedImages = new ArrayList<>();
			for (String imageUrl : strings) {
				try {
					MultipartFile fileFromUrl = getFileFromUrl(imageUrl);
					String uploadImage = s3Uploader.uploadFile(fileFromUrl);
					uploadedImages.add(uploadImage);
				}catch (Exception e){
					e.printStackTrace();
				}
			}
			String updatedDetail = updateHtmlWithUploadedImages(voDetail, uploadedImages);
			vo.setDetail(updatedDetail);
		}
		if (!file.isEmpty()) {
			try {
				String imgUrl = s3Uploader.uploadFile(file);
				vo.setItem_img(imgUrl);
			}catch (IOException e){
				e.printStackTrace();
				return 0;
			}
		}
		vo.setDiscount_rate((int) (((vo.getPrice() - vo.getDiscounted_price()) / (float) vo.getPrice()) * 100));
		int r = mapper.insert(vo);
		return r;
	}
//	@Override
//	public int insert(ItemVO vo, MultipartFile file, HttpServletRequest request) {
//		if (!file.isEmpty()) {
//			String org = file.getOriginalFilename();
//			String ext = org.substring(org.lastIndexOf("."));
//			String real = System.currentTimeMillis() + ext;
//			String uploadDir = request.getRealPath("/upload/item_img/");
//			String path = uploadDir + real;
//
//			File dir = new File(uploadDir);
//			if (!dir.exists()) {
//				dir.mkdirs();
//			}
//
//			try {
//				file.transferTo(new File(path));
//			} catch (Exception e) {
//			}
//			vo.setItem_img(real);
//		}
//		vo.setDiscount_rate((int) (((vo.getPrice() - vo.getDiscounted_price()) / (float) vo.getPrice()) * 100));
//
//		int r = mapper.insert(vo);
//		return r;
//	}

	@Transactional
	@Override
	public int update(ItemVO vo, MultipartFile file, HttpServletRequest request) {
		String voDetail = vo.getDetail();
		if(voDetail != null && !voDetail.isEmpty()){
			List<String> strings = extractSrcAttributes(voDetail);
			List<String> uploadedImages = new ArrayList<>();
			for (String imageUrl : strings) {
				try {
					MultipartFile fileFromUrl = getFileFromUrl(imageUrl);
					String uploadImage = s3Uploader.uploadFile(fileFromUrl);
					uploadedImages.add(uploadImage);
				}catch (Exception e){
					e.printStackTrace();
				}
			}
			String updatedDetail = updateHtmlWithUploadedImages(voDetail, uploadedImages);
			vo.setDetail(updatedDetail);
		}


		if (!file.isEmpty()) {
			if(vo.getItem_img() != null && !vo.getItem_img().isEmpty()){ //기존 파일이 있을 경우 s3 update
				ItemVO detail = mapper.detail(vo);
				try {
					String imgUrl = s3Uploader.updateFile(detail.getItem_img(), file);
					vo.setItem_img(imgUrl);
				}catch(IOException e){
					e.printStackTrace();
					return 0;
				}
			}else{ //기존 파일이 없을 경우 s3 upload
				try {
					String imgUrl = s3Uploader.uploadFile(file);
					vo.setItem_img(imgUrl);
				}catch (IOException e){
					e.printStackTrace();
					return 0;
				}
			}
		}
		else{ //파일이 없을 경우 기존 파일 재등록
			ItemVO detail = mapper.detail(vo);
			vo.setItem_img(detail.getItem_img());
		}
		vo.setDiscount_rate((int) (((vo.getPrice() - vo.getDiscounted_price()) / (float) vo.getPrice()) * 100));
		return mapper.update(vo);
	}
//	@Transactional
//	@Override
//	public int update(ItemVO vo, MultipartFile file, HttpServletRequest request) {
//		if (!file.isEmpty()) {
//			String org = file.getOriginalFilename();
//			String ext = org.substring(org.lastIndexOf("."));
//			String real = System.currentTimeMillis() + ext;
//			String uploadDir = request.getRealPath("/upload/item_img/");
//			String path = uploadDir + real;
//
//			File dir = new File(uploadDir);
//			if (!dir.exists()) {
//				dir.mkdirs();
//			}
//
//			try {
//				file.transferTo(new File(path));
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			vo.setItem_img(real);
//		}
//		else{
//			ItemVO detail = mapper.detail(vo);
//			vo.setItem_img(detail.getItem_img());
//		}
//		vo.setDiscount_rate((int) (((vo.getPrice() - vo.getDiscounted_price()) / (float) vo.getPrice()) * 100));
//		return mapper.update(vo);
//	}

	@Override
	public int delete(ItemVO vo, HttpServletRequest request) {
		ItemVO data = mapper.detail(vo);
		if (data.getItem_img() != null && !"".equals(data.getItem_img())) {
			s3Uploader.deleteFile(data.getItem_img());
		}
		return mapper.delete(data.getItem_no());
	}
//	@Override
//	public int delete(ItemVO vo, HttpServletRequest request) {
//		ItemVO data = mapper.detail(vo);
//		if (data.getItem_img() != null && !"".equals(data.getItem_img())) {
//			File f = new File(request.getRealPath("/upload/item_img/") + data.getItem_img());
//			f.delete();
//		}
//		return mapper.delete(data.getItem_no());
//	}

	@Override
	public int deleteImg(ItemVO vo, HttpServletRequest request) {
		ItemVO data = mapper.detail(vo);
		s3Uploader.deleteFile(data.getItem_img());
		data.setItem_img("");
		return mapper.update(data);
	}
//	@Override
//	public int deleteImg(ItemVO vo, HttpServletRequest request) {
//		ItemVO data = mapper.detail(vo);
//		if (data.getItem_img() != null && !"".equals(data.getItem_img())) {
//			File f = new File(request.getRealPath("/upload/item_img/") + data.getItem_img());
//			if (f.exists() && f.isFile()) {
//				if (f.delete()) {
//					System.out.println("File deleted successfully");
//				} else {
//					System.out.println("File deletion failed");
//				}
//			} else {
//				System.out.println("File does not exist or is not a file");
//			}
//		}
//		data.setItem_img("");
//		return mapper.update(data);
//	}

	@Override
	public int count(ItemVO vo) {
		return mapper.count(vo);
	}

	@Override
	public List<CategoryVO> categories() {
		return mapper.categories();
	}

	@Override
	public int updateCategory(CategoryVO vo) {
		return mapper.updateCategory(vo);
	}

	@Override
	public int deleteCategory(int category_no) {
		return mapper.deleteCategory(category_no);
	}

	@Override
	public int insertCategory(CategoryVO vo) {
		return mapper.insertCategory(vo);
	}

	@Override
	public String uploadItemImgAjax(MultipartFile file) {
		String uploadedUrl = null;
		try {
			uploadedUrl = s3Uploader.uploadFile(file);
		}catch (Exception e){}
		return uploadedUrl;
	}

	public static MultipartFile getFileFromUrl(String fileUrl) throws IOException {
		URL url = new URL(fileUrl);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestMethod("GET");

		try (InputStream inputStream = connection.getInputStream()) {
			byte[] fileBytes = IOUtils.toByteArray(inputStream);
			String fileName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);

			FileItem fileItem = new DiskFileItem("file", connection.getContentType(), false, fileName, fileBytes.length, new File(System.getProperty("java.io.tmpdir")));
			try (OutputStream os = fileItem.getOutputStream()) {
				os.write(fileBytes);
			}

			return new CommonsMultipartFile(fileItem);
		}
	}

	public List<String> extractSrcAttributes(String html) {
		List<String> srcList = new ArrayList<>();
		String regex = "src\\s*=\\s*\"([^\"]*)\"";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(html);

		while (matcher.find()) {
			srcList.add(matcher.group(1));
		}

		return srcList;
	}

	public String updateHtmlWithUploadedImages(String html, List<String> uploadedImageUrls) {
		StringBuffer updatedHtml = new StringBuffer();
		String regex = "src\\s*=\\s*\"([^\"]*)\"";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(html);

		int index = 0;
		while (matcher.find() && index < uploadedImageUrls.size()) {
			matcher.appendReplacement(updatedHtml, "src=\"" + uploadedImageUrls.get(index++) + "\"");
		}
		matcher.appendTail(updatedHtml);

		return updatedHtml.toString();
	}

}
