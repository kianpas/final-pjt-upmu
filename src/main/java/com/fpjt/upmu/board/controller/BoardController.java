package com.fpjt.upmu.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.board.model.service.BoardService;
import com.fpjt.upmu.board.model.vo.Attachment;
import com.fpjt.upmu.common.util.UpmuUtils;
import com.fpjt.upmu.board.controller.BoardController;
import com.fpjt.upmu.board.model.vo.BoardExt;
import com.fpjt.upmu.board.model.vo.Board;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {
	@Autowired
	private ServletContext application;

	@Autowired
	private ResourceLoader resourceLoader;

	@Autowired
	private BoardService boardService;

	@GetMapping("/boardList.do")
	public ModelAndView boardList(ModelAndView mav,  @RequestParam(required = true, defaultValue = "1") int cpage, HttpServletRequest request,
			Model model) {
		try {
			log.debug("cpage = {}", cpage);
			final int limit = 10;
			final int offset = (cpage - 1) * limit;
			Map<String, Object> param = new HashMap<>();
			param.put("limit", limit);
			param.put("offset", offset);
			// 1.업무로직 : content영역 - Rowbounds
			List<BoardExt> list = boardService.selectBoardList(param);
			int totalContents = boardService.selectBoardTotalContents();
			String url = request.getRequestURI();
			//log.debug("totalContents = {}, url = {}", totalContents, url);
			String pageBar = UpmuUtils.getPageBar(totalContents, cpage, limit, url);
			
			// 2. jsp에 위임
			model.addAttribute("list", list);
			model.addAttribute("pageBar", pageBar);
			mav.setViewName("board/boardList");
		} catch (Exception e) {
			log.error("게시글 조회 오류!", e);
			throw e;
		}
		return mav;
	}

	@GetMapping("/boardForm.do")
	public void boardForm() {
	}

	@PostMapping("/boardEnroll.do")
	public String boardEnroll(@ModelAttribute BoardExt board, @RequestParam(name = "upFile") MultipartFile[] upFiles,
			RedirectAttributes redirectAttr) throws Exception {

		try {
			log.debug("board = {}", board);
			// 1. 파일 저장 : 절대경로 /resources/upload/board
			// pageContext:PageContext - request:HttpServletRequest - session:HttpSession -
			// application:ServletContext
			String saveDirectory = application.getRealPath("/resources/upload/board");
			log.debug("saveDirectory = {}", saveDirectory);

			// 디렉토리 생성
			File dir = new File(saveDirectory);
			if (!dir.exists())
				dir.mkdirs(); // 복수개의 디렉토리를 생성

			List<Attachment> attachList = new ArrayList<>();

			for (MultipartFile upFile : upFiles) {
				// input[name=upFile]로부터 비어있는 upFile이 넘어온다.
				if (upFile.isEmpty())
					continue;

				String renamedFilename = UpmuUtils.getRenamedFilename(upFile.getOriginalFilename());

				// a.서버컴퓨터에 저장
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest); // 파일이동

				// b.저장된 데이터를 Attachment객체에 저장 및 list에 추가
				Attachment attach = new Attachment();
				attach.setOriginalFilename(upFile.getOriginalFilename());
				attach.setRenamedFilename(renamedFilename);
				attachList.add(attach);
			}

			log.debug("attachList = {}", attachList);
			// board객체에 설정
			board.setAttachList(attachList);

			// 2. 업무로직 : db저장 board, attachment
			int result = boardService.insertBoard(board);

			// 3. 사용자피드백 & 리다이렉트
			redirectAttr.addFlashAttribute("msg", "게시글등록 성공!");
		} catch (Exception e) {
			log.error("게시글 등록 오류!", e);
			throw e;
		}
		return "redirect:/board/boardDetail.do?no=" + board.getNo();
	}

	@GetMapping("/boardDetail.do")
	public void selectOneBoard(@RequestParam int no, Model model) {

		try {
			boardService.readCount(no);
			// 1. 업무로직 : board - attachment
			BoardExt board = boardService.selectOneBoardCollection(no);
			log.debug("board = {}", board);

			// 2. jsp에 위임
			model.addAttribute("board", board);
		} catch (Exception e) {
			log.error("게시글 조회 오류!", e);
			throw e;
		}
		
		
	}

	@GetMapping("/fileDownload.do")
	public ResponseEntity<Resource> fileDownloadWithResponseEntity(@RequestParam int no)
			throws UnsupportedEncodingException {
		// 1. 업무로직 : db조회
		Attachment attach = boardService.selectOneAttachment(no);
		ResponseEntity<Resource> responseEntity = null;

		try {
			// 에러처리
			if (attach == null) {
				return ResponseEntity.notFound().build();
			}

			// 2. Resource객체
			String saveDirectory = application.getRealPath("/resources/upload/board");
			File downFile = new File(saveDirectory, attach.getRenamedFilename());
			Resource resource = resourceLoader.getResource("file:" + downFile);
			String filename = new String(attach.getOriginalFilename().getBytes("utf-8"), "iso-8859-1");
			// 3. ResponseEntity 객체 생성 및 리턴
			// builder패턴
			responseEntity =
					// 200번으로 설정
					ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE)
							.header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + filename).body(resource);

		} catch (Exception e) {
			log.error("파일 다운로드 오류", e);
			throw e;
		}
		return responseEntity;
	}

	@GetMapping("/boardUpdate.do")
	public void selectUpdate(@RequestParam int no, Model model) {

		// 1. 업무로직 : board - attachment
		BoardExt board = boardService.selectOneBoardCollection(no);
		log.debug("board = {}", board);

		// 2. jsp에 위임
		model.addAttribute("board", board);
	}

	@PostMapping("/boardUpdate")
	public void boardUpdate(@ModelAttribute BoardExt boardExt, @RequestParam(name = "upFile") MultipartFile[] upFiles)
			throws Exception {

		try {

			log.debug(" boardExt {}", boardExt);

			String saveDirectory = application.getRealPath("/resources/upload/board");
			log.debug("saveDirectory = {}", saveDirectory);

			List<Attachment> attachList = new ArrayList<>();
			for (MultipartFile upFile : upFiles) {
				log.debug("upFiles = {}", upFiles);
				// input[name=upFile]로부터 비어있는 upFile이 넘어온다.
				// 수정하고 첨부파일이 추가로 없으면 컨티뉴 처리됨
				if (upFile.isEmpty())
					continue;

				String renamedFilename = UpmuUtils.getRenamedFilename(upFile.getOriginalFilename());

				// a.서버컴퓨터에 저장
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest); // 파일이동

				// b.저장된 데이터를 Attachment객체에 저장 및 list에 추가
				Attachment attach = new Attachment();
				attach.setOriginalFilename(upFile.getOriginalFilename());
				attach.setRenamedFilename(renamedFilename);
				attachList.add(attach);
			}

			log.debug("attachList = {}", attachList);
			// board객체에 설정
			boardExt.setAttachList(attachList);

			int result = boardService.boardUpdate(boardExt);

			
		} catch (Exception e) {
			log.error("게시글 수정 오류", e);
			throw e;
		}
	}

	@PostMapping("/boardDelete/{no}")
	@ResponseBody
	public int boardDelete(@PathVariable String no) {
				
			int number = Integer.parseInt(no);
		try {
			log.debug("no {}", no);
			int result = boardService.boardDelete(number);
			log.debug("result {}", result);
			return result;
		} catch (Exception e) {
			log.error("게시글 삭제 오류", e);
			throw e;
		}
	}
	
	@GetMapping("/boardSearch.do")
	@ResponseBody
	public List<BoardExt> boardSearch(@RequestParam String search){
		try {
			log.debug("search {}", search);
			List<BoardExt> list = boardService.boardSearch(search);
			log.debug("list {}", list);
			return list;
		} catch (Exception e) {
			log.error("게시글 검색 오류", e);
			throw e;
		}
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public int deleteFile(@RequestBody int no) {
		try {
			log.debug("no {}", no);
			
			int result = boardService.deleteFile(no);
			return result;
		} catch (Exception e) {
			log.error("게시글 삭제 오류", e);
			throw e;
		}
	}
	
	@GetMapping("/mainBoardList")
	@ResponseBody
	public List<BoardExt> mainBoardList(){
		
		try {
			log.debug("{}", 11111111);
			List<BoardExt> list = boardService.mainBoardList();
			log.debug("list {}", list);
			return list;
		} catch (Exception e) {
			log.error("게시글 조회 오류", e);
			throw e;
		}
	}
	
}
