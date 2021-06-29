package com.fpjt.upmu.comment.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fpjt.upmu.comment.model.service.CmtService;
import com.fpjt.upmu.comment.model.vo.Cmt;
import com.fpjt.upmu.comment.model.vo.CmtExt;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/comment")
public class CmtController {
	
	
	
	@Autowired
	private CmtService cmtService;
	
	@GetMapping("/commentList/{boardNo}")
	@ResponseBody
	public List<CmtExt> commentList(@PathVariable int boardNo){
		
		 try {
			List<CmtExt> commentList = cmtService.selectCommentList(boardNo);
			 
			 log.debug("commentList {}", commentList);
			 return commentList;
		} catch (Exception e) {
			log.error("댓글 조회 오류", e);
			throw e;
		}
		
	}
	
	
	@PostMapping("/addComment")
	@ResponseBody
	public int addComment(@RequestBody Cmt cmt) {
		try {
			log.debug("cmt {}", cmt);
			int result = cmtService.insertComment(cmt);

			return result;
		} catch (Exception e) {
			log.error("댓글 입력 오류", e);
			throw e;
		}
	}
	
	@PostMapping("/delComment")
	@ResponseBody
	public int delComment(@RequestBody int cmtNo) {
		try {
			log.debug("cmtNo {}", cmtNo);
			int result = cmtService.deleteComment(cmtNo);

			return result;
		} catch (Exception e) {
			log.error("댓글 삭제 오류", e);
			throw e;
		}
	}
	
	@PostMapping("/editComment")
	@ResponseBody
	public int editComment(@RequestBody Cmt cmt) {
		try {
			log.debug("cmt {}", cmt);
			int result = cmtService.editComment(cmt);

			return result;
		} catch (Exception e) {
			log.error("댓글 수정 오류", e);
			throw e;
		}
	}
	
}
