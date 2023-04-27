-- 주화
drop table if exists tb_whatched;
create table tb_whatched(
	whatched_no		bigint not null	primary key
	, my_profile_no 	bigint	not null
	, content_no	bigint	not null
);

--tb_whatched FK
alter table tb_whatched add constraint fk_profile_whatched foreign key(my_profile_no) 
references tb_profile(my_profile_no);
alter table tb_whatched add constraint fk_content_whatched foreign key(content_no) 
references tb_content(content_no);

drop table if exists tb_wishlist;
create table tb_wishlist(
	wishlist_no	int	not null	primary key
	, my_profile_no	bigint	not null
	, content_no	bigint	not null
);

--tb_wishlist FK
alter table tb_wishlist add constraint fk_profile_wishlist foreign key(my_profile_no) 
references tb_profile(my_profile_no);
alter table tb_wishlist add constraint fk_content_wishlist foreign key(content_no) 
references tb_content(content_no);

drop table if exists tb_my_review;
create table tb_my_review(
	my_review_no	bigint	not null	primary key
	, my_pofile_no	bigint	not null
	, review_no		bigint	not null
);

--tb_my_review FK
alter table tb_my_review add constraint fk_profile_my_review foreign key(my_profile_no) 
references tb_profile(my_profile_no);
alter table tb_my_review add constraint fk_Review_my_review foreign key(review_no) 
references tb_Review(review_no);

drop table if exists tb_my_diary;
create table tb_my_diary(
	mydiary_no	bigint	not null primary key
	, my_profile_no	bigint	not null
	, content_no	bigint	not null
	, public_yn_cd	int	not null
	, mydiary_title	varchar(255)	not null
	, mydiary_content varchar(65535)	not null
	, mydiary_create_dt	timestamptz	not null
	, mydiary_create_user varchar(50)	not null
	, mydiary_mod_dt	timestamptz	null
	, mydiary_mod_user	varchar(50)	null
);

--tb_my_diary FK
alter table tb_my_diary add constraint fk_profile_my_diary foreign key(my_profile_no) 
references tb_profile(my_profile_no);
alter table tb_my_diary add constraint fk_content_my_diary foreign key(content_no) 
references tb_content(content_no);
alter table tb_my_diary add constraint fk_public_yn_my_diary foreign key(public_yn_cd) 
references tb_public_yn(public_yn_cd);

drop table if exists tb_public_yn;
create table tb_public_yn(
	public_yn_cd	int	not null primary key
);

drop table if exists tb_mypage_background;
create table tb_mypage_background(
	mypage_background_no	bigint	not null primary key
);

drop table if exists tb_skin_list;
create table tb_skin_list(
	skin_list_no	bigint	not null primary key
	, my_profile_no	bigint not null
	, mypage_background_no	bigint	not null
	, profile_border_no	bigint	not null
);

--tb_skin_list FK
alter table tb_skin_list add constraint fk_profile_skin_list foreign key(my_profile_no) 
references tb_profile(my_profile_no);
alter table tb_skin_list  add constraint fk_mypage_background_skin_list foreign key(mypage_background_no) 
references tb_mypage_background(mypage_background_no);
alter table tb_skin_list  add constraint fk_profile_border_skin_list foreign key(profile_border_no) 
references tb_profile_border(profile_border_no);

drop table if exists tb_profile_border;
create table tb_profile_border(
	profile_border_no	bigint not null primary key
);

drop table if exists tb_grade;
create table tb_grade(
	gr_no 	bigint	not null primary key
	, gr_nm 	int	null
);

































