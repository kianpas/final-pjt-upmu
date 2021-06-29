package com.fpjt.upmu.address.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
public class AddressExt extends Address {

	private String empName;
}
