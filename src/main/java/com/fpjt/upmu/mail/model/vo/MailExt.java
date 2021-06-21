package com.fpjt.upmu.mail.model.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
public class MailExt extends Mail{
	
	private boolean hasAttachment;
	private List<MailAttach> attachList;

}
