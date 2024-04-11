package com.red.boot.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QaVo {
    long qaNumber;
    String qaType;
    String qaTitle;
    String qaContent;    
    Date  qaRegDate ;
}
