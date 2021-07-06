package com.fpjt.upmu.schedule.model.dao;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.schedule.model.vo.Schedule;

public interface ScheduleDao {

	int insertSchedule(Schedule schedule);

	List<Schedule> selectScheduleList(Map<String, Object> emp);

	List<Schedule> selectScheduleListIndex(Map<String, Object> idx);
	
	int updateSchedule(Map<String, Object> schMap);

	int updateSchDate(Map<String, Object> schDateMap);
	
	int deleteSchedule(int schNo);

}
