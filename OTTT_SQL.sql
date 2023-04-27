drop table if exists tb_content;
create table tb_content
(
	content_no		bigint			primary key,
	content_nm		varchar(100)	not null,
	content_info	varchar(10000)	not null,
	content_runtime	int(500)		not null,
	previewUrl		text			not null,
	thumbnail		text			not null,
	age				int				not null
);

--tb_content fk
alter table tb_content add constraint fk_tb_content_ott_no
   foreign key (ott_no)
   references tb_ott (ott_no) on delete cascade;


drop table if exists tb_content_category;
create table tb_content_category
(
	content_category_no	bigint	primary key
);

--tb_content_category fk
alter table tb_content_category add constraint fk_tb_content_category_category_no
   foreign key (category_no)
   references tb_category (category_no) on delete cascade;

alter table tb_content_category add constraint fk_tb_content_category_content_no
   foreign key (content_no)
   references tb_content (content_no) on delete cascade;
   

drop table if exists tb_end_service;
create table tb_end_service
(
	end_service_no	bigint	primary key,
	end_date		date	not null
);

--tb_end_service fk
alter table tb_end_service add constraint fk_end_service_ott_no
   foreign key (ott_no)
   references tb_ott (ott_no) on delete cascade;

alter table tb_end_service add constraint fk_tb_end_service_content_no
   foreign key (content_no)
   references tb_content (content_no) on delete cascade;
   

drop table if exists tb_ott;
create table tb_ott
(
	ott_no	bigint		primary key,
	ott_nm	varchar(50)	not null
);

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


alter table tb_role_to_permission add constraint fk_role_role_to_permission
	foreign key(role_no) references tb_role(role_no);
alter table tb_role_to_permission add constraint fk_permission_role_to_permission
	foreign key(permission_no) references tb_permission(permission_no);





create table tb_ad
(
	ad_no					char(50) not null primary key
);

drop table if exists tb_review;
create table tb_review
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
	,content_no			BIGINT			not null
	
	--작성자(프로필번호) FK
	,my_profile_no		BIGINT			not null
);

alter table tb_review add constraint fk_content_review foreign key(content_no) 
references tb_content(content_no);

alter table tb_review add constraint fk_profile_review foreign key(my_profile_no) 
references tb_profile(my_profile_no);

drop table if exists tb_review_like;
create table tb_review_like
(	
	--리뷰좋아요번호
	review_like_no		bigint			not null primary key
	
	--리뷰번호 FK
	,review_no			bigint			not null	
	
	--프로필번호 FK
	,my_profile_no		bigint			not null
);

alter table tb_review_like add constraint fk_review_review_like foreign key(review_no) 
references tb_review(review_no);

alter table tb_review_like add constraint fk_profile_review_like foreign key(my_profile_no) 
references tb_profile(my_profile_no);

drop table if exists tb_content_Genre;
create table tb_content_Genre
(
	--영상장르번호
	content_genre_no	bigint			not null primary key
	
	--장르번호 FK
	,genre_no			bigint			not null
	
	--영상번호 FK
	,content_no			bigint			not null
);

alter table tb_content_Genre add constraint fk_genre_content_genre foreign key(genre_no) 
references tb_genre(genre_no);

alter table tb_content_genre add constraint fk_content_content_genre foreign key(content_no) 
references tb_content(content_no);

drop table if exists tb_genre;
create table tb_genre
(
	--장르번호
	genre_no			bigint			not null primary key
	
	--장르이름
	,genre_nm			varchar(25)		not null
);

drop table if exists tb_user;
create table tb_user
(	
	--회원번호
	user_no				bigint			not null primary key
	
	--장르번호 FK
	,genre_no			bigint			not null
	
	--OTT번로 FK
	,ott_no				bigint 			not null
	
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

alter table tb_user add constraint fk_genre_user foreign key(genre_no) 
references tb_genre(genre_no);

alter table tb_user add constraint fk_ott_user foreign key(ott_no) 
references tb_ott(ott_no);

drop table if exists tb_article_content;
create table tb_article_content
(
	--내용번호
	article_content_no	bigint			not null primary key
	
	--내용
	,article_content	varchar(65535)  not null
	
	--사진번호 FK
	,picture_no			bigint			null
);

alter table tb_article_content add constraint fk_picture_article_content foreign key(picture_no) 
references tb_picture(picture_no);

drop table if exists tb_profile;
create table tb_profile
(
	my_profile_no bigint not null primary key
	,gr_no 		  bigint not null
	,user_no	  bigint not null
	,following	  bigint null
	,followers 	  bigint null
	,image 		  text null
	,report_cnt   int null
);

--tb_profile FK
alter table tb_profile add constraint fk_grade_profile foreign key(gr_no) 
references tb_grade(gr_no);
alter table tb_profile add constraint fk_user_profile foreign key(user_no)
references tb_user(user_no);

drop table if exists tb_follow;
create table tb_follow
(
	follow_no 		bigint not null primary key
	,followers_no 	bigint not null
	,following_no 	bigint not null
	,status 		char(1) not null
);

--tb_follow FK
alter table tb_follow add constraint fk_profile_follow foreign key(followers_no) 
references tb_profile(profile_no);
alter table tb_follow add constraint fk_profile_follow foreign key(following_no) 
references tb_profile(profile_no);

drop table if exists tb_message;
create table tb_message
(
	message_no 			bigint 		  not null primary key
	,send_profile_no 	bigint 		  not null
	,receive_profile_no bigint 		  not null
	,content 			varchar(2000) not null
	,send_date			timestamptz	  not null
);

--tb_message FK
alter table tb_message add constraint fk_profile_message foreign key(send_profile_no) 
references tb_profile(profile_no);
alter table tb_message add constraint fk_profile_message foreign key(receive_profile_no) 
references tb_profile(profile_no);

drop table if exists tb_message_Box;
create table tb_message_Box
(
	message_box_no		bigint not null primary key
	,my_profile_no		bigint not null
	,message_no			bigint not null
);

--tb_message_box FK
alter table tb_message_box add constraint fk_profile_message_box foreign key(profile_no) 
references tb_profile(profile_no);
alter table tb_message_box add constraint fk_message_message_box foreign key(message_no) 
references tb_message(message_no);


drop table if exists tb_search_Word;
create table tb_search_Word
(
	search_word_no	bigint 		 not null primary key
	,search_content varchar(50)  not null
	,my_profile_no  bigint		 not null
);

--tb_search_word FK
alter table tb_search_word add constraint fk_profile_search_word foreign key(profile_no) 
references tb_profile(profile_no);



-- 정현
drop table if exists tb_producer;
create table tb_producer (
	producer_no		bigint primary key
	, producer_nm	varchar(15) not null
);

drop table if exists tb_content_director;
create table tb_content_director (
	cont_director_no	bigint primary key
	, producer_no		bigint not null
	, content_no		bigint not null
);

alter table tb_content_director add constraint fk_producer_content_director
	foreign key (producer_no) references tb_producer(producer_no);
alter table tb_content_director add constraint fk_content_content_director
	foreign key (content_no) references tb_content(content_no);


drop table if exists tb_content_entertainer;
create table tb_content_entertainer (
	cont_entertainer_no	bigint primary key
	, entertainer_no	bigint not null
	, content_no		bigint not null
);

alter table tb_content_entertainer add constraint fk_entertainer_content_entertainer
	foreign key (entertainer_no) references tb_entertainer(entertainer_no);
alter table tb_content_entertainer add constraint fk_content_content_entertainer
	foreign key (content_no) references tb_content(content_no);

drop table if exists tb_entertainer;
create table tb_entertainer (
	entertainer_no		bigint primary key
	, entertainer_nm	varchar(15) not null
);

drop table if exists tb_category;
create table tb_category (
	category_no		bigint primary key
	, category_nm	varchar(20) not null
);

drop table if exists tb_user_to_role;
create table tb_user_to_role (
	user_to_role 	char(1) primary key
	, my_profile_no	bigint not null
	, role_no		char(1) not null	
);

alter table tb_user_to_role add constraint fk_profile_user_to_role
	foreign key (my_profile_no) references tb_profile(my_profile_no);
alter table tb_user_to_role add constraint fk_role_user_to_role
	foreign key (role_no) references tb_role(role_no);

drop table if exists tb_notification;
create table tb_notification (
	not_no				bigint primary key
	, my_profile_no		bigint not null
	, target_profile_no	bigint not null
	, message_no		bigint not null
	, article_no		bigint not null
	, cmt_no			bigint not null
	, review_like_no	bigint not null
	, article_like_no	bigint not null
	, comment_like_no	bigint not null
	, not_check			int not null
	, not_url			varchar not null
	, not_message		varchar not null	
);

alter table tb_notification add constraint fk_profile_notification
	foreign key (profile_no) references tb_profile(profile_no);
alter table tb_notification add constraint fk_role_notification
	foreign key (target_profile_no) references tb_profile(profile_no);
alter table tb_notification add constraint fk_message_notification
	foreign key (message_no) references tb_message(message_no);
alter table tb_notification add constraint fk_article_notification
	foreign key (article_no) references tb_article(article_no);
alter table tb_notification add constraint fk_comment_notification
	foreign key (cmt_no) references tb_comment(cmt_no);
alter table tb_notification add constraint fk_review_like_notification
	foreign key (review_like_no) references tb_review_like(review_like_no);
alter table tb_notification add constraint fk_article_like_notification
	foreign key (article_like_no) references tb_article_like(article_like_no);
alter table tb_notification add constraint fk_comment_like_notification
	foreign key (comment_like_no) references tb_comment_like(comment_like_no);

drop table if exists tb_comment;
create table tb_comment (
	cmt_no				bigint primary key
	, profile_no		bigint not null	
	, article_no		bigint not null
	, com_content		varchar(3000) not null
	, com_writer		varchar(50) not null
	, cmt_dt			timestamptz not null
	, cmt_mod_dt		timestamptz not null
	, cmt_like_count	int not null
	, report_cnt		int not null
);

alter table tb_comment add constraint fk_profile_comment
	foreign key (profile_no) references tb_profile(profile_no);
alter table tb_comment add constraint fk_article_comment
	foreign key (article_no) references tb_article(article_no);

drop table if exists tb_report;
create table tb_report (
	report_no		bigint primary key
	, profile_no	bigint not null	
	, target_profile_no	bigint not null	
	, article_no	bigint not null	
	, cmt_no		bigint not null	
	, report_cnt	int not null
	, report_type	char(1) not null
	, report_date	date not null
);

alter table tb_report add constraint fk_profile_report
	foreign key (profile_no) references tb_profile(profile_no);
alter table tb_report add constraint fk_profile_report
	foreign key (target_profile_no) references tb_profile(target_profile_no);
alter table tb_report add constraint fk_article_report
	foreign key (article_no) references tb_article(article_no);
alter table tb_report add constraint fk_comment_report
	foreign key (cmt_no) references tb_comment(cmt_no);

drop table if exists tb_comment_like;
create table tb_comment_like (
	comment_like_no	bigint primary key
	, cmt_no		bigint not null
);

alter table tb_comment_like add constraint fk_comment_comment_like
	foreign key (cmt_no) references tb_comment(cmt_no);


-- 수형
-- soohyeo
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

--내가쓴글 프로필번호
alter table tb_my_write
add constraint fk_my_write_profile
foreign key(my_profile_no)
references tb_profile(my_profile_no);

--내가쓴글 게시글번호
alter table tb_my_write
add constraint fk_article_no_article
foreign key(article_no) 
references tb_article(article_no);




--게시글
drop table if exists tb_article;
create table tb_article 
(
	article_no			bigint			primary key,
	article_title		varchar(255)	not null,
	article_create_dt	timestamptz		not null,
	article_create_user	varchar(50)		not null,
	article_mod_dt		timestamptz,
	article_like_count	int,	
	report_cnt			int
);

--게시글 내용번호
alter table tb_article
add constraint fk_article_content_no_article_content
foreign key(article_content_no)
references tb_article_content(article_content_no);

--게시글 프로필번호
alter table tb_article
add constraint fk_my_profile_no_profile
foreign key(my_profile_no)
references tb_profile(my_profile_no);

--게시글 게시판종류
alter table tb_article
add constraint fk_article_index_no_article_index
foreign key(article_index_no)
references tb_article_index(article_index_no);


--게시글 좋아요
drop table if exists tb_article_like;
create table tb_article_like 
(
	article_like_no		bigint	primary key
);

--게시글좋아요 게시글번호
alter table tb_article_like 
add constraint fk_article_no_article
foreign key(article_no)
references tb_article(article_no);

--게시판 종류
drop table if exists tb_article_index;
create table tb_article_index
(
	article_index_no	char(1)	primary key
);


