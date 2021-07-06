package com.fpjt.upmu.schedule.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.schedule.model.vo.Schedule;
@Repository
public class ScheduleDaoImpl implements ScheduleDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertSchedule(Schedule schedule) {
		return session.insert("schedule.insertSchedule", schedule);
	}

	@Override
	public List<Schedule> selectScheduleList(Map<String, Object> emp) {
		return session.selectList("schedule.selectScheduleList", emp);
	}

	@Override
	public List<Schedule> selectScheduleListIndex(Map<String, Object> idx) {
		return session.selectList("schedule.selectScheduleListIndex", idx);
	}

	@Override
	public int updateSchedule(Map<String, Object> schMap) {
		return session.update("schedule.updateSchedule", schMap);
	}

	@Override
	public int updateSchDate(Map<String, Object> schDateMap) {
		return session.update("schedule.updateSchDate", schDateMap);
	}

	@Override
	public int deleteSchedule(int schNo) {
		return session.delete("schedule.deleteSchedule", schNo);
	}

}
