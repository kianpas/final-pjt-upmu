package com.fpjt.upmu.mail.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MailAttach {
	
	private int attachNo;
	private int mailNo;
	private String originalFilename;
	private String renamedFilename;
	private boolean attachmentStatus;

}
