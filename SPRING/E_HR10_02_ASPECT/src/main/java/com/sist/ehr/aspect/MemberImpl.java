package com.sist.ehr.aspect;

import org.apache.log4j.Logger;
import org.springframework.util.StopWatch;

public class MemberImpl implements Member {
	final Logger LOG = Logger.getLogger(MemberImpl.class);
	
	StopWatch stopWatch = new StopWatch();
	
	@Override
	public int doSave() {
		LOG.debug("--------------------------");
		LOG.debug("-doSave()-");
		LOG.debug("--------------------------");
		return 0;
	}

	@Override
	public int doUpdate() {
		LOG.debug("--------------------------");
		LOG.debug("-doUpdate()-");
		LOG.debug("--------------------------");
		return 0;
	}

	@Override
	public int delete() {
		LOG.debug("--------------------------");
		LOG.debug("-delete()-");
		LOG.debug("--------------------------");
		return 0;
	}

	@Override
	public void doRetrieve(int age) {
		
		for(int i = 0; i < 90000000; i++) {
			
		}
		
		LOG.debug("--------------------------");
		LOG.debug("-doRetrieve()-");
		LOG.debug("--------------------------");

	}

}
