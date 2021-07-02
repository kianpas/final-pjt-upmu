package com.fpjt.upmu.schedule.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.schedule.model.dao.ScheduleDao;
import com.fpjt.upmu.schedule.model.vo.Schedule;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ScheduleServiceImpl implements ScheduleService {
	
	@Autowired
	public ScheduleDao scheduleDao;

	@Override
	public int insertSchedule(Schedule schedule) {
		return scheduleDao.insertSchedule(schedule);
	}

	@Override
	public List<Schedule> selectScheduleList(int i) {
		return scheduleDao.selectScheduleList(i);
	}

	@Override
	public int updateSchedule(Map<String, Object> schMap) {
		return scheduleDao.updateSchedule(schMap);
	}
	
	@Override
	public int updateSchDate(Map<String, Object> schDateMap) {
		return scheduleDao.updateSchDate(schDateMap);
	}

	@Override
	public int deleteSchedule(int schNo) {
		return scheduleDao.deleteSchedule(schNo);
	}

}

