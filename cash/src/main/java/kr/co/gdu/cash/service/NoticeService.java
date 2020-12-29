package kr.co.gdu.cash.service;

import java.io.File;
import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.gdu.cash.mapper.*;
import kr.co.gdu.cash.vo.*;

@Service
@Transactional
public class NoticeService {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String PATH = "/home/ubuntu/tomcat9/webapps/cashfile/upload/"; 
	
	@Autowired private NoticeMapper noticeMapper;
	@Autowired private CashbookMapper cashbookMapper;
	@Autowired private NoticefileMapper noticefileMapper;
	
	public List<Notice> getNoticeListByPage(int currentPage, int rowPerPage) {
		int beginRow = (currentPage - 1) * rowPerPage;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		List<Notice> noticeList = noticeMapper.selectNoticeListByPage(map);
		
		return noticeList;
	}
	
	
	public Map<String, Object> getNoticeAndInOutList() { 
		List<Notice> noticeList = noticeMapper.selectLatestNoticeList();
		List<Map<String, Object>> inOutList = cashbookMapper.selectCashInOutList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeList", noticeList);
		map.put("inOutList", inOutList);
		return map;
	}
	
	public List<Notice> getNoticeList(){
		return noticeMapper.selectLatestNoticeList();
	}
	public void addNotice(NoticeForm noticeForm) {
		
		Notice notice = new Notice();
		notice.setNoticeTitle(noticeForm.getNoticeTitle());
		notice.setNoticeContent(noticeForm.getNoticeContent());
		noticeMapper.insertNotice(notice);
		
		List<Noticefile> noticefile = null;
		if(noticeForm.getNoticefileList() != null) {
			noticefile = new ArrayList<Noticefile>();
			for(MultipartFile mf : noticeForm.getNoticefileList()) {
				Noticefile nf = new Noticefile();
				nf.setNoticeId(notice.getNoticeId());
				int p = mf.getOriginalFilename().lastIndexOf(".");
				String ext = mf.getOriginalFilename().substring(p).toLowerCase();
				String filename = UUID.randomUUID().toString().replace("-", "");
				nf.setNoticefileName(filename+ext);
				nf.setNoticefileSize(mf.getSize());
				nf.setNoticefileType(mf.getContentType());
				noticefile.add(nf);
				logger.debug("for 문 : "+nf);
				try {
					mf.transferTo(new File(PATH+filename+ext));
				} catch(Exception e) {
					e.printStackTrace();
					throw new RuntimeException();
				}
			}
		}
		
		if(noticefile != null) {
			for(Noticefile nf : noticefile) {
				noticefileMapper.insertNoticefile(nf);
			}
		}
	}

	public void removeNotice(int noticeId) {
		//1. 게시글을 참조하는 파일들을 삭제
		List<String> noticefileNameList = noticefileMapper.selectNoticeFileNameList(noticeId);
			for(String s: noticefileNameList) {
				File file = new File(PATH+s);
				if(file.exists()) {
					file.delete();
				}
			}
		//2. 게시글을 참조하는 파일 테이블 데이터 삭제
		noticefileMapper.deleteNoticefile(noticeId);
		//3. 게시글 삭제
		noticeMapper.deleteNotice(noticeId);
	}
	
	public void modifyNotice(NoticeForm noticeForm) {
		Notice notice = new Notice();
		notice.setNoticeId(noticeForm.getNoticeId());
		notice.setNoticeTitle(noticeForm.getNoticeTitle());
		notice.setNoticeContent(noticeForm.getNoticeContent());

		noticeMapper.modifyNotice(notice);
		
		List<Noticefile> noticefile = null;
		
		if(noticeForm.getNoticefileList() != null) {
			noticefile = new ArrayList<Noticefile>();
			for(MultipartFile mf : noticeForm.getNoticefileList()) {
				Noticefile nf = new Noticefile();
				nf.setNoticeId(notice.getNoticeId());
				int p = mf.getOriginalFilename().lastIndexOf(".");
				String ext = mf.getOriginalFilename().substring(p).toLowerCase();
				String filename = UUID.randomUUID().toString().replace("-", "");
				nf.setNoticefileName(filename+ext);
				nf.setNoticefileSize(mf.getSize());
				nf.setNoticefileType(mf.getContentType());
				noticefile.add(nf);
				try {
					mf.transferTo(new File(PATH+filename+ext));
				} catch(Exception e) {
					e.printStackTrace();
					throw new RuntimeException();
				}
			}
		}
		
		if(noticefile != null) {
			for(Noticefile nf : noticefile) {
				noticefileMapper.insertNoticefile(nf);
			}
		}
	}

		public void removeFile(Noticefile noticefile) {
			int noticefileId= noticefile.getNoticefileId();
			String noticefileName = noticefile.getNoticefileName();

			File file = new File(PATH + noticefileName);

			if(file.exists()) {
				file.delete();
			}
			
			noticefileMapper.deleteNoticefileOne(noticefileId);
		}
	public Notice getNoticeOne(int noticeId) {
		Notice notice = noticeMapper.selectNoticeOne(noticeId);
		return notice;
	}
	public int getCountNotice() {
		return noticeMapper.selectNoticeCount();
	}
}
