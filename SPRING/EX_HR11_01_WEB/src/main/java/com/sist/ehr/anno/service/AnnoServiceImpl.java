package com.sist.ehr.anno.service;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.ehr.DTO;
import com.sist.ehr.User;
import com.sist.ehr.anno.dao.AnnoDaoImpl;

@Service
public class AnnoServiceImpl implements AnnoService {
	final Logger LOG = LoggerFactory.getLogger(AnnoServiceImpl.class);

	@Autowired
	AnnoDaoImpl dao;
	
	@Override
	public List<User> getAll(User user) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<?> doRetrieve(DTO dto) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int doUpdate(DTO dto) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doDelete(DTO dto) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doInsert(DTO dto) throws SQLException {
		LOG.debug("==========================");
		LOG.debug("=AnnoServiceImpl-doInsert=");
		LOG.debug("==========================");
		return this.dao.doInsert(dto);
	}

	@Override
	public DTO doSelectOne(DTO dto) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
