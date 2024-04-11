package com.red.boot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.red.boot.domain.PageInfo;
import com.red.boot.domain.QaVo;
import com.red.boot.mapper.AnnouncementMapper;
import com.red.boot.mapper.QaMapper;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

@Service
@AllArgsConstructor
@ToString
public class QaServiceImpl implements QaService {
	
	@Autowired
	QaMapper mapper ;
	
	@Override
	public List<QaVo> getList() {
		return mapper.getQaList() ;
	}

	@Override
	public QaVo get(Long qaNumber) {
		return mapper.getQaOne(qaNumber);
	}

	@Override
	public int register(QaVo qaVo) {
		return mapper.insertQa(qaVo);
	}

	@Override
	public int modify(QaVo qaVo) {
		return mapper.updateQa(qaVo);
	}

	@Override
	public int remove(Long qaNumber) {
				return mapper.deleteQa(qaNumber);
	}

	@Override
	public List<QaVo> getListByType(String qaType) {
		return mapper.getListByType(qaType);
	}



}
