
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




