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
	public List<Schedule> selectScheduleList(Map<String, Object> emp) {
		return scheduleDao.selectScheduleList(emp);
	}

	@Override
	public List<Schedule> selectScheduleListIndex(Map<String, Object> idx) {
		List<Schedule> list = scheduleDao.selectScheduleListIndex(idx);
		
		for(int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).getSchTitle());
			String s = list.get(i).getSchStart();
			s = s.substring(s.length()-5);
			
			if(s.contains("-")) {
				s = "00:00";
			}
			
			list.get(i).setSchStart(s);
		}
	
		return list;
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

