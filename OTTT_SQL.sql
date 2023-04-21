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
