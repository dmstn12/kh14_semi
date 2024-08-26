package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.CartDto;
import com.kh.oneTrillionCompany.dto.ItemDto;
import com.kh.oneTrillionCompany.mapper.CartMapper;

@Repository
public class CartDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private CartMapper cartMapper;
	
	//장바구니 등록
	public void insert(CartDto cartDto) {
		String sql = "insert into cart(cart_no, cart_item_no, cart_buyer, cart_cnt,"
					+ " item_attacth_no, cart_total_price)"
					+ " values(cart_no_seq.nextval, cart_item_no_seq.nextval, ?, ?, ?, ?)";
		Object[] data = {
				cartDto.getCartNo(), cartDto.getCartItemNo(), cartDto.getCartBuyer(), 
				cartDto.getCartCnt(), cartDto.getItemAttachNo(), 
				cartDto.getCartTotalPrice()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//장바구니 삭제
	public boolean delete(int itemNo) {
		String sql = "delete cart where cart_no = ?";
		Object[] data = {itemNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//장바구니 전체삭제
	public void deleteAll() {
		String sql = "delete from cart";
		jdbcTemplate.update(sql);
	}
	
	//장바구니 수정(상품수량, 주문총가격)
	public boolean updateCart(CartDto cartDto) {
		String sql = "update cart set "
					+ "cart_cnt=?, cart_total_price=? "
					+ "where cart_no=?";
		Object[] data = { 
				cartDto.getCartCnt(), cartDto.getCartTotalPrice(),
				cartDto.getCartNo()
		};
		return jdbcTemplate.update(sql,data) > 0;	
	}
	
	//장바구니 목록
	public List<CartDto> selectList() {
		String sql = "select * from cart order by cart_no asc";
		return jdbcTemplate.query(sql, cartMapper);		
	}
	
	//장바구니 상세 정보
	public CartDto selectOne(String cartNo) {
		String sql = "select * from cart where cart_no = ?";
		Object[] data = {cartNo};
		List<CartDto> list = jdbcTemplate.query(sql, cartMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//장바구니 검색
	public List<CartDto> selectList(String column, String keyword) {
		String sql = "select * from cart "
				+ "where instr(" + column +", ?) > 0 "
				+ "order by cart_no asc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, cartMapper, data);			
	}

	//이미지 번호 찾기
	public Integer findImage(int cartNo) {
		String sql = "select attach from cart where item_no=?";
		Object[] data = {cartNo};
		return jdbcTemplate.queryForObject(sql, Integer.class, data);
	}
	
//	//재고 수량 찾기
//	public Integer findItemCnt(int cartNo) {
//		try {
//			String sql = "select item_cnt from item where item_no = ?";
//			Object[] data = {cartNo};
//		return jdbcTemplate.queryForObject(sql, Integer.class, data);
//		} catch (EmptyResultDataAccessException e) {
//			return null;
//		}
//	}
	
	
	//장바구니 전체 금액 합계
	public Integer sumCartTotalPrice() {
		String sql = "select sum(cart_total_price) from cart";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	
}