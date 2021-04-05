package com.sist.ehr;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoImpl implements UserDao {
	
	final static Logger LOG = Logger.getLogger(UserDaoImpl.class);
	
	//Spring이 제공
	//예외처리, 자원반납을 다 처리해줌
	//개발자는 쿼리와 param만 처리
	JdbcTemplate jdbcTemplate;
	
	DataSource dataSource;
	
	RowMapper<User> row = new RowMapper<User>() {

		public User mapRow(ResultSet rs, int rowNum) throws SQLException {
			User userVO = new User();
			userVO.setuId(rs.getString("u_id"));
			userVO.setName(rs.getString("name"));
			userVO.setPasswd(rs.getString("passwd"));

										//int를 넣으면 level로 변환
			userVO.setLevel(Level.valueOf(rs.getInt("u_level")));
			userVO.setLogin(rs.getInt("login"));
			userVO.setRecommend(rs.getInt("recommend"));
			
			userVO.setEmail(rs.getString("email"));
			userVO.setRegDt(rs.getString("reg_dt"));
			
			LOG.debug("rowNum: "+rowNum);
			return userVO;
		}
	}; 
	
	public UserDaoImpl() {}
	
	//setter를 통한 주입
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	/**
	 * 다건조회
	 * @param user
	 * @return List<User>
	 * @throws SQLException
	 */
	public List<User> getAll(User user)throws SQLException{
		List<User> list = null;
		
		StringBuffer sb = new StringBuffer(200);
		sb.append(" SELECT                \n");
		sb.append("     u_id,             \n");
		sb.append("     name,             \n");
		sb.append("     passwd,           \n");
		//컬럼추가: 2021/03/30
		sb.append("     u_level,          \n");
		sb.append("     login,            \n");
		sb.append("     recommend,        \n");
		sb.append("     email,            \n");
		sb.append("     TO_CHAR(reg_dt,'YYYY/MM/DD HH24MISS') reg_dt         \n");
		sb.append(" FROM hr_member               \n");
		sb.append(" WHERE u_id LIKE  ? || '%'    \n");
		sb.append(" ORDER BY u_id                \n");
		LOG.debug("==================================");
		LOG.debug("=sql=\n"+sb.toString());
		LOG.debug("=param="+user.toString());
		LOG.debug("==================================");
		
		Object[] args = {user.getuId()};
		list = this.jdbcTemplate.query(sb.toString(), args, row);
		for(User vo : list) {
			LOG.debug(vo);
		}
		
		return list;
	}

	
	/**
	 * 등록 건수 조회
	 * @param user
	 * @return int
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public int count(User user)throws ClassNotFoundException, SQLException {
		int count = 0;
		
		StringBuffer sb = new StringBuffer(200);
		sb.append(" SELECT COUNT(*) cnt       \n");
		sb.append(" FROM hr_member            \n");
		sb.append(" WHERE u_id LIKE ? || '%'  \n");
		LOG.debug("==================================");
		LOG.debug("=sql=\n"+sb.toString());
		LOG.debug("=param="+user.toString());
		LOG.debug("==================================");
		
		Object[] args = {user.getuId()};
		count = this.jdbcTemplate.queryForObject(sb.toString(), args, Integer.class);
		
		LOG.debug("==================================");
		LOG.debug("=new_count="+count);
		LOG.debug("==================================");
		
		return count;
	}
	
	@Override
	public int doDelete(DTO dto) throws SQLException {
		int flag = 0;
		User user = (User)dto;
		
		StringBuffer sb = new StringBuffer(200);
		sb.append(" DELETE FROM hr_member   \n");
		sb.append(" WHERE u_id = ?          \n");
		LOG.debug("=sql=\n"+sb.toString());
				
		Object[] args = {user.getuId()};
		LOG.debug("==================================");
		LOG.debug("=user="+user);
		LOG.debug("==================================");
		
		flag = jdbcTemplate.update(sb.toString(), args);
		return flag;
	}

	/**
	 * 등록
	 * @param user
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	@Override
	public int doInsert(DTO dto) throws SQLException {

		int flag = 0;
		User user = (User)dto;

		StringBuffer sb = new StringBuffer(300);
		sb.append(" INSERT INTO hr_member (   \n");
		sb.append("     u_id,                 \n");
		sb.append("     name,                 \n");
		sb.append("     passwd,               \n");
		//추가 컬럼
		sb.append("     u_level,              \n");
		sb.append("     login,                \n");
		sb.append("     recommend,            \n");
		sb.append("     email,                \n");
		sb.append("     reg_dt                 \n");
		
		sb.append(" ) VALUES (                \n");
		sb.append("     ?,                    \n");
		sb.append("     ?,                    \n");
		sb.append("     ?,                    \n");
		//추가 컬럼
		sb.append("     ?,                    \n");
		sb.append("     ?,                    \n");
		sb.append("     ?,                    \n");
		sb.append("     ?,                    \n");
		sb.append("     SYSDATE               \n");
		
		sb.append(" )                         \n");
		LOG.debug("=sql=\n" + sb.toString());
		
		Object[] args = { 
				user.getuId(), 
				user.getName(), 
				user.getPasswd(), 
				user.getLevel().getValue(),
				user.getLogin(),
				user.getRecommend(),
				user.getEmail()
		};
		LOG.debug("==================================");
		LOG.debug("=user="+user);
		LOG.debug("==================================");

		flag = jdbcTemplate.update(sb.toString(), args);
		return flag;
	}

	/**
	 * 단건조회
	 * @param id
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	@Override
	public DTO doSelectOne(DTO dto) throws SQLException {
		User inVO = (User)dto;
		User outVO = null;
		
		StringBuffer sb = new StringBuffer(200);
		sb.append(" SELECT                \n");
		sb.append("     u_id,             \n");
		sb.append("     name,             \n");
		sb.append("     passwd,           \n");
		//컬럼추가: 2021/03/30
		sb.append("     u_level,          \n");
		sb.append("     login,            \n");
		sb.append("     recommend,        \n");
		sb.append("     email,            \n");
		sb.append("     TO_CHAR(reg_dt,'YYYY/MM/DD HH24MISS') reg_dt         \n");
		
		sb.append(" FROM                  \n");
		sb.append("     hr_member         \n");
		sb.append(" WHERE u_id = ?        \n");
		LOG.debug("==================================");
		LOG.debug("=sql=\n"+sb.toString());
		LOG.debug("==================================");		
		
		Object[] args = {inVO.getuId()};
		LOG.debug("=args="+args);
		
		outVO = this.jdbcTemplate.queryForObject(sb.toString(), args, row);
		
		LOG.debug("==================================");
		LOG.debug("=outVO="+outVO);
		LOG.debug("==================================");
		
		if(null == outVO) {
			throw new EmptyResultDataAccessException(1);
		}
		
		return outVO;
	}

	@Override
	public List<?> doRetrieve(DTO dto) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int doUpdate(DTO dto) throws SQLException {
		
		int flag = 0;
		User user = (User)dto;

		StringBuffer sb = new StringBuffer(300);
		sb.append(" UPDATE hr_member     \n");
		sb.append(" SET                  \n");
		sb.append(" 	name      = ?,   \n");
		sb.append(" 	passwd    = ?,   \n");
		sb.append(" 	u_level   = ?,   \n");
		sb.append(" 	login     = ?,   \n");
		sb.append(" 	recommend = ?,   \n");
		sb.append(" 	email     = ?,   \n");
		sb.append(" 	reg_dt    = SYSDATE    \n");
		
		sb.append(" WHERE u_id    = ?    \n");
		LOG.debug("=sql=\n" + sb.toString());
		
		Object[] args = { 
				user.getName(), 
				user.getPasswd(), 
				user.getLevel().getValue(),
				user.getLogin(),
				user.getRecommend(),
				user.getEmail(),
				user.getuId()
		};
		
		LOG.debug("=args=\n"+args);
		flag = jdbcTemplate.update(sb.toString(), args);
		
		return flag;
	}
	
	
	
}
