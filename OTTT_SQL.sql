drop table if exists tb_whatched;
create table tb_whatched(
	whatched_no		bigint not null	primary key
	, my_profile_no 	bigint	not null
	, content_no	bigint	not null
);

drop table if exists tb_wishlist;
create table tb_wishlist(
	wishlist_no	int	not null	primary key
	, my_profile_no	bigint	not null
	, content_no	bigint	not null
);

drop table if exists tb_my_review;
create table tb_my_review(
	my_review_no	bigint	not null	primary key
	, my_pofile_no	bigint	not null
	, review_no		bigint	not null
);

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

drop table if exists tb_profile_border;
create table tb_profile_border(
	profile_border_no	bigint not null primary key
);

drop table if exists tb_grade;
create table tb_grade(
	gr_no 	bigint	not null primary key
	, gr_nm 	int	null
);











