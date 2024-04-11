package com.red.boot.service;



import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

import com.red.boot.domain.MemberVO;
import com.red.boot.domain.UserBidHistoryVo;

@Service
public class EmailService {
	
	@Autowired
	private JavaMailSender javaMailSender;

	public void sendEmail(String to, String subject, String text) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject(subject);
		message.setText(text);
		javaMailSender.send(message);
	}
	
	public void sendEmailToHtmlFinal(String to, String subject, long tradeNumber) {
		
		MimeMessagePreparator preparatory = mimeMessage -> {
		     MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "UTF-8");
		    
			StringBuffer sb = new StringBuffer();
		 	sb.append("<html><body>");
		 	sb.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>");
		 	sb.append("<h1>"+"상품에 낙찰되었습니다"+"<h1><br>");
		 	sb.append("응찰하신 상품에 낙찰되셨습니다.<br><br>");
		 	sb.append("<a href='http://localhost:8989/trade/get?tradeNumber=" + tradeNumber + "'>");
		 	sb.append("응찰 상품 확인하기");
		 	sb.append("</a>");
		 	sb.append("</body></html>");
		 	
		 	String content = sb.toString();
		    
		    helper.setTo(to);
		    helper.setSubject(subject);
		    
		    helper.setText(content, true); //html 타입이므로, 두번째 파라미터에 true 설정
		};
		

		javaMailSender.send(preparatory);
	}
	
	public void sendEmailToHtml(String to, String subject, 
									long tradeNumber, MemberVO mVo, UserBidHistoryVo ubVo) {

		MimeMessagePreparator preparatory = mimeMessage -> {
		    MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "UTF-8");
		    
			String userName = mVo.getUserName() ;
			String userMaskingName = "" ;
			
	        if (userName.length() == 2)
	        	userMaskingName = userName.substring(0,1) + "*" ;
	        else if (userName.length() == 3)
	        	userMaskingName = userName.substring(0,1)+"*"+userName.substring(2);
	        else if (userName.length() >= 4)
	        	userMaskingName = userName.substring(0,1)+"**"+userName.substring(3);
	        
	        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy 년 MM 월 dd 일 hh 시 mm 분") ;

	        DecimalFormat formatter = new DecimalFormat("###,### 원");
	        
			StringBuffer sb = new StringBuffer();
		 	sb.append("<html><body>");
		 	sb.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>");
		 	sb.append("<h1>"+ userMaskingName + "님, 상품에 응찰하셨습니다."+"</h1><br>");
		 	sb.append("상품번호 " + tradeNumber + "에 입찰하셨습니다.<br>");
		 	sb.append("응찰 상세정보<br><br>");
		 	sb.append("응찰자 : " + userMaskingName + "<br>");
		 	sb.append("응찰시간 : " + simpleDate.format(ubVo.getUserBidTime()) + "<br>");
		 	sb.append("응찰금액 : " + formatter.format(ubVo.getUserBidPrice()) + "<br>");
		 	
		 	sb.append("<a href='http://localhost:8989/trade/get?tradeNumber=" + tradeNumber + "'>");
		 	sb.append("응찰 상품 확인하기");
		 	sb.append("</a>");
		 	sb.append("</body></html>");
		 	
		 	String content = sb.toString();
		    
		    helper.setTo(to);
		    helper.setSubject(subject);
		    
		    helper.setText(content, true); //html 타입이므로, 두번째 파라미터에 true 설정
		};
		

		javaMailSender.send(preparatory);
	}
	
	
}
