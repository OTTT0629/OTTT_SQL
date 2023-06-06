-- 전체 쿼리문

drop table if exists tb_content;
create table tb_content
(
	content_no			bigint			generated always as identity primary key
	,content_nm			varchar(100)	not null
	,content_info		varchar(10000)	not null
	,content_runtime	int				not null
	,thumbnail			text
	,main_img			text		
	,age				smallint	
	,country			varchar(50)
	,rating				int				default 0
);

--tb_content fk
alter table tb_content add constraint fk_ott_content
   foreign key (ott_no) references tb_ott (ott_no) on delete set null;


drop table if exists tb_content_category;
create table tb_content_category
(
	content_no		bigint		not null
	,category_no	smallint	not null
	,constraint content_category_pk primary key (content_no, category_no)
);

--tb_content_category fk
alter table tb_content_category add constraint fk_category_content_category
   foreign key (category_no) references tb_category (category_no) on delete set null;

alter table tb_content_category add constraint fk_content_content_category
   foreign key (content_no) references tb_content (content_no) on delete set null;
   

drop table if exists tb_end_service;
create table tb_end_service
(
	end_service_no	bigint		generated always as identity primary key
	,ott_no			smallint	not null
	,content_no		bigint		not null
	,end_date		date		not null
);

--tb_end_service fk
alter table tb_end_service add constraint fk_ott_end_service
   foreign key (ott_no) references tb_ott (ott_no) on delete set null;
  
alter table tb_end_service add constraint fk_content_end_service
   foreign key (content_no) references tb_content (content_no) on delete set null;
   

drop table if exists tb_ott;
create table tb_ott
(
	ott_no		smallint	primary key
	,ott_nm		varchar(50)	not null
	,ott_img	text		default null
);


-- 주화
drop table if exists tb_whatched;
create table tb_whatched(
	whatched_no		bigint	generated always as identity primary key
 	,user_no		bigint	not null
	,content_no		bigint	not null
);

--tb_whatched FK
alter table tb_whatched add constraint fk_user_whatched
	foreign key(user_no) references tb_user(user_no) on delete cascade;
	
alter table tb_whatched add constraint fk_content_whatched
	foreign key(content_no) references tb_content(content_no) on delete set null;


drop table if exists tb_wishlist;
create table tb_wishlist(
	wishlist_no		smallint	generated always as identity primary key
	,user_no		bigint		not null
	,content_no		bigint		not null
);

--tb_wishlist FK
alter table tb_wishlist add constraint fk_user_wishlist
	foreign key(user_no) references tb_user(user_no) on delete cascade;

alter table tb_wishlist add constraint fk_content_wishlist
	foreign key(content_no) references tb_content(content_no) on delete set null;


drop table if exists tb_my_diary;
create table tb_my_diary(
	user_no					bigint			not null
	,content_no				bigint			not null
	,public_yn_cd			char(1)			default '0'
	,mydiary_content 		varchar(65535)	not null
	,mydiary_create_dt		timestamptz		default now()
	,mydiary_mod_dt			timestamptz		default null
	,constraint my_diary primary key (user_no, content_no)
);

--tb_my_diary FK
alter table tb_my_diary add constraint fk_user_my_diary
	foreign key(user_no) references tb_user(user_no)on delete cascade;

alter table tb_my_diary add constraint fk_content_my_diary
	foreign key(content_no) references tb_content(content_no)on delete set null;

alter table tb_my_diary add constraint fk_public_yn_my_diary
	foreign key(public_yn_cd) references tb_public_yn(public_yn_cd)on delete set null;


drop table if exists tb_public_yn;
create table tb_public_yn(
	public_yn_cd	char(1)		primary key
	,public_yn		varchar(5)	not null
);


drop table if exists tb_mypage_background;
create table tb_mypage_background(
	mypage_background_no	bigint	generated always as identity primary key
	,mypage_background_img	text	not null
);


drop table if exists tb_skin_list;
create table tb_skin_list(
	skin_list_no			bigint	generated always as identity primary key
	,user_no				bigint	not null
	,mypage_background_no	bigint
	,profile_border_no		bigint
);

--tb_skin_list FK
alter table tb_skin_list add constraint fk_user_skin_list
	foreign key(user_no) references tb_user(user_no) on delete cascade;

alter table tb_skin_list  add constraint fk_mypage_background_skin_list
	foreign key(mypage_background_no) references tb_mypage_background(mypage_background_no) on delete set null;

alter table tb_skin_list  add constraint fk_profile_border_skin_list
	foreign key(profile_border_no) references tb_profile_border(profile_border_no) on delete set null;


drop table if exists tb_profile_border;
create table tb_profile_border(
	profile_border_no		bigint	generated always as identity primary key
	,profile_border_img		text not null
);


drop table if exists tb_grade;
create table tb_grade(
	gr_no 		char(1)		primary key
	,gr_nm 		varchar(10)	not null
);


drop table if exists tb_ad;
create table tb_ad
(
	ad_no		bigint	generated always as identity primary key
	,ad_content	text	not null
);


drop table if exists tb_review;
create table tb_review
(
	--리뷰번호
	review_no			bigint 			generated always as identity primary key
	
	--영상번호 FK
	,content_no			BIGINT			not null
	
	--작성자(프로필번호) FK
	,user_no			BIGINT			not null
	
	--별점
	,rating			 	numeric			default 0
	
	--내용
	,review_content		varchar(65535)	not null
	
	--등록날짜
	,review_create_dt	timestamptz		default now()
	
	--수정날짜
	,review_mod_dt		timestamptz		default null
	
	--댓글 개수
	,comment_cnt		int				DEFAULT 0 NOT NULL
);

alter table tb_review add constraint fk_content_review
	foreign key(content_no) references tb_content(content_no) on delete set null;

alter table tb_review add constraint fk_user_review
	foreign key(user_no) references tb_user(user_no) on delete cascade;


drop table if exists tb_review_like;
create table tb_review_like
(	
	--리뷰좋아요번호
	review_like_no		bigint			generated always as identity primary key
	
	--리뷰번호 FK
	,review_no			bigint			not null	
	
	--프로필번호 FK
	,user_no			bigint			not null
);

alter table tb_review_like add constraint fk_review_review_like
	foreign key(review_no) references tb_review(review_no) on delete cascade;

alter table tb_review_like add constraint fk_user_review_like
	foreign key(user_no) references tb_user(user_no) on delete cascade;


drop table if exists tb_content_genre;
create table tb_content_genre
(
	--영상번호 FK
	content_no		bigint		not null
	
	--장르번호 FK
	,genre_no		smallint	not null
	
	,constraint content_genre_pk primary key (content_no, genre_no)
);

alter table tb_content_Genre add constraint fk_genre_content_genre
	foreign key(genre_no) references tb_genre(genre_no) on delete set null;

alter table tb_content_genre add constraint fk_content_content_genre
	foreign key(content_no) references tb_content(content_no) on delete cascade;


drop table if exists tb_genre;
create table tb_genre
(
	--장르번호
	genre_no		smallint		primary key
	
	--장르이름
	,genre_nm		varchar(25)		not null
);


drop table if exists tb_user;
create table tb_user
(	
	--회원번호
	user_no			bigint			generated always as identity primary key
	
	--등급
	,gr_no 			char(1)			default '0'
	
	--아이디
	,user_id		varchar(20)		not null
	
	--비밀번호
	,user_pwd		varchar(30)		not null
	
	--이름
	,user_nm		varchar(15)		not null
	
	--닉네임
	,user_nicknm	varchar(20)		not null
	
	--성별
	,user_gen		int				not null
	
	--이메일
	,user_email		varchar(150)	not null
	
	--가입일
	,reg_date		timestamptz		default now()
	
	--관리자 여부
	,admin			char(1)			default 'N'
	
	--프로필 이미지
	,image 			text			default null	
	
	--팔로잉
	,following		bigint			default 0
	
	--팔로워
	,followers 		bigint			default 0
	
	--신고개수
	,report_cnt		int				default 0
);


drop table if exists tb_follow;
create table tb_follow
(
	follow_no 		bigint	generated always as identity primary key
	,followers_no 	bigint	not null
	,following_no 	bigint	not null
	,status 		char(1)	default 'N'
);

--tb_follow FK
alter table tb_follow add constraint fk_user_follower
	foreign key(followers_no) references tb_user(user_no) on delete cascade;

alter table tb_follow add constraint fk_user_following
	foreign key(following_no) references tb_user(user_no) on delete cascade;


drop table if exists tb_message;
create table tb_message
(
	message_no 			bigint 		  generated always as identity primary key
	,send_user_no		bigint 		  not null
	,receive_user_no	bigint 		  not null
	,content 			varchar(2000) not null
	,send_date			timestamptz	  default now()
	,read_yn		char(1)		default '0'
);

--tb_message FK
alter table tb_message add constraint fk_user_message_send
	foreign key(send_user_no) references tb_user(user_no) on delete set null;

alter table tb_message add constraint fk_user_message_receive
	foreign key(receive_user_no) references tb_user(user_no) on delete cascade;


drop table if exists tb_message_Box;
create table tb_message_Box
(
	user_no			bigint		not null
	,message_no		bigint		not null
	,constraint message_box primary key (user_no, message_no)
);

--tb_message_box FK
alter table tb_message_box add constraint fk_user_message_box
	foreign key(user_no) references tb_user(user_no) on delete cascade;

alter table tb_message_box add constraint fk_message_message_box
	foreign key(message_no) references tb_message(message_no) on delete cascade;


drop table if exists tb_search_Word;
create table tb_search_Word
(
	search_word_no	bigint 		 generated always as identity primary key
	,user_no	  	bigint		 not null
	,search_content varchar(50)  not null
);

--tb_search_word FK
alter table tb_search_word add constraint fk_user_search_word
	foreign key(user_no) references tb_user(user_no) on delete cascade;


-- 정현
drop table if exists tb_director;
create table tb_director (
	director_no		bigint		generated always as identity primary key
	, director_nm	varchar(15) not null
);


drop table if exists tb_content_director;
create table tb_content_director (
	director_no		bigint	not null
	, content_no	bigint	not null
	, constraint cont_director primary key (director_no, content_no)
);

alter table tb_content_director add constraint fk_director_content_director
	foreign key (director_no) references tb_director(director_no) on delete set null;

alter table tb_content_director add constraint fk_content_content_director
	foreign key (content_no) references tb_content(content_no) on delete set null;


drop table if exists tb_content_entertainer;
create table tb_content_entertainer (
	entertainer_no		bigint	not null
	, content_no		bigint	not null
	, constraint cont_entertainer_no primary key (entertainer_no, content_no)
);

alter table tb_content_entertainer add constraint fk_entertainer_content_entertainer
	foreign key (entertainer_no) references tb_entertainer(entertainer_no) on delete set null;

alter table tb_content_entertainer add constraint fk_content_content_entertainer
	foreign key (content_no) references tb_content(content_no) on delete set null;


drop table if exists tb_entertainer;
create table tb_entertainer (
	entertainer_no		bigint		generated always as identity primary key
	, entertainer_nm	varchar(15) not null
);


drop table if exists tb_category;
create table tb_category (
	category_no		smallint	primary key
	, category_nm	varchar(20) not null
);


drop table if exists tb_notification;
create table tb_notification (
	not_no				bigint	generated always as identity primary key
	, user_no			bigint	not null
	, target_user_no	bigint	not null
	, message_no		bigint	default null
	, article_no		bigint	default null
	, cmt_no			bigint	default null
	, review_like_no	bigint	default null
	, article_like_no	bigint	default null
	, cmt_like_no		bigint	default null
	, not_check			char(1)	default 'N'
	, not_url			text	not null
	, not_message		varchar	not null	
);

alter table tb_notification add constraint fk_user_notification
	foreign key (user_no) references tb_user(user_no) on delete cascade;

alter table tb_notification add constraint fk_target_user_notification
	foreign key (target_user_no) references tb_user(user_no) on delete cascade;

alter table tb_notification add constraint fk_message_notification
	foreign key (message_no) references tb_message(message_no) on delete cascade;

alter table tb_notification add constraint fk_article_notification
	foreign key (article_no) references tb_article(article_no) on delete cascade;

alter table tb_notification add constraint fk_comment_notification
	foreign key (cmt_no) references tb_comment(cmt_no) on delete cascade;

alter table tb_notification add constraint fk_review_like_notification
	foreign key (review_like_no) references tb_review_like(review_like_no) on delete cascade;

alter table tb_notification add constraint fk_article_like_notification
	foreign key (article_like_no) references tb_article_like(article_like_no) on delete cascade;

alter table tb_notification add constraint fk_comment_like_notification
	foreign key (comment_like_no) references tb_comment_like(cmt_like_no) on delete cascade;



drop table if exists tb_comment;
create table tb_comment (
	cmt_no				bigint			generated always as identity primary key
	, user_no			bigint			not null	
	, article_no		bigint
	, review_no			bigint
	, cmt_content		varchar(3000)	not null
	, cmt_writer		varchar(50)		not null
	, cmt_dt			timestamptz		not null
	, cmt_mod_dt		timestamptz		default null
	, cmt_like_count	int				default 0
	, report_cnt		int				default 0
);


alter table tb_comment add constraint fk_user_comment
	foreign key (user_no) references tb_user(user_no) on delete cascade;

alter table tb_comment add constraint fk_article_comment
	foreign key (article_no) references tb_article(article_no) on delete cascade;
	
alter table tb_comment add constraint fk_review_comment
	foreign key (review_no) references tb_review(review_no);


drop table if exists tb_report;
create table tb_report (
	report_no			bigint	generated always as identity primary key
	, user_no			bigint	not null
	, target_user_no	bigint	not null
	, article_no		bigint	not null
	, report_cnt		int		not null
	, report_type		char(1)	not null
	, report_date		date	not null
);

alter table tb_report add constraint fk_user_report
	foreign key (user_no) references tb_user(user_no) on delete set null;

alter table tb_report add constraint fk_target_user_report
	foreign key (target_user_no) references tb_user(user_no) on delete cascade;

alter table tb_report add constraint fk_article_report
	foreign key (article_no) references tb_article(article_no)  on delete set null;


drop table if exists tb_comment_like;
create table tb_comment_like (
	cmt_like_no	bigint	generated always as identity primary key
	, cmt_no		bigint	not null
);

alter table tb_comment_like add constraint fk_comment_comment_like
	foreign key (cmt_no) references tb_comment(cmt_no)  on delete cascade;


-- 수형
--게시글
drop table if exists tb_article;
create table tb_article 
(
	article_no				bigint			generated always as identity primary key
	,user_no				bigint			not null
	,article_index_no		char(1)			not null
	,article_content		VARCHAR(65535)	not null
	,article_image			text			default null
	,article_title			varchar(255)
	,article_create_dt		timestamptz		default now()
	,article_mod_dt			timestamptz
	,article_like_count		int				default 0
	,report_cnt				int				default 0
);

--게시글 프로필번호
alter table tb_article add constraint fk_user_article
	foreign key(user_no) references tb_user(user_no) on delete cascade;

--게시글 내용번호
alter table tb_article add constraint fk_article_content_article
	foreign key(article_content_no) references tb_article_content(article_content_no) on delete set null;

--게시글 게시판종류
alter table tb_article add constraint fk_article_index_article
	foreign key(article_index_no) references tb_article_index(article_index_no) on delete cascade;


--게시글 좋아요
drop table if exists tb_article_like;
create table tb_article_like
(
	user_no			bigint	not null
	,article_no		bigint	not null
	,constraint article_like primary key (user_no, article_no)
);

--게시글좋아요 게시글번호
alter table tb_article_like	add constraint fk_article_article_like
	foreign key(article_no) references tb_article(article_no) on delete cascade;


--게시판 종류
drop table if exists tb_article_index;
create table tb_article_index
(
	article_index_no	char(1)	primary key
	,article_index_nm	varchar(10)	not null
);


-- 테이블 추가
drop table if exists tb_user_genre;
create table tb_user_genre (
	user_no		bigint	not null
	,genre_no	bigint	not null
	,constraint user_genre primary key (user_no, genre_no)
);

alter table tb_user_genre	add constraint fk_user_user_genre
	foreign key(user_no) references tb_user(user_no) on delete cascade;

alter table tb_user_genre	add constraint fk_genre_user_genre
	foreign key(genre_no) references tb_genre(genre_no) on delete set null;


drop table if exists tb_user_ott;
create table tb_user_ott (
	user_no		bigint	not null
	,ott_no		bigint	not null
	,constraint user_ott primary key (user_no, ott_no)
);

alter table tb_user_ott	add constraint fk_user_user_ott
	foreign key(user_no) references tb_user(user_no) on delete cascade;

alter table tb_user_ott	add constraint fk_ott_user_ott
	foreign key(ott_no) references tb_ott(ott_no) on delete set null;


drop table if exists tb_content_ott;
create table tb_content_ott
(
	content_no		bigint	not null
	,ott_no			bigint	not null
	,constraint user_ott primary key (content_no, ott_no)
);

-- 테이블 추가
drop table if exists tb_content_poster;
create table tb_content_poster
(
	content_no	bigint	not null
	,poster		text	
	,constraint content_poster primary key (content_no, poster)
);


drop table if exists tb_content_trailer;
create table tb_content_trailer
(
	content_no		bigint	not null
	,trailer		text
	,constraint content_trailer primary key (content_no, trailer)
);


