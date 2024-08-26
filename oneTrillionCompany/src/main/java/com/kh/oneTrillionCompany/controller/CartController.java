package com.kh.oneTrillionCompany.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dao.CartDao;
import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.service.AttachService;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	private CartDao cartDao;
	@Autowired
	private ItemDao itemDao;
	
	@Autowired
	private AttachService attachService;
	
	
	//장바구니 목록
	@GetMapping("/list")
	public String list(Model model) {
		//장바구니 목록 
		model.addAttribute("cartList", cartDao.selectList());
		model.addAttribute("itemList", itemDao.selectList());
		
		//장바구니 주문 총 합계, 장바구니 테이블이 비어 있으면 null 들어가므로 처리
		Integer cartTotalPrice = cartDao.sumCartTotalPrice();
		model.addAttribute("cartTotalPrice", (cartTotalPrice != null ? cartTotalPrice : 0));
		
//		//장바구니 재고 수량 넘겨주기 (x)
//		int cartNo = cartDao.selectList();
//		Integer itemCnt = cartDao.findItemCnt(cartNo);
//		model.addAttribute("itemCnt", (itemCnt != null ? itemCnt : 0));
		
		return "/WEB-INF/views/cart/list.jsp"; 
	}


	//장바구니 삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam int cartNo) {
		try {//파일을 지우기
			int itemAttachmentNo = cartDao.findImage(cartNo);
			attachService.delete(itemAttachmentNo);
		}
		catch(Exception e) {}//문제가 생겨도 지우기
		finally {
			cartDao.delete(cartNo);
		}
		return "redirect:list";
	}
	
//	//1. 삭제 와 증가 
//	@RequestMapping("update")
//	//2. 만약에 cartNo이 날라온다면 delete 해버린다
//	//3. 반대로 버튼을 눌러 수량이 증가된다면 디비에 업데이트 시키자
//	public String udpateCart(@RequestParam(required = false) int cartNo) {
//		try {//파일을 지우기
//			int itemAttachmentNo = cartDao.findImage(cartNo);
//			attachService.delete(itemAttachmentNo);
//		}
//		catch(Exception e) {}//문제가 생겨도 지우기
//		finally {
//			cartDao.delete(cartNo);
//		}
//	}
	
	//장바구니 여러개 삭제
	@PostMapping("/deleteList")
	public String deleteList(
						@RequestParam(value = "cartNo") List<Integer> list) {//int니깐 여러개
		for(int cartNo : list) {
			try {//파일 지우기
					int itemAttachmentNo = cartDao.findImage(cartNo);
					attachService.delete(itemAttachmentNo);
			}
			catch(Exception e) {} 
			finally {
				cartDao.delete(cartNo);
			}
		}
		return "redirect:list";
	}
	
	//장바구니 전체 삭제
	@PostMapping("/deleteAll")
	public String deleteAll() {
		try {
			cartDao.deleteAll();
		} catch (Exception e) {}
		return "redirect:list";
	}
	//장바구니 목록+검색
//	@RequestMapping("/list")
//	public String list(Model model,
//				@RequestParam(required = false) String column,
//				@RequestParam(required = false) String keyword) {
//		
//		boolean isSearch = column != null && keyword != null;
//		model.addAttribute("isSearch", isSearch);
//		
//		model.addAttribute("column", column);
//		model.addAttribute("keyword", keyword);
//		
//		if(isSearch) {
//			model.addAttribute("cartList", cartDao.selectList(column, keyword));
//		}
//		else {
//			model.addAttribute("list", cartDao.selectList());
//		}
//		return "/WEB-INF/views/emp/list.jsp"; 
//	}
	
	}  
