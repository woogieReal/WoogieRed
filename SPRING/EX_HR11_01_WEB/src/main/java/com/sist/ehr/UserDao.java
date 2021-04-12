package com.sist.ehr;

import java.sql.SQLException;
import java.util.List;

public interface UserDao {

	
	//#deleteUser -> doDelete(DTO dto) SQLException
	//#add -> doInsert(DTO dto) SQLException
	//#get -> doSelectOne(DTO dto) SQLException
	//update -> doUpdate(DTO dto) SQLException
	//목록조회 -> doRetrieve(DTO dto) SQLException

	int count(User user)throws ClassNotFoundException, SQLException;
	
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