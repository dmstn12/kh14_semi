package com.kh.oneTrillionCompany.dto;

import java.util.Date;
import lombok.Data;

@Data
public class MemberDto {
	private String memberId;
	private String memberPw;
	private String memberName;
	private String memberNickname;
	private String memberRank;
	private int memberPoint;
	private Date memberJoin;
	private Date memberLogin;
	private int memberPost;
	private String memberAddress1;
	private String memberAddress2;
	private int memberHeight;
	private int memberWeight;
	
}