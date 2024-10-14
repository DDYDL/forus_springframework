package com.forus.dto;

public class UserPetInfo {
	private String userName;
	private String userPhone;
	private String userEmail;
	private String petName;
	private String petSpecies;
	private String petBreed;
	private String petGender;
	private Integer petAge;
	private String petPicture;

	public UserPetInfo() {
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getPetName() {
		return petName;
	}

	public void setPetName(String petName) {
		this.petName = petName;
	}

	public String getPetSpecies() {
		return petSpecies;
	}

	public void setPetSpecies(String petSpecies) {
		this.petSpecies = petSpecies;
	}

	public String getPetBreed() {
		return petBreed;
	}

	public void setPetBreed(String petBreed) {
		this.petBreed = petBreed;
	}

	public String getPetGender() {
		return petGender;
	}

	public void setPetGender(String petGender) {
		this.petGender = petGender;
	}

	public Integer getPetAge() {
		return petAge;
	}

	public void setPetAge(Integer petAge) {
		this.petAge = petAge;
	}

	public String getPetPicture() {
		return petPicture;
	}

	public void setPetPicture(String petPicture) {
		this.petPicture = petPicture;
	}

	@Override
	public String toString() {
		return "UserPetInfo{" +
			"userName='" + userName + '\'' +
			", userPhone='" + userPhone + '\'' +
			", userEmail='" + userEmail + '\'' +
			", petName='" + petName + '\'' +
			", petSpecies='" + petSpecies + '\'' +
			", petBreed='" + petBreed + '\'' +
			", petGender='" + petGender + '\'' +
			", petAge=" + petAge +
			", petPicture='" + petPicture + '\'' +
			'}';
	}
}

