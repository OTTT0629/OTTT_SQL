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
);


drop table if exists tb_content_category;
create table tb_content_category
(
	content_no		bigint		not null
	,category_no	smallint	not null
	,constraint content_category_pk primary key (content_no, category_no)
);
   

drop table if exists tb_end_service;
create table tb_end_service
(
	end_service_no	bigint		generated always as identity primary key
	,ott_no			smallint	not null
	,content_no		bigint		not null
	,end_date		date		not null
);
   

drop table if exists tb_ott;
create table tb_ott
(
	ott_no		smallint	primary key
	,ott_nm		varchar(50)	not null
	,ott_img	text		default null
);


-- 주화
drop table if exists tb_watched;
create table tb_watched(
 	user_no			bigint	not null
	,content_no		bigint	not null
	,watched_date	date	default now()
	,constraint watched primary key (user_no, content_no)
);


drop table if exists tb_wishlist;
create table tb_wishlist(
	user_no		bigint	not null
	,content_no	bigint	not null
	,wish_date	date	default now()
	, constraint wishlist primary key (user_no, content_no)
);


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


drop table if exists tb_review_like;
create table tb_review_like
(		
	--리뷰번호
	review_no			bigint			not null	
	
	--프로필번호
	,user_no			bigint			not null
	,constraint review_like primary key (review_no, user_no)
);


drop table if exists tb_content_genre;
create table tb_content_genre
(
	--영상번호 FK
	content_no		bigint		not null
	
	--장르번호 FK
	,genre_no		smallint	not null
	
	,constraint content_genre_pk primary key (content_no, genre_no)
);


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
	,user_id		varchar(20)		unique	not null
	
	--비밀번호
	,user_pwd		varchar(30)		not null
	
	--이름
	,user_nm		varchar(15)		not null
	
	--닉네임
	,user_nicknm	varchar(20)		unique	not null
	
	--성별
	,user_gen		int				not null
	
	--이메일
	,user_email		varchar(150)	unique	not null
	
	--가입일
	,reg_date		timestamptz		default now()
	
	--관리자 여부
	,admin			char(1)			default 'N'
	
	--프로필 이미지
	,image 			text			default 'https://myottt.s3.ap-northeast-2.amazonaws.com/profile/default.jpg'	
		
	--정지여부
	,block_yn		boolean			default false
	
	--카카오 로그인
	,kakao_no		varchar	
);


drop table if exists tb_follow;
create table tb_follow
(
	followers_no 	bigint	not null
	,following_no 	bigint	not null
	,constraint follow primary key (followers_no, following_no)
);


drop table if exists tb_message;
create table tb_message
(
	message_no 			bigint 		  generated always as identity primary key
	,send_user_no		bigint 		  not null
	,receive_user_no	bigint 		  not null
	,content 			varchar(500)  not null
	,send_date			timestamptz	  default now()
	,read_yn			boolean		default false
	,delete_by_sender		boolean		default false
	,delete_by_receiver		boolean		default false
);


drop table if exists tb_message_Box;
create table tb_message_Box
(
	user_no			bigint		not null
	,message_no		bigint		not null
	,constraint message_box primary key (user_no, message_no)
);


drop table if exists tb_search_Word;
create table tb_search_Word
(
	search_word_no	bigint 		 generated always as identity primary key
	,user_no	  	bigint		 not null
	,search_content varchar(50)  not null
);


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


drop table if exists tb_content_entertainer;
create table tb_content_entertainer (
	entertainer_no		bigint	not null
	, content_no		bigint	not null
	, constraint cont_entertainer_no primary key (entertainer_no, content_no)
);


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
	noti_no				bigint	generated always as identity primary key
	, user_no			bigint	not null
	, target_user_no	bigint	not null
	, review_no			bigint
	, article_no		bigint
	, qna_no			bigint
	, noti_check		boolean	default false
	, noti_url			text
	, noti_message		varchar	not null	
);


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
);


drop table if exists tb_report;
create table tb_report (
	user_no				bigint	not null
	, target_user_no	bigint	null
	, article_no		bigint	null
	, review_no			bigint	null
	, cmt_no			bigint	null
	, report_type		char(1)	not null
	, report_date		date	default now()
	, constraint report_user	unique (user_no, target_user_no, report_type)
	, constraint report_article	unique (user_no, article_no, report_type)
	, constraint report_review	unique (user_no, review_no, report_type)
	, constraint report_comment	unique (user_no, cmt_no, report_type)
);


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
);


--게시글 좋아요
drop table if exists tb_article_like;
create table tb_article_like
(
	user_no			bigint	not null
	,article_no		bigint	not null
	,constraint article_like primary key (user_no, article_no)
);


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


drop table if exists tb_user_ott;
create table tb_user_ott (
	user_no		bigint	not null
	,ott_no		bigint	not null
	,constraint user_ott primary key (user_no, ott_no)
);


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
	,thumbnail		text
	,constraint content_trailer primary key (content_no, trailer)
);


drop table if exists tb_report_type;
create table tb_report_type
(
	report_type	char(1)		primary key
	,report_nm	varchar(10)	not null
);


-- 유저 fk 추가
ALTER TABLE tb_follow ADD FOREIGN KEY (follower_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_follow ADD FOREIGN KEY (following_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_watched ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_wishlist ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_user_ott ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_user_genre ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_review ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_review_like ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_search_word ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_report ADD FOREIGN KEY (target_user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_report ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_notification ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_my_diary ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_report ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_message ADD FOREIGN KEY (send_user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_message ADD FOREIGN KEY (receive_user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_article ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_article_like ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_comment ADD FOREIGN KEY (user_no)
REFERENCES tb_user (user_no) on delete cascade;

ALTER TABLE tb_comment ADD FOREIGN KEY (article_no)
REFERENCES tb_article (article_no) on delete cascade; 

ALTER TABLE tb_comment ADD FOREIGN KEY (review_no)
REFERENCES tb_review (review_no) on delete cascade;

ALTER TABLE tb_article_like ADD FOREIGN KEY (article_no)
REFERENCES tb_article (article_no) on delete cascade;

ALTER TABLE tb_review_like ADD FOREIGN KEY (review_no)
REFERENCES tb_review (review_no) on delete cascade;
