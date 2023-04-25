drop table if exists tb_content;
create table tb_content
(
	content_no		bigint			not null	primary key,
	content_nm		varchar(100)	not null,
	content_info	varchar(10000)	not null,
	content_runtime	int(500)		not null,
	previewUrl		text			not null,
	thumbnail		text			not null,
	age				int				not null
);

drop table if exists tb_content_category;
create table tb_content_category
(
	content_category_no	bigint	not null	primary key
);

drop table if exists tb_end_service;
create table tb_end_service
(
	end_service_no	bigint	not null	primary key,
	end_date		date	not null
);

drop table if exists tb_ott;
create table tb_ott
(
	ott_no	bigint		not null	primary key,
	ott_nm	varchar(50)	not null
);

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

drop table if exists tb_role, tb_role_to_permission, tb_permission, tb_ad;


create table tb_role
(
	role_no 				smallint not null primary key
	,field  					char(10) not null
);

create table tb_role_to_permission
(
	role_to_permission_no 	smallint not null primary key
	,permission_no			smallint not null 
	,role_no 				smallint not null
);

create table tb_permission
(
	permission_no 			smallint not null primary key
	,permission_read 		smallint not null
	,permission_write		smallint not null
	,permission_edit		smallint not null
	,permission_del			smallint not null
);



create table tb_ad
(
	ad_no					char(50) not null primary key
);

drop table if exists tb_Review;
create table tb_Review
(
	--리뷰번호
	review_no			bigint 			not null primary key
	
	--별점
	,rating			 	int				not null
	
	--내용
	,review_content		varchar (65535) not null
	
	--등록날짜
	,review_create_dt	timestamptz		not null
	
	--영상번호 FK
	
	--작성자(프로필번호) FK
);

drop table if exists tb_Review_like;
create table tb_Review_like
(	
	--리뷰좋아요번호
	review_like_no		bigint			not null primary key
	
	--리뷰번호 FK
	
	--프로필번호 FK
);

drop table if exists tb_Comtent_Genre;
create table tb_Comtent_Genre
(
	--영상장르번호
	comtent_genre_no	bigint			not null primary key
	
	--장르번호 FK
	
	--영상번호 FK
);

drop table if exists tb_Genre;
create table tb_Genre
(
	--장르번호
	genre_no			bigint			not null primary key
	
	--장르이름
	,genre_nm			varchar(25)		not null
);

drop table if exists tb_User;
create table tb_User
(	
	--회원번호
	user_no				bigint			not null primary key
	
	--장르번호 FK
	
	--OTT번로 FK
	
	--아이디
	,user_id			varchar(20)		not null
	
	--비밀번호
	,user_pwd			varchar(30)		not null
	
	--이름
	,user_nm			varchar(15)		not null
	
	--닉네임 추가 회원가입에 닉네임은 있는데 erd에는 없길래 추가 해놈
	,user_nn			varchar(20)		not null
	
	--성별
	,user_gen			int				not null
	
	--이메일
	,user_email			varchar(150)	not null
);

drop table if exists tb_Article_content;
create table tb_Article_content
(
	--내용번호
	article_content_no	bigint			not null primary key
	
	--내용
	,article_content	varchar(65535)  not null
	
	--사진번호 FK
	
);


drop table if exists tb_profile;
create table tb_profile
(
	profile_no bigint  primary key
	,gr_no 		  bigint not null
	,user_no	  bigint not null
	,following	  bigint null
	,followers 	  bigint null
	,image 		  text null
	,report_cnt   int null
);

drop table if exists tb_follow;
create table tb_follow
(
	follow_no 		bigint  primary key
	,followers_no 	bigint not null
	,following_no 	bigint not null
	,status 		char(1) not null
);

drop table if exists tb_message;
create table tb_message
(
	message_no 			bigint 		   primary key
	,send_profile_no 	bigint 		  not null
	,receive_profile_no bigint 		  not null
	,content 			varchar(2000) not null
	,send_date			timestamptz	  not null
);

drop table if exists tb_message_Box;
create table tb_message_Box
(
	message_box_no		bigint  primary key
	,my_profile_no		bigint not null
	,message_no			bigint not null
);

drop table if exists tb_search_Word;
create table tb_search_Word
(
	search_word_no	bigint 		  primary key
	,search_content varchar(50)  not null
	,my_profile_no  bigint		 not null
);

-- 정현
drop table if exists tb_producer;
create table tb_producer (
	producer_no	bigint primary key,
	producer_nm	varchar(15) not null
);

drop table if exists tb_content_director;
create table tb_content_director (
	cont_director_no	bigint primary key
);

drop table if exists tb_content_entertainer;
create table tb_content_entertainer (
	cont_entertainer_no	bigint primary key
);

drop table if exists tb_entertainer;
create table tb_entertainer (
	entertainer_no	bigint primary key,
	entertainer_nm	varchar(15) not null
);

drop table if exists tb_category;
create table tb_category (
	category_no	bigint primary key,
	category_nm	varchar(20) not null
);

drop table if exists tb_user_to_role;
create table tb_user_to_role (
	user_to_role char(1) primary key
);

drop table if exists tb_notification;
create table tb_notification (
	not_no		bigint primary key,
	not_check	int not null,
	not_url		varchar not null,
	not_message	varchar not null	
);

drop table if exists tb_comment;
create table tb_comment (
	cmt_no			bigint primary key,
	com_content		varchar(3000) not null,
	com_writer		varchar(50) not null,
	cmt_dt			timestamptz not null,
	cmt_mod_dt		timestamptz not null,
	cmt_like_count	int not null,
	report_cnt		int not null
);

drop table if exists tb_report;
create table tb_report (
	report_no		bigint primary key,
	report_cnt		int not null,
	report_type		char(1) not null,
	report_date		date not null
);

drop table if exists tb_comment_like;
create table tb_comment_like (
	comment_like_no		bigint primary key
);

-- 수형

--사진
drop table if exists tb_picture;
create table tb_picture 
(
	picture_no	bigint	primary key,
	picture		text	not null
);

--내가쓴글
drop table if exists tb_my_write;
create table tb_my_write 
(
	my_write_no		bigint primary key
);

--게시글
drop table if exists tb_article;
create table tb_article 
(
	article_no			bigint			primary key,
	article_title		varchar(255)	not null,
	article_create_dt	timestamptz		not null,
	article_create_user	varchar(50)		not null,
	article_mod_dt		timestamptz
	article_like_count	int	
	report_cnt			int	
);

--게시글 좋아요
drop table if exists tb_article_like;
create table tb_article_like 
(
	article_like_no		bigint	primary key
);

--게시판 종류
drop table if exists tb_article_index;
create table tb_article_index
(
	article_index_no	char(1)	primary key
);


----가현(FK)
--tb_profile FK
alter table tb_profile add constraint fk_grade_profile foreign key(gr_no) 
references tb_grade(gr_no);
alter table tb_profile add constraint fk_user_profile foreign key(user_no)
references tb_user(user_no);

--tb_follow FK
alter table tb_follow add constraint fk_profile_follow foreign key(followers_no) 
references tb_profile(profile_no);
alter table tb_follow add constraint fk_profile_follow foreign key(following_no) 
references tb_profile(profile_no);

--tb_message FK
alter table tb_message add constraint fk_profile_message foreign key(send_profile_no) 
references tb_profile(profile_no);
alter table tb_message add constraint fk_profile_message foreign key(receive_profile_no) 
references tb_profile(profile_no);

--tb_message_box FK
alter table tb_message_box add constraint fk_profile_message_box foreign key(profile_no) 
references tb_profile(profile_no);
alter table tb_message_box add constraint fk_message_message_box foreign key(message_no) 
references tb_message(message_no);

--tb_search_word FK
alter table tb_search_word add constraint fk_profile_search_word foreign key(profile_no) 
references tb_profile(profile_no);






