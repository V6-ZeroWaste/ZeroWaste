//package util;
//
//import java.io.IOException;
//import java.nio.file.Paths;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Component;
//import org.springframework.web.multipart.MultipartFile;
//
//import software.amazon.awssdk.services.s3.S3Client;
//import software.amazon.awssdk.services.s3.model.PutObjectRequest;
//
//
//
//
//
//@Component
//public class S3Uploader {
//	@Autowired
//	private S3Client s3Client;
//
//	@Value("${cloud.aws.s3.bucket}")
//	private String bucketName;
//
//	public String upload(MultipartFile file) throws IOException {
//		String key = Paths.get("uploads", file.getOriginalFilename()).toString();
//
//		PutObjectRequest putObjectRequest = PutObjectRequest.builder().bucket(bucketName).key(key).build();
//
//		s3Client.putObject(putObjectRequest, file.getInputStream());
//
//		return s3Client.utilities().getUrl(builder -> builder.bucket(bucketName).key(key)).toExternalForm();
//	}
//}