package com.forus.dto;

public class Pet {
	private Integer pet_id;
	private Integer user_id;
	private String pet_name;
	private String pet_species;
	private String pet_breed;
	private String pet_gender;
	private Integer pet_age;
	private boolean pet_neutering;
	private String pet_picture;
	private String pet_memo;
	private String pet_num;

	public Pet() {
		super();
	}

	public Pet(String pet_name, String pet_species, String pet_breed, String pet_gender,
			Integer pet_age, boolean pet_neutering, String pet_picture, String pet_memo, String pet_num) {
		super();
		this.pet_name = pet_name;
		this.pet_species = pet_species;
		this.pet_breed = pet_breed;
		this.pet_gender = pet_gender;
		this.pet_age = pet_age;
		this.pet_neutering = pet_neutering;
		this.pet_picture = pet_picture;
		this.pet_memo = pet_memo;
		this.pet_num = pet_num;
	}

	public Integer getPet_id() {
		return pet_id;
	}

	public void setPet_id(Integer pet_id) {
		this.pet_id = pet_id;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getPet_name() {
		return pet_name;
	}

	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}

	public String getPet_species() {
		return pet_species;
	}

	public void setPet_species(String pet_species) {
		this.pet_species = pet_species;
	}

	public String getPet_breed() {
		return pet_breed;
	}

	public void setPet_breed(String pet_breed) {
		this.pet_breed = pet_breed;
	}

	public String getPet_gender() {
		return pet_gender;
	}

	public void setPet_gender(String pet_gender) {
		this.pet_gender = pet_gender;
	}

	public Integer getPet_age() {
		return pet_age;
	}

	public void setPet_age(Integer pet_age) {
		this.pet_age = pet_age;
	}

	public boolean isPet_neutering() {
		return pet_neutering;
	}

	public void setPet_neutering(boolean pet_neutering) {
		this.pet_neutering = pet_neutering;
	}

	public String getPet_picture() {
		return pet_picture;
	}

	public void setPet_picture(String pet_picture) {
		this.pet_picture = pet_picture;
	}

	public String getPet_memo() {
		return pet_memo;
	}

	public void setPet_memo(String pet_memo) {
		this.pet_memo = pet_memo;
	}

	public String getPet_num() {
		return pet_num;
	}

	public void setPet_num(String pet_num) {
		this.pet_num = pet_num;
	}

	@Override
	public String toString() {
		return "Pet [pet_id=" + pet_id + ", user_id=" + user_id + ", pet_name=" + pet_name + ", pet_species="
				+ pet_species + ", pet_breed=" + pet_breed + ", pet_gender=" + pet_gender + ", pet_age=" + pet_age
				+ ", pet_neutering=" + pet_neutering + ", pet_picture=" + pet_picture + ", pet_memo=" + pet_memo
				+ ", pet_num=" + pet_num + "]";
	}
}
