package util;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class S3Uploader {

    @Autowired
    private S3Client s3Client;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    // 이미지 등록
    public String uploadFile(MultipartFile file) throws IOException {
        return upload(file);
    }

    // 이미지 삭제
    public void deleteFile(String fileUrl) {
        String key = extractKeyFromUrl(fileUrl);
        if (key != null && !key.isEmpty()) {
            DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
                    .bucket(bucket)
                    .key(key)
                    .build();
            s3Client.deleteObject(deleteObjectRequest);
        }
    }
    //이미지 수정
    public String updateFile(String oldFileUrl, MultipartFile newFile) throws IOException {
        deleteFile(oldFileUrl);
        return upload(newFile);
    }

    // 랜덤 파일명 생성 메서드
    private String generateRandomFilename(MultipartFile multipartFile) {
        String originalFilename = multipartFile.getOriginalFilename();
        String fileExtension = validateFileExtension(originalFilename);
        return UUID.randomUUID() + "." + fileExtension;
    }

    // 파일 확장자 검증 메서드
    private String validateFileExtension(String originalFilename) {
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase();
        List<String> allowedExtensions = List.of("jpg", "png", "gif", "jpeg");

        if (!allowedExtensions.contains(fileExtension)) {
            throw new IllegalArgumentException("잘못된 파일 확장자: " + fileExtension);
        }
        return fileExtension;
    }

    private String extractKeyFromUrl(String fileUrl) {
        try {
            int startIndex = fileUrl.indexOf(".com/") + 5; // ".com/" 이후의 경로 추출
            return fileUrl.substring(startIndex);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // 파일 업로드 메서드
    public String upload(MultipartFile file) throws IOException {
        String key = generateRandomFilename(file);

        PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(bucket)
                .key(key)
                .contentType(file.getContentType())
                .build();

        s3Client.putObject(putObjectRequest, RequestBody.fromInputStream(file.getInputStream(), file.getSize()));

        return s3Client.utilities().getUrl(builder -> builder.bucket(bucket).key(key)).toExternalForm();
    }
}
