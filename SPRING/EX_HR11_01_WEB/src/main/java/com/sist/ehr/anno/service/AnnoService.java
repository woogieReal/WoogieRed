package com.sist.ehr.anno.service;

import java.sql.SQLException;
import java.util.List;

import com.sist.ehr.DTO;
import com.sist.ehr.User;

public interface AnnoService {
	
	List<User> getAll(User user)throws SQLException;
	
	/**
	 * 목록조회
	 * @param DTO
	 * @return List<?>
	 * @throws SQLException
	 */
	List<?> doRetrieve(DTO dto) throws SQLException;
	
	/**
	 * 수정
	 * @param DTO
	 * @return int(1: 성공, 0: 실패)
	 * @throws SQLException
	 */
	int doUpdate(DTO dto) throws SQLException;
	
	//예외, 자원반납: JdbcTemplate 내부로 이동
	//query, param 처리
	/**
	 * 삭제
	 * @param DTO
	 * @return int(1: 성공, 0: 실패)
	 * @throws SQLException
	 */
	int doDelete(DTO dto) throws SQLException;

	/**
	 * 등록
	 * @param DTO
	 * @return int(1: 성공, 0: 실패)
	 * @throws SQLException
	 */
	int doInsert(DTO dto) throws SQLException;

	/**
	 * 단건조회
	 * @param DTO
	 * @return DTO
	 * @throws SQLException
	 */
	DTO doSelectOne(DTO dto) throws SQLException;
	
}
