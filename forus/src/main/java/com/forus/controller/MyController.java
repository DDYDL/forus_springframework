package com.forus.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.forus.dto.Pet;
import com.forus.dto.Recruit_apply;
import com.forus.dto.Recruit_post;
import com.forus.dto.User;
import com.forus.service.my.PetService;
import com.forus.service.my.UserService;
import com.forus.service.recruit.RecruitApplyService;
import com.forus.service.recruit.RecruitService;
import com.forus.service.reserv.ReservationService;

@Controller
public class MyController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private RecruitService recruitService;
	@Autowired
	private RecruitApplyService recruitApplyService;
	@Autowired
	private PetService petService;
	@Autowired
	private HttpSession session;
	
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	@RequestMapping(value="login",method=RequestMethod.POST)
	public String login(@RequestParam("email") String email, @RequestParam("password") String password, Model model) {
		try {
			User user = userService.login(email, password);
			session.setAttribute("user", user);
			return "recruit/recruitlist";
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("err", e.getMessage());
			return "err";
		}
	}
	
	@RequestMapping("logout")
	public String logout() {
		session.removeAttribute("user");
		return "recruit/recruitlist";
	}
	
	@RequestMapping("/myAfterReserv")
	public ModelAndView myAfterReserv() {
		ModelAndView mav = new ModelAndView();
		try {
			User user = (User)session.getAttribute("user");
			Integer id = user.getId();
			
			List<Map<String, Object>> afterReservList = reservationService.myAfterReservList(id);
			System.out.println(afterReservList);
			mav.addObject("afterReservList", afterReservList);
			mav.setViewName("my/myafterreserv");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}
	
	@RequestMapping("myPostList")
	public ModelAndView myPostList() {
		ModelAndView mav = new ModelAndView();
		try {
			User user = (User)session.getAttribute("user");
			Integer id = user.getId();
			List<Map<String,Object>> myPostList = recruitService.selectPostListByUserId(id);
			
			mav.addObject("myPostList", myPostList);
			mav.setViewName("/my/mypostlist");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping("recruitApplyList")
	public ModelAndView recruitApplyList(@RequestParam(name="post_id",required=false) Integer post_id) {
		ModelAndView mav = new ModelAndView();
		try {
			// 해당하는 Recruit_post에 지원한 Recruit_apply 가져오기
			List<Recruit_apply> recruit_applyList = recruitApplyService.selectRecruit_applyList(post_id);
			// 해당하는 Recruit_post에 지원한 User 가져오기
			List<User> userList = new ArrayList<>();
			for(Recruit_apply apply : recruit_applyList) {
				User user = recruitService.selectUserId(apply.getUser_id());
				userList.add(user);
			}
			
			mav.addObject("recruit_applyList", recruit_applyList);
			mav.addObject("userList", userList);
			mav.setViewName("recruit/recruitapplylist");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}
	
	@RequestMapping("recruitApplyDetailpage")
	public ModelAndView recruitApplyDetailpage(@RequestParam("apply_id") Integer apply_id) {
		ModelAndView mav = new ModelAndView();
		try {
			Recruit_apply recruit_apply = recruitApplyService.selectRecruit_apply(apply_id);
			User apply_user = recruitService.selectUserId(recruit_apply.getUser_id());
			List<Pet> petList = petService.selectPetList(recruit_apply.getUser_id());
			Recruit_post recruit_post = recruitService.recruit_postDatail(recruit_apply.getPost_id());
			
			mav.addObject("recruit_apply", recruit_apply);
			mav.addObject("apply_user", apply_user);
			mav.addObject("petList", petList);
			mav.addObject("recruit_post", recruit_post);
			mav.addObject("post_id", recruit_apply.getPost_id());
			mav.setViewName("recruit/recruitapplydetailpage");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}
	
	@RequestMapping("recruitApplyHire")
	public ModelAndView recruitApplyHire(@RequestParam("apply_id") Integer apply_id) {
		ModelAndView mav = new ModelAndView();
		try  {
			Recruit_apply apply = recruitApplyService.selectRecruit_apply(apply_id);
			Integer user_id = apply.getUser_id();
			Integer post_id = apply.getPost_id();
			
			// 해당 post의 지원자 리스트 가져오기
			List<Recruit_apply> applyList = recruitApplyService.selectRecruit_applyList(post_id);
			
			// 지원자들의 status 모두 바꾸기
			for(int i=0; i<applyList.size(); i++) {
				if(applyList.get(i).getUser_id() == user_id) {
					applyList.get(i).setApply_status("채용");
				} else {
					applyList.get(i).setApply_status("지원마감");
				}
				recruitApplyService.updateRecruit_apply_status(applyList.get(i));
			}
			
			// recruit_post status 바꾸기
			Recruit_post post = new Recruit_post();
			post.setPost_id(post_id);
			post.setPost_status("마감");
			recruitApplyService.updateRecruit_post_status(post);
			
			mav.addObject("post_id", post_id);
			mav.setViewName("redirect:/recruitApplyList");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}
}
