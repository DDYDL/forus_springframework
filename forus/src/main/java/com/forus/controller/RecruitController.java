package com.forus.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.forus.dto.Pet;
import com.forus.dto.Recruit_apply;
import com.forus.dto.Recruit_post;
import com.forus.dto.User;
import com.forus.service.my.UserService;
import com.forus.service.recruit.RecruitApplyService;
import com.forus.service.recruit.RecruitService;
import com.forus.service.recruit.SearchService;

@Controller
public class RecruitController {
	
	@Autowired
	private SearchService searchService;
	@Autowired
	private RecruitService recruitService;
	@Autowired
	private UserService userService;
	@Autowired
	private RecruitApplyService recruitApplyService;
	@Autowired
	private HttpSession session;
	
	@RequestMapping("/recruitList")
	public String recruitList() {
		return "recruit/recruitlist";
	}
	
	// recruitlist.jsp 글목록 리스트 가져오기 ajax
	@RequestMapping(value="/recruitBypage",method=RequestMethod.POST,produces="application/text;charset=UTF-8")
	@ResponseBody
	public String recruitBypage(@RequestParam("param") String param) {
		System.out.println("param" + param);
		List<String> areas = new ArrayList<>(); // 지역
		List<String> species = new ArrayList<>(); // 동물
		Long page = null; // 페이지 수
		
		try {
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject)parser.parse(param); // JSON 문자열 JSON 객체로 변환
			JSONArray areaArr = (JSONArray)jsonObj.get("areas"); // 객체 안의 배열들 가져오기
			JSONArray speciesArr = (JSONArray)jsonObj.get("species");
			
			if(areaArr!=null) {
				for(int i=0; i<areaArr.size(); i++) {
					areas.add((String)areaArr.get(i)); // 배열 String 배열로 변환
				}
				}
				if(speciesArr!=null) {
				for(int i=0; i<speciesArr.size(); i++) {
					species.add((String)speciesArr.get(i));
				}
				}
				page = (Long)jsonObj.get("page"); // 현재 페이지 가져오기
				
				// 현재 조건의 recruit post 리스트 가져오기
				List<Recruit_post> posts = searchService.getRecruit_postList(areas, species, page.intValue());
				System.out.println("posts:"+posts);
				
				List<Integer> count = searchService.getMaxPage(areas, species);
				// 최대 페이지 수 가져오기
				Integer maxPage = count.get(0);
				// 전체 post 수 가져오기
				Integer postCount = count.get(1);
				System.out.println("cnt" + postCount);
				
				// jsp response로 recruit_post 자바 객체를 전달하기 위해 JSON타입 스트링 만들기
				JSONObject resJson = new JSONObject();
				resJson.put("page", page);
				resJson.put("maxPage", maxPage);
				JSONArray jsonPosts = new JSONArray();
				
				for(Recruit_post post : posts) {
					JSONObject jsonPost = new JSONObject();
					jsonPost.put("post_id", post.getPost_id());
					jsonPost.put("user_id", post.getUser_id());
					jsonPost.put("pet_id", post.getPet_id());
					jsonPost.put("post_time", post.getPost_time());
					jsonPost.put("post_title", post.getPost_title());
					jsonPost.put("post_content", post.getPost_content());
					jsonPost.put("post_address", post.getPost_address());
					jsonPost.put("post_form", post.getPost_form());
					jsonPost.put("post_pay", post.getPost_pay());
					jsonPost.put("post_date", post.getPost_date());
					jsonPost.put("post_start_time", post.getPost_start_time());
					jsonPost.put("post_end_time", post.getPost_end_time());
					jsonPost.put("post_status", post.getPost_status());
					jsonPosts.add(jsonPost);
				}
				resJson.put("recruit_postList", jsonPosts);
				resJson.put("postCount", postCount);
				System.out.println(resJson.toJSONString());
				
				return resJson.toJSONString();
			
		} catch(Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
	
	// 글목록에서 상세페이지로 넘어가기
	@RequestMapping("/recruitDetailpage")
	public ModelAndView recruitDetailpage(@RequestParam("post_id") Integer post_id) {
		ModelAndView mav = new ModelAndView();
		try {
			Recruit_post post = recruitService.recruit_postDatail(post_id); // Recruit_post 객체 생성
			User post_user = recruitService.selectUserId(post.getUser_id());
			User user = (User)session.getAttribute("user");
			
			mav.addObject("post", post);
			mav.addObject("post_user", post_user);
			
			if(user!=null && user.getId() == post_user.getId()) { // 로그인 되어 있고, 작성자와 같으면 수정하기 버튼 띄우기 위해 설정
				mav.addObject("modify", recruitService.checkModify(post_user.getId(), post_id));
			}
			mav.setViewName("recruit/recruitdetailpage");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}
	
	// 상세페이지의 반려동물 리스트 가져오기 ajax
	@RequestMapping(value="/recruitWritingPetList",method=RequestMethod.POST,produces="application/text;charset=UTF-8")
	@ResponseBody
	public String recruitWritingPetList(@RequestParam(name="post_user",required=false) Integer post_user_id) {
		try {
			if(post_user_id == null) {
				post_user_id = ((User)session.getAttribute("user")).getId();
			}
			List<Pet> pets = recruitService.getPetList(post_user_id);
			System.out.println("pets:" + pets);
			
			JSONObject resJson = new JSONObject();
			JSONArray jsonPosts = new JSONArray();
			for(Pet pet : pets) {
				JSONObject jsonPost = new JSONObject();
				jsonPost.put("pet_id", pet.getPet_id());
				jsonPost.put("user_id", pet.getUser_id());
				jsonPost.put("pet_name", pet.getPet_name());
				jsonPost.put("pet_species", pet.getPet_species());
				jsonPost.put("pet_breed", pet.getPet_breed());
				jsonPost.put("pet_gender", pet.getPet_gender());
				jsonPost.put("pet_age", pet.getPet_age());
				jsonPost.put("pet_neutering", pet.isPet_neutering());
				jsonPost.put("pet_picture", pet.getPet_picture());
				jsonPost.put("pet_memo", pet.getPet_memo());
				jsonPost.put("pet_num", pet.getPet_num());
				jsonPosts.add(jsonPost);
			}
			resJson.put("petList", jsonPosts);
			return resJson.toJSONString();
		} catch(Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
	
	@RequestMapping("recruitWriting")
	public String recruitWriting() {
		return "recruit/recruitwriting";
	}
	
	// 작성한 글 저장
	@RequestMapping(value="recruitWriting",method=RequestMethod.POST)
	public String recruitWriting(Recruit_post post, @RequestParam("pet_name") String pet_name) {
		try {
			post.setUser_id(((User)session.getAttribute("user")).getId());
			User user = userService.userDetail(post.getUser_id());
			
			List<Pet> pets = recruitService.getPetList(user.getId());
			for(Pet pet: pets) {
				if(pet.getPet_name().equals(pet_name)) {
					post.setPet_id(pet.getPet_id());
				}
			}
			recruitService.recruit_postWrite(post);
			return "redirect:/recruitList";
		} catch(Exception e) {
			e.printStackTrace();
			return "err";
		}
	}
	
	@RequestMapping("recruitDetailpageModify")
	public ModelAndView recruitDetailpageModify(@RequestParam("post_id") Integer post_id) {
		ModelAndView mav = new ModelAndView();
		try {
			Recruit_post post = recruitService.recruit_postDatail(post_id);
			mav.addObject("recruit_post", post);
			mav.setViewName("recruit/recruitdetailpagemodify");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}
	
	@RequestMapping(value="recruitDetailpageModify",method=RequestMethod.POST)
	public ModelAndView recruitDetailpageModify(Recruit_post post, @RequestParam("pet_name") String pet_name) {
		ModelAndView mav = new ModelAndView();
		try {
			User user = (User)session.getAttribute("user");
			post.setUser_id(user.getId());
			
			List<Pet> pets = recruitService.getPetList(user.getId());
			for(Pet pet: pets) {
				if(pet.getPet_name().equals(pet_name)) {
					post.setPet_id(pet.getPet_id());
				}
			}
			
			Integer post_id = recruitService.recruit_postModify(post);
			
			User post_user = recruitService.selectUserId(post.getUser_id());
			mav.addObject("post", post); // request에 객체 넣기
			mav.addObject("post_user", post_user);
			
			if(user!=null && user.getId() == post_user.getId()) { // 로그인 되어 있고, 작성자와 같으면 수정하기 버튼 띄우기 위해 설정
				mav.addObject("modify", recruitService.checkModify(post_user.getId(), post_id));
			}
			mav.setViewName("recruit/recruitdetailpage");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}
	
	@RequestMapping("recruitApply")
	public ModelAndView recruitApply(Recruit_apply apply, @RequestParam("post_id") Integer post_id) {
		ModelAndView mav = new ModelAndView();
		try {
			User user = (User)session.getAttribute("user");
			apply.setUser_id(user.getId());
			apply.setPost_id(post_id);
			recruitApplyService.insertRecruit_apply(apply);
			
			// recruitDetailpage에서 post_id가 필요하므로 request에 세팅
			mav.addObject("post_id", post_id);
			mav.setViewName("recruitDetailpage");
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("err", e.getMessage());
			mav.setViewName("err");
		}
		return mav;
	}
}
