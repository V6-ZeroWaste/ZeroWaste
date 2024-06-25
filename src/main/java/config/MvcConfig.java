package config;

import java.util.Properties;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.*;

import com.zaxxer.hikari.HikariDataSource;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import util.AdminLoginInterceptor;
import util.UserLoginInterceptor;

@Configuration
@ComponentScan(basePackages = { "kr.co.soaff","util"})
@EnableWebMvc
@MapperScan(basePackages = { "kr.co.soaff" }, annotationClass = Mapper.class) // 인터페이스 스캔
@EnableTransactionManagement
public class MvcConfig implements WebMvcConfigurer {
	// 파일업로드
	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipart = new CommonsMultipartResolver();
		// 파일사이즈
		multipart.setMaxUploadSize(1024 * 1024 * 5);
		multipart.setDefaultEncoding("utf-8");
		return multipart;
	}

	// db.properties에 있는 속성
	@Value("${db.driver}")
	private String driver;
	@Value("${db.url}")
	private String url;
	@Value("${db.username}")
	private String username;
	@Value("${db.password}")
	private String password;

	// AWS S3 속성
	@Value("${cloud.aws.credentials.access-key}")
	private String accessKey;
	@Value("${cloud.aws.credentials.secret-key}")
	private String secretKey;
	@Value("${cloud.aws.region.static}")
	private String region;

	// ViewResolver 설정(JSP 경로)
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		registry.jsp("/WEB-INF/views/", ".jsp");
	}

	// 정적페이지 처리(컨트롤러가 아니라 톰캣에서 처리하기 위해)
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

	// 비즈니스 로직이 필요없는 URL 매핑
	@Override
	public void addViewControllers(ViewControllerRegistry reg) {
		reg.addViewController("/user/basic");
		reg.addViewController("/user/basic-mypage");
		reg.addViewController("/user/test");
		reg.addViewController("/user/order/cancelForm2");

	}

	// HikariCP
	@Bean
	public HikariDataSource dataSource() {
		HikariDataSource dataSource = new HikariDataSource();
		dataSource.setDriverClassName(driver);
		dataSource.setJdbcUrl(url);
		dataSource.setUsername(username);
		dataSource.setPassword(password);
		return dataSource;
	}

	// MyBatis
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean ssf = new SqlSessionFactoryBean();
		ssf.setDataSource(dataSource()); // CP 객체 주입

		return ssf.getObject();
	}
	// DAO에서 주입받을 객체
//		@Bean
//		public SqlSessionTemplate sqlSessionTemplate() throws Exception {
//			return new SqlSessionTemplate(sqlSessionFactory()); // MyBatis 객체(빈)를 주입
//		}

	// 트랜잭션 설정
	@Bean
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager dtm = new DataSourceTransactionManager(dataSource());
//			dtm.setDataSource(dataSource());
		return dtm;
	}

	// 어드민 로그인 인터셉터 빈등록
	@Bean
	public AdminLoginInterceptor AdminLoginInterception() {
		return new AdminLoginInterceptor();
	}
	// 유저 로그인 인터셉터 빈등록
	@Bean
	public UserLoginInterceptor UserLoginInterception() {
		return new UserLoginInterceptor();
	}

	//인터셉터 설정
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// url 설정
		// 어드민 로그인 인터셉터 설정
		registry.addInterceptor(AdminLoginInterception()).addPathPatterns("/admin/**") .excludePathPatterns("/admin/login");
		// 어드민 로그인 인터셉터 설정
		registry.addInterceptor(UserLoginInterception()).addPathPatterns("/order/**").addPathPatterns("/mypage/**").addPathPatterns("/cart/**");
	}
	



	// properties 설정
	@Bean
	public static PropertyPlaceholderConfigurer propreties() {
		PropertyPlaceholderConfigurer config = new PropertyPlaceholderConfigurer();
		config.setLocations(new ClassPathResource("db.properties"), new ClassPathResource("s3.properties"), new ClassPathResource("pay.properties"), new ClassPathResource("mail.properties"));

		return config;
	}

	@Bean
	public S3Client s3Client() {
		return S3Client.builder().region(Region.of(region))
				.credentialsProvider(StaticCredentialsProvider.create(AwsBasicCredentials.create(accessKey, secretKey)))
				.build();
	}
	
	// 메일 설정
	   @Value("${spring.mail.host}")
	   private String mailHost;
	   @Value("${spring.mail.port}")
	   private int mailPort;
	   @Value("${spring.mail.username}")
	   private String mailUsername;
	   @Value("${spring.mail.password}")
	   private String mailPassword;
	   @Value("${spring.mail.properties.mail.smtp.auth}")
	   private boolean mailSmtpAuth;
	   @Value("${spring.mail.properties.mail.smtp.starttls.enable}")
	   private boolean mailStarttlsEnable;
	   @Value("${spring.mail.properties.mail.smtp.starttls.required}")
	   private boolean mailStarttlsRequired;
	   @Value("${spring.mail.properties.mail.smtp.connectiontimeout}")
	   private int mailConnectionTimeout;
	   @Value("${spring.mail.properties.mail.smtp.timeout}")
	   private int mailTimeout;
	   @Value("${spring.mail.properties.mail.smtp.writetimeout}")
	   private int mailWriteTimeout;

	
	@Bean
	   public JavaMailSender javaMailSender() {
	       JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
	       mailSender.setHost(mailHost);
	       mailSender.setPort(mailPort);
	       mailSender.setUsername(mailUsername);
	       mailSender.setPassword(mailPassword);
	       mailSender.setDefaultEncoding("UTF-8");

	       Properties mailProperties = new Properties();
	       mailProperties.put("mail.smtp.auth", mailSmtpAuth);
	       mailProperties.put("mail.smtp.starttls.enable", mailStarttlsEnable);
	       mailProperties.put("mail.smtp.starttls.required", mailStarttlsRequired);
	       mailProperties.put("mail.smtp.connectiontimeout", mailConnectionTimeout);
	       mailProperties.put("mail.smtp.timeout", mailTimeout);
	       mailProperties.put("mail.smtp.writetimeout", mailWriteTimeout);

	       mailSender.setJavaMailProperties(mailProperties);
	       return mailSender;
	   }


}