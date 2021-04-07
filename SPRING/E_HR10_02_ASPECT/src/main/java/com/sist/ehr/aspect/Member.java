package com.sist.ehr.aspect;

public interface Member {
	int doSave();
	int doUpdate();
	int delete();
	void doRetrieve(int age);
}
