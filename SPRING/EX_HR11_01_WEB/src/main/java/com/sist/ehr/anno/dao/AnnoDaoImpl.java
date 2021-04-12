package com.sist.ehr.anno.dao;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.sist.ehr.DTO;
import com.sist.ehr.User;

//<bean id="annoDaoImpl" class="com.sist.ehr.anno.dao.AnnoDaoImpl"/> 과 동일
@Repository
public class AnnoDaoImpl {
	
	

	final Logger LOG = LoggerFactory.getLogger(this.getClass());
	
	public List<User> getAll(User user)throws SQLException {
		return null;
	}
	
	/**
	 * 목록조회
	 * @param DTO
	 * @return List<?>
	 * @throws SQLException
	 */
	public List<?> doRetrieve(DTO dto) throws SQLException {
		return null;
	}
	
	/**
	 * 수정
	 * @param DTO
	 * @return int(1: 성공, 0: 실패)
	 * @throws SQLException
	 */
	public int doUpdate(DTO dto) throws SQLException {
		return 0;
	}
	
	//예외, 자원반납: JdbcTemplate 내부로 이동
	//query, param 처리
	/**
	 * 삭제
	 * @param DTO
	 * @return int(1: 성공, 0: 실패)
	 * @throws SQLException
	 */
	public int doDelete(DTO dto) throws SQLException {
		return 0;
	}

	/**
	 * 등록
	 * @param DTO
	 * @return int(1: 성공, 0: 실패)
	 * @throws SQLException
	 */
	public int doInsert(DTO dto) throws SQLException {
		LOG.debug("=========================");
		LOG.debug("=AnnoDaoImpl-doInsert=");
		LOG.debug("=========================");
		return 0;
	}

	/**
	 * 단건조회
	 * @param DTO
	 * @return DTO
	 * @throws SQLException
	 */
	public DTO doSelectOne(DTO dto) throws SQLException {
		return null;
	}
	
	
}
