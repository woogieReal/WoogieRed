package com.sist.ehr.member.service;

import java.sql.SQLException;

import com.sist.ehr.DTO;

public interface UserService {

	/**
	 * 최초 회원가입시 등급: BASIC
	 * Level이 NULL이면 BASIC 처리
	 * @param dto
	 * @return
	 * @throws SQLException
	 */
	int add(DTO dto) throws SQLException;

	void upgradeLevels() throws SQLException, IllegalAccessException;

}